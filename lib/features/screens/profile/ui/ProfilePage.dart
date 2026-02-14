import 'dart:io';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/MySpaceModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/ProfileModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/TopModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final bool isLogin;
  final String whichScreen;

  const ProfilePage({
    super.key,
    required this.isLogin,
    required this.whichScreen,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ------- find user assign the value ------
  String? checkUser;
  String slug = "";
  @override
  void initState() {
    super.initState();
    getUser();
  }

  // ------- find a user --------
  Future<void> getUser() async {
    String? user = await DBHelper().getUser();
    setState(() {
      checkUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkUser == null) {
      return Scaffold(
        body: Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator(color: MyColor().primaryClr)
              : CupertinoActivityIndicator(color: MyColor().primaryClr),
        ),
      );
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserProfileBloc(apiController: ApiController())
                ..add(ClickedUserProfile(whichUser: checkUser!, id: '')),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: MyColor().whiteClr,
            body: widget.isLogin
                ? RefreshIndicator(
                    edgeOffset: 20,
                    backgroundColor: MyColor().whiteClr,
                    color: MyColor().primaryClr,
                    onRefresh: () async {
                      context.read<UserProfileBloc>().add(
                        ClickedUserProfile(whichUser: checkUser!, id: ''),
                      );
                    },
                    child: ListView(
                      children: [
                        // ------- Profile Header -------
                        TopModel(
                          whichScreen: checkUser!,
                          onSlugChanged: (value) {
                            setState(() {
                              slug = value;
                            });
                          },
                        ),

                        // ---------- Profile model ----------
                        ProfileModel(
                          whichScreen: checkUser!,
                          isLogin: widget.isLogin,
                        ),

                        // ----------- My Space --------
                        MySpaceModel(
                          whichScreen: checkUser!,
                          isLogin: widget.isLogin,
                          slug: slug,
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: MyModels().customButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    LoginPage(whichScreen: widget.whichScreen),
                              ),
                            );
                          },
                          title: "Login",
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
