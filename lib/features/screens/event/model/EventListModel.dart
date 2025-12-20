import 'package:all_college_event_app/features/screens/event/model/ListModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventListModel extends StatefulWidget {
  const EventListModel({super.key});

  @override
  State<EventListModel> createState() => _EventListModelState();
}

class _EventListModelState extends State<EventListModel> {

  List<String> filterString = [
    "All","Ongoing","Trending","Upcoming"
  ];


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
                onTapOutside: (onChanged){
                  WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
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
                  suffixIcon: GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColor().locationClr,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Icon(
                          Icons.tune,
                        ),
                      ),
                    ),
                  ),
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
          margin: EdgeInsets.only(left: 16,right: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(filterString.length, (index){
                return Container(
                  height: 48,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr
                  ),
                  child: Text(filterString[index],style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColor().blackClr,

                  ),),
                );
              }),
            ),
          ),
        ),
        Expanded(child: ListModel())
      ],
    );
  }
}
