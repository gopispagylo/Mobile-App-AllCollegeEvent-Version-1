import 'package:all_college_event_app/features/screens/profile/model/MySpaceModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/ProfileModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/TopModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: ListView(
        children: [
          TopModel(),

          // ---------- Profile model ----------
          ProfileModel(),

          // ----------- My Space --------
          MySpaceModel(),
        ],
      ),
    );
  }
}
