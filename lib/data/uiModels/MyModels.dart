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

  // --------- TextField Password ---------
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

  // ----------- Custom Dropdown ------------
  Column customDropdown({required String label,required String hint,required dynamic value,required dynamic onChanged,required List<DropdownMenuItem<String>> items,required FormFieldValidator<String?> valid}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Text(label,style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),),
        ),
        DropdownButtonFormField<String>(
          iconEnabledColor: MyColor().primaryClr,
          hint: Text(hint,style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: MyColor().hintTextClr
          ),),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: MyColor().primaryClr,
            fontWeight: FontWeight.w600,
          ),
          iconDisabledColor: MyColor().blackClr,
          value: value,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.arrow_drop_down,),
            ),
            // iconColor: MyColor().primaryClr,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyColor().borderClr, width: 0.5)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyColor().primaryClr, width: 0.5)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
            ),
          ),
          onChanged: onChanged,
          items: items,
          validator: valid,
        ),
      ],
    );
  }

  void alertDialogCustomizeEdit(
      BuildContext context,
      String title,
      Widget text,
      dynamic buttonExit,
      dynamic buttonCancel,
      String leadingText,
      String actionText,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // Full width
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: MyColor().blackClr
                  )
                ),
                const SizedBox(height: 10),
                text,
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: buttonExit,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MyColor().primaryClr, width: 1),
                            color: Colors.white,
                          ),
                          child: Text(
                            leadingText,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColor().primaryClr
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: buttonCancel,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColor().primaryClr,
                          ),
                          child: Text(
                            actionText,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColor().whiteClr
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // -------- Custom Dialog with content ---------
  void alertDialogContentCustom({required BuildContext context,required Widget content}) async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: content,
        backgroundColor: MyColor().whiteClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
    });
  }

  // -------- Social Media Field -----------
  SizedBox customSocialMedia({required dynamic prefix, required TextEditingController controller, required String hintText,}) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        controller: controller,
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
          prefixIcon: prefix,

        ),
      ),
    );
}

  // -------- Button ----------
  ElevatedButton customButton({required dynamic onPressed,required String title}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(320, 48),
        backgroundColor: MyColor().primaryClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: MyColor().whiteClr,
        ),
      ),
    );
  }
}