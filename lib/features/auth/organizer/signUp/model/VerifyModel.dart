import 'dart:io';

import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/organizer/login/ui/OrganizerLoginPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyModel extends StatefulWidget {
  final String mailId;

  const VerifyModel({super.key, required this.mailId});

  @override
  State<VerifyModel> createState() => _VerifyModelState();
}

class _VerifyModelState extends State<VerifyModel> {

  // ---------- deep link -----
  final appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    // ---- when the app is running fetch a deep linking ---------
    appLinks.uriLinkStream.listen((uri){
      handleAppLink(uri);
    });
  }

  // ----- initial deep link ------
  void handleAppLink(Uri uri) async {
    try {

      // -------- this is a your app receiving a uri ----------
      if (uri.host == 'email-verify') {

        final status = uri.queryParameters['status'];

        if (status == 'success') {
          WidgetsBinding.instance.addPostFrameCallback((_) async{

            // ------- after using a context dispose --------
            if(!mounted) return;

            MyModels().alertDialogContentCustom(
              context: context,
              content: Text("Successfully verified",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,color: MyColor().primaryClr,fontSize: 18
              ),),
            );

            await Future.delayed(const Duration(seconds: 2));

            // ------- after using a context dispose --------
            if(!mounted) return;

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>OrganizerLoginPage(whichScreen: 'org')), (route)=> false);
            }

          });

        }
      }
    } catch (e, stackTrace) {
      FlutterToast().flutterToast("App link error", ToastificationType.error, ToastificationStyle.flat);
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
          ],
        ),
      ),
    );
  }
}
