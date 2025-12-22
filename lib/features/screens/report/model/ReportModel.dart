import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReportModel extends StatefulWidget {
  const ReportModel({super.key});

  @override
  State<ReportModel> createState() => _ReportModelState();
}

class _ReportModelState extends State<ReportModel> {

  // ------- Controller -------
  final nameController = TextEditingController();
  final reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: [

          // ------- text ------
          Center(
            child: Text(
              textAlign: TextAlign.center,
              ConfigMessage().reportMsg,style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().borderClr
            ),),
          ),

          // ----------- Upload Image --------
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(25),
                strokeWidth: 1,
                strokeCap: StrokeCap.butt,
                color: MyColor().borderClr.withOpacity(0.50),
                dashPattern: [
                  7.7
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Iconsax.gallery_add,size: 40,),
                      Container(
                        height: 48,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Iconsax.document_upload_copy,size: 20,),
                              SizedBox(width: 5,),
                              Text("Upload image",style: GoogleFonts.poppins(
                                fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                              ),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ----------- Name Field -------
          SizedBox(height: 20,),
          MyModels().customTextField(label: "Your Name", controller: nameController, hintText: "Name", validator: Validators().validName),
          SizedBox(height: 20,),
          
          // ---------- Report Problem Field ---------
          MyModels().textFormFieldCommentLimited(context: context, label: "Report your problem", hintText: "Submit Your Problem", valid: "Please enter your problem", controller: reportController, keyBoardType: TextInputType.multiline, textCapitalization: TextCapitalization.sentences, maxLines: 5, limit: 1500),
          
          // -------- Send button ---------
          SizedBox(height: 20,),
          MyModels().customButton(onPressed: (){}, title: "Submit")

        ],
      ),
    );
  }
}
