import 'dart:ui' as ui;

import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/chechUser/model/ChechUserModel.dart';
import 'package:all_college_event_app/features/auth/organizer/login/ui/OrganizerLoginPage.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class CheckUserPage extends StatefulWidget {
  const CheckUserPage({super.key});

  @override
  State<CheckUserPage> createState() => _CheckUserPageState();
}

class _CheckUserPageState extends State<CheckUserPage> {


  final appLink = AppLinks();



  @override
  void initState() {
    super.initState();
    // -------- when the app receiving a deep link ---------
    appLink.uriLinkStream.listen((uri){
      handleAppLink(uri);
    });
  }


  // ------ deep link ---------
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
              content: const Text("Successfully verified"),
            );

            await Future.delayed(const Duration(seconds: 2));

            // ------- after using a context dispose --------
            if(!mounted) return;

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> OrganizerLoginPage(whichScreen: 'org')), (route)=> false);
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        body: CheckUserModel()
      ),
    );
  }
}