import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/myEventBloc/my_event_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class MyEventsModel extends StatefulWidget {
  const MyEventsModel({super.key});

  @override
  State<MyEventsModel> createState() => _MyEventsModelState();
}

class _MyEventsModelState extends State<MyEventsModel> {

  // ------ Switch Value --------
  bool checkStatus = false;


  // -------- Filter list ------
  final List<String> filterList = [
    "completed events",
    "Published events",
    "Draft events",
    "Pending Events",
    "Rejected events"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MyEventBloc(apiController: ApiController())..add(FetchMyEvent()),
      child: Scaffold(
        backgroundColor: MyColor().whiteClr,
        appBar: AppBar(
          backgroundColor: MyColor().whiteClr,
          title: Text(
            "My Events",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
        ),
        body: Column(
          children: [

            // ---------- search bar for event ---------
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                width: 380,
                child: TextFormField(
                  onTapOutside: (onChanged) {
                    WidgetsBinding.instance.focusManager.primaryFocus!
                        .unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: MyColor().borderClr,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: MyColor().primaryClr,
                        width: 0.5,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, size: 24),
                    hintText: "Search Events",
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: MyColor().hintTextClr,
                    ),
                  ),
                ),
              ),
            ),

            // ---- filter ------
            Container(
              margin: EdgeInsets.only(left: 16,top: 16,bottom: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.tune,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(filterList.length, (index){
                          return Container(
                            height: 48,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20,right: 20),
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                            ),
                            child: Row(
                              children: [
                                Text(filterList[index],style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().blackClr,

                                ),),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ----------- event list -------------
            Expanded(
              child: BlocBuilder<MyEventBloc, MyEventState>(
                builder: (context, myEventState) {
                  if(myEventState is MyEventLoading){
                    return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                  } else if(myEventState is MyEventSuccess){
                    return RefreshIndicator(
                      onRefresh: () async{
                        context.read<MyEventBloc>().add(FetchMyEvent());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 20,),
                        child: ListView.builder(
                          itemCount: myEventState.myEvent.length,
                          itemBuilder: (context, index) {
                            final list = myEventState.myEvent[index];

                            // -------- field name ------------
                            final title = list['title'] ?? "No title";

                            final featuredImagePath =
                            (list['bannerImages'] != null &&
                                list['bannerImages'].isNotEmpty)
                                ? list['bannerImages'][0]
                                : '';

                            // ------ date format -------
                            final rawDate = list['calendars'][0]['startDate'];


                            String parsedDate;

                            try {
                              parsedDate = DateFormat('dd MMM yy').format(
                                  DateTime.parse(rawDate));
                            } catch (e) {
                              parsedDate = rawDate;
                            }


                            // -------- event mode ------
                            final mode = list['mode'];

                            // ------- status -------
                            final status = list['status'];

                            String? finalStatus;
                            Color? statusColor;

                            if(status == "DRAFT"){
                              finalStatus = "Draft";
                            }else if(status == 'PENDING'){
                              finalStatus = "Pending";
                            }else if(status == 'APPROVED'){
                              finalStatus = "Approved";
                            }else if(status == 'REJECTED'){
                              finalStatus = "Rejected";
                            }else if(status == 'PRIVATE'){
                              finalStatus = "Private";
                            }

                            if(status == "DRAFT"){
                              statusColor = MyColor().blueClr.withOpacity(0.20);
                            }else if(status == 'PENDING'){
                              statusColor = MyColor().yellowClr.withOpacity(0.20);
                            }else if(status == 'APPROVED'){
                              statusColor = MyColor().blueClr.withOpacity(0.20);
                            }else if(status == 'REJECTED'){
                              statusColor = MyColor().redClr.withOpacity(0.20);
                            }else if(status == 'PRIVATE'){
                              statusColor = MyColor().greenClr.withOpacity(0.20);
                            }


                            final location = mode == 'ONLINE' ? 'Online' : list['location']['city'] ?? "no city";



                            // -------- identity ---------
                            final identity = list['slug'];
                            final paymentLink = list['paymentLink'];

                            // ------- Tween Animation -----------
                            return TweenAnimationBuilder(
                              tween: Tween(begin: 50.0, end: 0.0),
                              duration: Duration(milliseconds: 600),
                              builder: (context, value, child) {
                                return Transform.translate(offset: Offset(0, value),
                                    child: Opacity(
                                      opacity: 1 - (value / 50),
                                      child: child,)
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(pageBuilder: (_,__,___)=> EventDetailPage(identity: identity, title: title, whichScreen: 'edit', paymentLink: paymentLink,),
                                          transitionsBuilder: (_, animation, __, child){
                                            return SlideTransition( position: Tween(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                              child: child,);
                                          }
                                      )
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 0, bottom: 16),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: MyColor().whiteClr,
                                    border: Border.all(
                                      color: MyColor().borderClr.withOpacity(0.15),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(9),
                                            child: CachedNetworkImage(
                                              imageUrl: featuredImagePath,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),),
                                              errorWidget: (context, url, error) => Icon(Iconsax.gallery),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(title,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                                                fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                              )),
                                              SizedBox(height: 5),

                                              // -------- calendar --------
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.calendar_month, size: 14),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          parsedDate,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: statusColor,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Text(
                                                      finalStatus!,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: MyColor().blackClr,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              SizedBox(height: 5),

                                              // -------- online ---------
                                              Row(
                                                children: [
                                                 mode == 'OFFLINE' ? Icon(Icons.location_on_outlined, size: 14) : Container(
                                                   height: 8,
                                                   width: 8,
                                                   decoration: BoxDecoration(
                                                   color: MyColor().greenClr,
                                                   shape: BoxShape.circle
                                                 ),),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      location,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // -------- edit -------
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(pageBuilder: (_,__,___)=> EventDetailPage(identity: identity, title: title, whichScreen: 'edit', paymentLink: paymentLink,),
                                                              transitionsBuilder: (_, animation, __, child){
                                                                return SlideTransition( position: Tween(
                                                                  begin: const Offset(1, 0),
                                                                  end: Offset.zero,
                                                                ).animate(animation),
                                                                  child: child,);
                                                              }
                                                          )
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(bottom: 5,top: 5,left: 15,right: 15),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        border: Border.all(color: MyColor().primaryClr)
                                                      ),
                                                      child: Text("Edit",style: GoogleFonts.poppins(
                                                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().primaryClr
                                                      ),),
                                                    ),
                                                  ),
                                                  Transform.scale(
                                                    scale: 0.6,
                                                    child: Switch(value: checkStatus, onChanged: (onChanged){
                                                      setState(() {
                                                        checkStatus = onChanged;
                                                      });
                                                    }),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if(myEventState is MyEventFail){
                    return RefreshIndicator(
                      onRefresh: () async{
                        context.read<MyEventBloc>().add(FetchMyEvent());
                      },
                      child: Center(
                        child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: SizedBox(
                    height: 250,
                    child: Image.asset(ImagePath().errorMessageImg),
                  ),
                ),
                Center(
                  child: Text(
                    "No Results Found",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: MyColor().blackClr,
                    ),
                  ),
                ),
              ],
                        ),
                      ),
                    );
                  } return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------
