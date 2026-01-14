import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyModels{

  Center customTextField({required String label, required TextEditingController controller, required String hintText, required FormFieldValidator<String>? validator,required TextInputType textInputType,required TextCapitalization textCapitalization,required bool readOnly}){
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
              readOnly: readOnly,
              keyboardType: textInputType,
              textCapitalization: textCapitalization,
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


  // --------- contact us fields ---------
  Center customContactUseFields({required TextEditingController controller, required FormFieldValidator<String>? validator, required TextInputType textInputType, required TextCapitalization textCapitalization, required String hintText}){
   return Center(
     child: SizedBox(
       width: 320,
       child: TextFormField(
         controller: controller,
         validator: validator,
         onTapOutside: (outSideTab){
           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
         },
         keyboardType: textInputType,
         textCapitalization: textCapitalization,
         decoration: InputDecoration(
           fillColor: MyColor().whiteClr,
           filled: true,
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
  Column customDropdown<T>({required String label,required String hint,required dynamic value,required dynamic onChanged,required List<DropdownMenuItem<T>> items,required FormFieldValidator<T?>? valid}){
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
        SizedBox(
          width: 320,
          child: DropdownButtonFormField<T>(
            iconEnabledColor: MyColor().primaryClr,
            hint: Text(hint,style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: MyColor().hintTextClr
            ),),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: MyColor().blackClr,
              fontWeight: FontWeight.w500,
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
  Center customSocialMedia({required dynamic prefix, required TextEditingController controller, required String hintText,required String label}) {
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
              onTapOutside: (outSideTap){
                WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
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
                prefixIcon: prefix,

              ),
            ),
          ),
        ],
      ),
    );
}

  // -------------- Comment Field ----------
  Column textFormFieldCommentLimited({required BuildContext context, required String label, required String hintText, required String valid, required dynamic controller,required dynamic keyBoardType, required dynamic textCapitalization,required int maxLines,required int limit }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Sora",
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(
          width: 320,
          child: TextFormField(
            maxLines: maxLines,
            textCapitalization: textCapitalization,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColor().blackClr,
                fontFamily: "Sora"
            ),
            controller: controller,
            onTapUpOutside: (outSideClick){
              FocusManager.instance.primaryFocus!.unfocus();
            },
            validator: (value){
              if(value == null || value.isEmpty){
                return valid;
              }
              return null;
            },
            keyboardType: keyBoardType,
            maxLength: limit,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColor().borderClr.withOpacity(0.15),width: 0.5),
                  borderRadius: BorderRadius.circular(8)
              ),
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
              )
            ),
          ),
        )
      ],
    );
  }

  // ---------- with limited ----
  Center customTextFieldWithLimit({required String label, required TextEditingController controller, required String hintText, required FormFieldValidator<String>? validator,required TextInputType textInputType,required TextCapitalization textCapitalization,required bool readOnly,required int limit}){
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
              maxLength: limit,
              controller: controller,
              validator: validator,
              onTapOutside: (outSideTab){
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              readOnly: readOnly,
              keyboardType: textInputType,
              textCapitalization: textCapitalization,
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

  // --------- with limited & without valid ------------
  Center customTextFieldWithLimitWithoutValid({required String label, required TextEditingController controller, required String hintText,required TextInputType textInputType,required TextCapitalization textCapitalization,required bool readOnly,required int limit}){
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
              maxLength: limit,
              controller: controller,
              onTapOutside: (outSideTab){
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              readOnly: readOnly,
              keyboardType: textInputType,
              textCapitalization: textCapitalization,
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

  // ----- Date & Time UI ---------
  Column customDateAndTimeUi({required TextEditingController controller, required GestureTapCallback onTap,required String label}) {
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
        SizedBox(
          width: 320,
          child: TextField(
            controller: controller,
            readOnly: true,
            style: GoogleFonts.poppins(
                fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().primaryClr
            ),
            decoration: InputDecoration(
              hintText: "Select Date & Time",
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
              hintStyle: GoogleFonts.poppins(
                  fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
              ),
              prefixIcon: Icon(Iconsax.calendar,color: MyColor().borderClr,),

            ),
            onTap: onTap
          ),
        ),
      ],
    );
  }

  Center readyOnlyTextField({required String value,required String label}){
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
              initialValue: value,
              readOnly: true,
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
              ),
            ),
          )
        ],
      ),
    );
  }

}