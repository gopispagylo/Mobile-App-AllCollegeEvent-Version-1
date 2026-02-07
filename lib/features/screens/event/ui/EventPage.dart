import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/model/EventListModel.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
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
                  page: 1,
                  limit: 2,
                ),
              ),
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
        appBar: AppBar(
          title: Text(
            "All Events",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
          backgroundColor: MyColor().whiteClr,
        ),
        backgroundColor: MyColor().whiteClr,
        body: EventListModel(isLogin: widget.isLogin),
      ),
    );
  }
}
