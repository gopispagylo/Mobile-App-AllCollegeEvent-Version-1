import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsModel extends StatefulWidget {
  const ContactUsModel({super.key});

  @override
  State<ContactUsModel> createState() => _ContactUsModelState();
}

class _ContactUsModelState extends State<ContactUsModel> {

  // ------------ controller -----------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final yourCommentController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    yourCommentController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
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
              Image.asset(ImagePath().contactUs,height: 170)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColor().boxInnerClr,
            borderRadius: BorderRadiusGeometry.circular(16),
            border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
          ),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                // ------- name --------
                Container(
                    child: MyModels().customContactUseFields(controller: nameController, validator: Validators().validName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, hintText: "Name")),

                // ------- email --------
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: MyModels().customContactUseFields(controller: emailController, validator: Validators().validName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, hintText: "Email")),
                
                
                // ------- description --------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: SizedBox(
                      width: 320,
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                            fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                        ),
                        controller: yourCommentController,
                        maxLines: 5,
                        validator: Validators().validComment,
                        onTapOutside: (outSideTab){
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        },
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
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
                          hintText: "Your Message",
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: MyColor().hintTextClr
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ---------- submit ---------
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: MyModels().customButton(onPressed: yourCommentController.text.isNotEmpty ? (){} : null , title: "Submit")),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 
