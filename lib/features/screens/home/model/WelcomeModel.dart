import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeModel extends StatefulWidget {
  const WelcomeModel({super.key});

  @override
  State<WelcomeModel> createState() => _WelcomeModelState();
}

class _WelcomeModelState extends State<WelcomeModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // color: MyColor().primaryClr.withOpacity(0.15),
            // offset: const Offset(0, 8),   // ⬇ Push shadow to bottom
            // blurRadius: 4,
            // spreadRadius: 0,
          ),
        ],
          border: Border(bottom: BorderSide(color: MyColor().primaryClr.withOpacity(0.15))),
          color: MyColor().boxInnerClr,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(44),bottomLeft: Radius.circular(44))
      ),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Welcome ",style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),),
                Text(
                  "Krish!",style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: MyColor().primaryClr,
                  fontWeight: FontWeight.w600,
                ),),
              ],
            ),
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 14),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: MyColor().locationClr,
                      borderRadius: BorderRadius.circular(44)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text("Coimbatore, India",style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColor().locationClr,
                    shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.notifications,size: 24,),
                  ),
                )
              ],
            ),
            // Search Bar
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 16),
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
            )
          ],
        ),
      )
    );
  }
}
