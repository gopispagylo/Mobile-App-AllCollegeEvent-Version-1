import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/follow/bloc/FollowingBloc/following_bloc.dart';
import 'package:all_college_event_app/features/screens/follow/model/FollowingModel.dart';
import 'package:all_college_event_app/features/screens/global/bloc/CreateFollowBloc/create_follow_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowingPage extends StatefulWidget {
  final String followingOrFollowers;

  const FollowingPage({super.key, required this.followingOrFollowers});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
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
          "Following",
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FollowingBloc(apiController: ApiController())
              ..add(
                FetchFollowing(
                  followingOrFollowers: widget.followingOrFollowers,
                ),
              ),
          ),
          BlocProvider(
            create: (context) =>
                CreateFollowBloc(apiController: ApiController()),
          ),
        ],
        child: FollowingModel(
          followingOrFollowers: widget.followingOrFollowers,
        ),
      ),
    );
  }
}
