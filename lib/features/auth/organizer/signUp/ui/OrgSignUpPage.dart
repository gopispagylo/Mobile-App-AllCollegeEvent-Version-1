import 'package:all_college_event_app/features/auth/organizer/signUp/model/OrgCategoriesModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class OrgSignUpPage extends StatefulWidget {
  final String type;

  const OrgSignUpPage({super.key, required this.type});

  @override
  State<OrgSignUpPage> createState() => _OrgSignUpPageState();
}

class _OrgSignUpPageState extends State<OrgSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Center(child: OrgCategoriesModel(type: widget.type,)),
    );
  }
}
