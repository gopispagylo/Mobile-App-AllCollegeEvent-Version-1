import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OrganizationHeaderModel extends StatefulWidget {
  const OrganizationHeaderModel({super.key});

  @override
  State<OrganizationHeaderModel> createState() => _OrganizationHeaderModelState();
}

class _OrganizationHeaderModelState extends State<OrganizationHeaderModel> {

  // --------- tab bar index -------
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [

          // ----- title ------
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: MyColor().primaryClr,
                  shape: BoxShape.circle
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Text('Swaram Academy',style: GoogleFonts.poppins(
                  fontSize: 18,fontWeight: FontWeight.w600,color: MyColor().blackClr
                ),),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: MyColor().primaryClr,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Follow",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().whiteClr
                  ),))
            ],
          ),

          // ----- rank card ---------
         Container(
           margin: EdgeInsets.only(top: 20),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: MyColor().primaryBackgroundClr.withOpacity(0.40),

                     ),
                     child: Column(
                       children: [
                         Icon(Iconsax.ticket_copy,color: MyColor().primaryClr,),
                         SizedBox(height: 5,),
                         Text('1725 Events',style: GoogleFonts.poppins(
                           fontWeight: FontWeight.w500,color: MyColor().blackClr,
                           fontSize: 12
                         ),)
                       ],
                     ),
                   )
                 ],
               ),

               Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: MyColor().yellowClr.withOpacity(0.15),
                     ),
                     child: Column(
                       children: [
                         Icon(Icons.star,color: MyColor().yellowClr,),
                         SizedBox(height: 5,),
                         Text('4.9/2508 reviews',style: GoogleFonts.poppins(
                           fontSize: 12,color: MyColor().blackClr,fontWeight: FontWeight.w500,
                         ),)
                       ],
                     ),
                   )
                 ],
               ),

               Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: MyColor().primaryBackgroundClr.withOpacity(0.40),
                     ),
                     child: Column(
                       children: [
                         Icon(Iconsax.ranking_1,color: MyColor().primaryClr,),
                         SizedBox(height: 5,),
                         Text('1725 Events',style: GoogleFonts.poppins(
                           fontSize: 12,color: MyColor().blackClr,fontWeight: FontWeight.w500,
                         ))
                       ],
                     ),
                   )
                 ],
               ),
             ],
           ),
         ),


          // ------- Upcoming & Past events
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20,),
              decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: customTabBar(title: 'Upcoming Events', index: 0)),
                  Expanded(child: customTabBar(title: 'Past Events', index: 1)),
                ],
              ),
            ),
          ),

          // --------- Upcoming & Past event ui
          selectedIndex == 0 ? Column(
            children: [
              BlocBuilder<EventListBloc, EventListState>(
                builder: (context, eventListState) {
                  if (eventListState is EventListLoading) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return eventCardShimmer();
                      },
                    );
                  }
                  else if (eventListState is EventSuccess) {
                    return Container(
                      margin: EdgeInsets.only(top: 20,),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: eventListState.eventList.length,
                        itemBuilder: (context, index) {
                          final list = eventListState.eventList[index];

                          // -------- field name ------------
                          final title = list['title'] ?? "No title";
                          final featuredImagePath = list['bannerImage'] ?? '';


                          // ------ date format -------
                          final rawDate = list['eventDate']?.toString() ?? "";

                          // 2. Safe Date Parsing
                          String dateFormat = "Date TBD";

                          if (rawDate.isNotEmpty) {
                            try {
                              // Use MM for months!
                              final parsedDate = DateFormat('dd/MM/yyyy').parse(rawDate);
                              dateFormat = DateFormat('dd MMM yyyy').format(parsedDate);
                            } catch (e) {
                              debugPrint("Date parsing error: $e");
                              dateFormat = rawDate; // Fallback to raw string if parsing fails
                            }
                          }

                          // ---- venue ---
                          final venue = list['venue'] ?? "no venue";

                          // -------- identity ---------
                          final identity = list['identity'];

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
                                    PageRouteBuilder(pageBuilder: (_,__,___)=> EventDetailPage(identity: identity, title: title),
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
                                        height: 110,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: CachedNetworkImage(
                                          imageUrl: featuredImagePath,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.image_not_supported),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    title,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Row(
                                                  children: [
                                                    circleIcon(Icons.favorite_border),
                                                    SizedBox(width: 5),
                                                    circleIcon(Icons.bookmark_outline),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                chip(
                                                  "Paid",
                                                  MyColor().primaryBackgroundClr
                                                      .withOpacity(0.35),
                                                ),
                                                chip(
                                                  "Entertainment",
                                                  MyColor().blueBackgroundClr.withOpacity(
                                                    0.35,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month, size: 14),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    dateFormat,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined, size: 14),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    venue,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: MyColor().primaryBackgroundClr
                                                        .withOpacity(0.35),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    "Ongoing",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColor().blackClr,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                    );
                  }
                  else if (eventListState is EventFail) {
                    return Center(
                      child: Column(
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
                    );
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ) :
          Column(
            children: [
              SizedBox(height: 20,),
              GridView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Stack(
                        children: [
                          
                          // -------- image -------
                          Positioned.fill(
                              child: Image.asset(ImagePath().authForgetImg, fit: BoxFit.cover,)),
                          
                          // First gradient
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Second stronger gradient
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.95),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 12,
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Inter college Cricket Tournament",style:GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,color: MyColor().whiteClr,fontSize: 12
                                  ),),
                                  SizedBox(height: 5,),
                                  Text("700K views",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,color: MyColor().whiteClr,fontSize: 12
                                  ),),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16,childAspectRatio: 0.6))
            ],
          ),

          // ------- social media -------
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.instagram),
                      Icon(Iconsax.instagram),
                      Icon(Iconsax.instagram),
                      Icon(Iconsax.instagram),
                      Icon(Iconsax.instagram),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: MyColor().borderClr.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.add_copy),
                              Container(
                                child: Text("Follow"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: MyColor().borderClr.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share),
                              Container(
                                child: Text("Share"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // --------- Custom Tab Bar --------------
  Widget customTabBar({required String title, required int index}){
    final selectedValue = selectedIndex == index;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: !selectedValue ? MyColor().boxInnerClr : MyColor().blueClr.withOpacity(0.15)
        ),
        child: Text(title,style: GoogleFonts.poppins(
            fontSize: 12,fontWeight: FontWeight.w600,color: MyColor().blackClr
        ),),
      ),
    );
  }

  // --------- Dummy Button ---------
  Widget chip(String text, Color bg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }

  // --------- Fav & Add to cart Icon ---------
  Widget circleIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
        color: MyColor().boxInnerClr,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 15),
    );
  }

  // ---------- Skeleton loading ui model -------
  Widget eventCardShimmer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16,top: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          // Image shimmer
          Expanded(
            flex: 2,
            child: Shimmer(
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Content shimmer
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + icons
                Row(
                  children: [
                    Expanded(
                      child: Shimmer(
                        child: Container(
                          width: double.infinity,
                          height: 14,
                          decoration: BoxDecoration(
                            color: MyColor().sliderDotClr,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Shimmer(
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Shimmer(
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Chips
                Row(
                  children: [
                    Shimmer(
                      child: Container(
                        width: 50,
                        height: 18,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Shimmer(
                      child: Container(
                        width: 90,
                        height: 18,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Date
                Shimmer(
                  child: Container(
                    width: 160,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Location + status
                Row(
                  children: [
                    Expanded(
                      child: Shimmer(
                        child: Container(
                          width: double.infinity,
                          height: 12,
                          decoration: BoxDecoration(
                            color: MyColor().sliderDotClr,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    Shimmer(
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
