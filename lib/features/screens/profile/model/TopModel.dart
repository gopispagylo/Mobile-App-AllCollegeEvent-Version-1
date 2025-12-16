import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopModel extends StatefulWidget {
  const TopModel({super.key});

  @override
  State<TopModel> createState() => _ProfileModelState();
}

class _ProfileModelState extends State<TopModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(textAlign: TextAlign.center,"Vanisree M",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: "blMelody",
          ),),
          SizedBox(height: 2,),
          Text(textAlign: TextAlign.center,"Organizer",style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: MyColor().borderClr
          ),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Column(
                    children: [
                      Text("2K",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColor().primaryClr
                        ),
                      ),
                      Text("Followers",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: MyColor().blackClr
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Column(
                    children: [
                      Text("1K",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: MyColor().primaryClr
                      ),),
                      Text("Following",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: MyColor().blackClr
                      ),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Column(
                    children: [
                      Text("2nd",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: MyColor().primaryClr
                      ),),
                      Text("Rank",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: MyColor().blackClr
                      ),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Column(
                    children: [
                      Text("546",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: MyColor().primaryClr
                      ),),
                      Text("Reviews",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: MyColor().blackClr
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
