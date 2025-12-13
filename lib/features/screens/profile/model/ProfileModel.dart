import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
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
        child: GestureDetector(
            onTap: () async{
              print("010101010101010110100101010101");
              DBHelper db = DBHelper();
              await db.deleteAllLoginData();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CheckUserPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Sign Out",style: TextStyle(),),
            )),
      ),
    );
  }
}
