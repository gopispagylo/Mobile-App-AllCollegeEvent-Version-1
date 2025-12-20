import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
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
  // ------- find user assign the value ------
  String? checkUser;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  // ------- find a user --------
  Future<void> getUser() async {
    String? user = await DBHelper().getUser();
    // checkUser = await DBHelper().getUser();
    setState(() {
      checkUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: MyColor().primaryClr),
        ),
      );
    }
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: ListView(
        children: [

          // ------- Profile Header -------
          TopModel(whichScreen: checkUser!),

          // ---------- Profile model ----------
          ProfileModel(whichScreen: checkUser!,),

          // ----------- My Space --------
          MySpaceModel(whichScreen: checkUser!,),
        ],
      ),
    );
  }
}
