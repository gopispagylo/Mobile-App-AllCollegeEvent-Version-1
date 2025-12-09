import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class ProfileModel extends StatefulWidget {
  const ProfileModel({super.key});

  @override
  State<ProfileModel> createState() => _ProfileModelState();
}

class _ProfileModelState extends State<ProfileModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Center(
        child: Text("THIS IS A PROFILE PAGE",style: TextStyle(),),
      ),
    );
  }
}
