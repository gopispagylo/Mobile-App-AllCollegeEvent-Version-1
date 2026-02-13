import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/follow/bloc/FollowingBloc/following_bloc.dart';
import 'package:all_college_event_app/features/screens/follow/model/FollowersModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowersPage extends StatefulWidget {
  final String followingOrFollowers;

  const FollowersPage({super.key, required this.followingOrFollowers});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "Followers",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              decoration: BoxDecoration(
                color: MyColor().whiteClr.withOpacity(0.05),
              ),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => FollowingBloc(apiController: ApiController())
          ..add(
            FetchFollowing(followingOrFollowers: widget.followingOrFollowers),
          ),
        child: FollowersModel(
          followingOrFollowers: widget.followingOrFollowers,
        ),
      ),
    );
  }
}
