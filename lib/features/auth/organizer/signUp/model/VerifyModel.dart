import 'dart:io';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyModel extends StatefulWidget {
  final String mailId;

  const VerifyModel({super.key, required this.mailId});

  @override
  State<VerifyModel> createState() => _VerifyModelState();
}

class _VerifyModelState extends State<VerifyModel> {

  // -------- open gmail ----------
  Future<void> openGmail() async {
    if (Platform.isAndroid) {
      // await openGmailApp();
    } else if (Platform.isIOS) {
      final Uri gmailUri = Uri.parse('googlegmail://');
      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(
          Uri.parse('https://mail.google.com/'),
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Container(
        margin: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Image.asset(
                  ImagePath().allCollegeEventLogoPng),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("Verify your Account",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColor().blackClr
                ),),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(textAlign: TextAlign.center,
                "Link has been sent to your ${widget.mailId} domain mail id. Please click and verify your account.",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColor().borderClr
                ),),
            ),

            SizedBox(height: 20,),

            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 48),
                      elevation: 0,
                      backgroundColor: MyColor().primaryClr,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(50)
                      )
                  ),
                  onPressed: () async{
                    // if (!result.didOpen) {
                    //   showNoMailAppsDialog(context);
                    // }
                   await openGmail();
                  }, child: Text("Open gmail",style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MyColor().whiteClr
              ),)),
            ),
          ],
        ),
      ),
    );
  }
}
