import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyModels{

  Center customTextField({required String label, required TextEditingController controller, required String hintText, required FormFieldValidator<String>? validator}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(label,style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),),
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: controller,
              validator: validator,
              onTapOutside: (outSideTab){
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().redClr,width: 0.5)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: MyColor().hintTextClr
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center customTextFieldPassword({required String label, required TextEditingController controller, required String hintText, required FormFieldValidator<String>? errorText, required bool obscureText, required Widget eyeIcon}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(label,style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),),
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: controller,
              validator: errorText,
              obscureText: obscureText,
              onTapOutside: (outSideTab){
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColor().redClr,width: 0.5)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: MyColor().redClr, width: 0.5)
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: MyColor().hintTextClr
                ),
                suffixIcon: eyeIcon,
              ),
            ),
          )
        ],
      ),
    );
  }

}