import 'package:all_college_event_app/features/screens/home/model/LocationModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
          gradient: LinearGradient(colors: [
            MyColor().primaryBackgroundClr,
            MyColor().whiteClr
          ],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,

          )
      ),
      child: Container(
        margin: EdgeInsets.only(top: 35,left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Krish!",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: MyColor().primaryClr,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    // Location
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> LocationModel()));
                          },
                          child: Row(
                            children: [
                              Icon(Iconsax.location_copy, size: 18),
                              SizedBox(width: 5,),
                              Text(
                                "Coimbatore, India",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: MyColor().primaryClr,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: MyColor().locationClr,
                    shape: BoxShape.circle,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.notifications, size: 18),
                  ),
                ),
              ],
            ),
            // Search Bar
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 16,right: 16),
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: MyColor().primaryClr,
                        width: 0.5,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, size: 18),
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
          ],
        ),
      ),
    );
  }
}
