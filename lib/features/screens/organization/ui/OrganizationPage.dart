import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerDetailBloc/organizer_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerEventListBloc/organizer_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationHeaderModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationPage extends StatefulWidget {
  final String title;
  final String slug;
  final String identity;
  final bool isLogin;

  const OrganizationPage({
    super.key,
    required this.title,
    required this.slug,
    required this.identity,
    required this.isLogin,
  });

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
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
          widget.title,
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
            create: (context) => OrganizerDetailBloc(
              apiController: ApiController(),
            )..add(ClickOrgDetail(slug: widget.slug, isLogin: widget.isLogin)),
          ),
          BlocProvider(
            create: (context) =>
                OrganizerEventListBloc(apiController: ApiController())..add(
                  FetchOrganizerEvent(
                    eventId: widget.identity,
                    isLogin: widget.isLogin,
                  ),
                ),
          ),
          BlocProvider(
            create: (context) =>
                RemoveSaveEventBloc(apiController: ApiController()),
          ),
          BlocProvider(
            create: (context) => EventLikeBloc(apiController: ApiController()),
          ),
        ],
        child: OrganizationHeaderModel(isLogin: widget.isLogin),
      ),
    );
  }
}
