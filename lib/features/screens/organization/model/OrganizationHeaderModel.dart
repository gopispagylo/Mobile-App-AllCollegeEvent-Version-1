import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrganizationHeaderModel extends StatefulWidget {
  const OrganizationHeaderModel({super.key});

  @override
  State<OrganizationHeaderModel> createState() => _OrganizationHeaderModelState();
}

class _OrganizationHeaderModelState extends State<OrganizationHeaderModel> {
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
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("+ Follow",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                  ),))
            ],
          ),

          // ----- rank card ---------
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColor().primaryBackgroundClr,

                ),
                child: Column(
                  children: [
                    Icon(Iconsax.ticket),
                    Text('1725 Events')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
