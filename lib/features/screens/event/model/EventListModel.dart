import 'package:all_college_event_app/features/screens/event/model/ListModel.dart';
import 'package:all_college_event_app/features/screens/global/ui/filter/FilterPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/globalUnFocus/GlobalUnFocus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EventListModel extends StatefulWidget {
  const EventListModel({super.key});

  @override
  State<EventListModel> createState() => _EventListModelState();
}

class _EventListModelState extends State<EventListModel> {

  // ------ filter --------
  List<String> filterString = [
    "All","Ongoing","Trending","Upcoming"
  ];

  // -------- controller --------
  final searchController = TextEditingController();


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // ----------- search bar ----------
        Center(
          child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 16,left: 16,right: 16),
              width: 380,
              child: TextFormField(
                focusNode: GlobalUnFocus.focusNode,
                controller: searchController,
                onTapOutside: (onChanged){
                  GlobalUnFocus.unFocus();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                  ),
                  prefixIcon: Icon(Icons.search,size: 24,),
                  // suffixIcon: GestureDetector(
                  //   onTap: (){
                  //
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(5),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           color: MyColor().locationClr,
                  //           borderRadius: BorderRadius.circular(100)
                  //       ),
                  //       child: Icon(
                  //         Icons.tune,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  hintText: "Search Events",
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: MyColor().hintTextClr
                  ),
                ),
              )),
        ),

        Container(
          margin: EdgeInsets.only(left: 16,right: 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=> FilterPage(),
                  transitionsBuilder: (_, animation, __, child){
                    return SlideTransition(position: Tween(
                      begin: Offset(-1, 0),
                      end: Offset.zero
                    ).animate(animation),child: child,);
                  }
                  ));
                },
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
                    children: List.generate(filterString.length, (index){
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
                            Text(filterString[index],style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColor().blackClr,
                            
                            ),),
                            SizedBox(width: 10,),
                            GestureDetector(
                                onTap: (){
                                  // filterString.removeAt(index);
                                },
                                child: Icon(Iconsax.close_circle_copy,color: MyColor().borderClr,))
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

        Expanded(child: ListModel())

      ],
    );
  }
}
