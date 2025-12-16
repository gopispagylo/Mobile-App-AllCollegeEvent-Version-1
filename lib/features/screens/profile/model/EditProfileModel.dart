import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/model/ResetPasswordModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileModel extends StatefulWidget {
  const EditProfileModel({super.key});

  @override
  State<EditProfileModel> createState() => _EditProfileModelState();
}

class _EditProfileModelState extends State<EditProfileModel> {

  // -------- Controller ---------
  final nameController = TextEditingController();
  final domainMailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
          backgroundColor: MyColor().whiteClr,
          title: Text("Edit Profile",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
          ),),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                shape: BoxShape.circle
              ),
            ),
            MyModels().customTextField(label: "Full Name", controller: nameController, hintText: "Enter your full name", validator: Validators().validName),
            SizedBox(height: 20,),
            MyModels().customTextField(label: "Domain Email ID", controller: domainMailController, hintText: "Enter your domain mail id", validator: Validators().validDomainMail),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> ResetPasswordModel()));
              },
              child: Container(
                width: 320,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 12),
                child: Text("Forgot Password?",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  color: MyColor().primaryClr
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
