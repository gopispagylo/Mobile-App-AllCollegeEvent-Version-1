import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsModel extends StatefulWidget {
  const ContactUsModel({super.key});

  @override
  State<ContactUsModel> createState() => _ContactUsModelState();
}

class _ContactUsModelState extends State<ContactUsModel> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 16),
            child: Row(

              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ConfigMessage().contactUsTitle,style: GoogleFonts.poppins(
                        fontSize: 18,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                      ),),
                      Text(textAlign: TextAlign.left,ConfigMessage().contactUsContent,style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,color: MyColor().blackClr,fontSize: 14
                      ),),
                    ],
                  ),
                ),
                Image.asset(ImagePath().yourJourneyImg,height: 200)
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: MyColor().boxInnerClr,
          //     borderRadius: BorderRadiusGeometry.circular(8),
          //     border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
          //   ),
          //   child: SizedBox(
          //     width: 320,
          //     child: TextFormField(
          //       controller: controller,
          //       validator: validator,
          //       onTapOutside: (outSideTab){
          //         WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          //       },
          //       readOnly: readOnly,
          //       keyboardType: textInputType,
          //       textCapitalization: textCapitalization,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.all(10),
          //         enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(12),
          //             borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(12),
          //             borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
          //         ),
          //         errorBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(12),
          //             borderSide: BorderSide(color: MyColor().redClr,width: 0.5)
          //         ),
          //         focusedErrorBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(12),
          //             borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
          //         ),
          //         hintText: hintText,
          //         hintStyle: GoogleFonts.poppins(
          //             fontWeight: FontWeight.w400,
          //             fontSize: 12,
          //             color: MyColor().hintTextClr
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
} 
