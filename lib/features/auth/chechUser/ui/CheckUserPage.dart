import 'package:all_college_event_app/features/auth/chechUser/model/ChechUserModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckUserPage extends StatefulWidget {
  const CheckUserPage({super.key});

  @override
  State<CheckUserPage> createState() => _CheckUserPageState();
}

class _CheckUserPageState extends State<CheckUserPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckUserModel()
    );
  }
}