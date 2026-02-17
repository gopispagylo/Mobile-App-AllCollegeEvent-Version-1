import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/model/EventListModel.dart';
import 'package:all_college_event_app/features/screens/global/bloc/featuredEventBloc/featured_event_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/trendingEventBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/upComingEventBloc/up_coming_event_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/virtualEventBloc/virtual_event_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  final bool isLogin;

  const EventPage({super.key, required this.isLogin});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TrendingEventListBloc(apiController: ApiController())..add(
                FetchTrendingEventList(
                  isLogin: widget.isLogin,
                  // loadMore: false,
                ),
              ),
        ),
        BlocProvider(
          create: (context) =>
              UpComingEventBloc(apiController: ApiController())
                ..add(FetchUpComingEventList(isLogin: widget.isLogin)),
        ),
        BlocProvider(
          create: (context) =>
              VirtualEventBloc(apiController: ApiController())
                ..add(FetchVirtualEventList(isLogin: widget.isLogin)),
        ),
        BlocProvider(
          create: (context) =>
              FeaturedEventBloc(apiController: ApiController())
                ..add(FetchFeaturedEventList(isLogin: widget.isLogin)),
        ),
        BlocProvider(
          create: (context) => EventLikeBloc(apiController: ApiController()),
        ),
        BlocProvider(
          create: (context) =>
              RemoveSaveEventBloc(apiController: ApiController()),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColor().whiteClr,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          title: Text(
            "All Events",
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
        body: EventListModel(isLogin: widget.isLogin),
      ),
    );
  }
}
