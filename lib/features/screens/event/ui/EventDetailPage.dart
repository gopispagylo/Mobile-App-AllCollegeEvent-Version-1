import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventCountUpdateBloc/event_count_update_bloc.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/event/model/EventDetailModel.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailPage extends StatefulWidget {
  final String slug;
  final String title;
  final String whichScreen;
  final String paymentLink;
  final bool isLogin;

  const EventDetailPage({
    super.key,
    required this.slug,
    required this.title,
    required this.whichScreen,
    required this.paymentLink,
    required this.isLogin,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDetailBloc(apiController: ApiController())
            ..add(ClickEventDetail(slug: widget.slug, isLogin: widget.isLogin)),
        ),
        BlocProvider(
          create: (context) => EventLikeBloc(apiController: ApiController()),
        ),
        BlocProvider(
          create: (context) =>
              EventCountUpdateBloc(apiController: ApiController())
                ..add(ClickEventCountUpdate(slug: widget.slug)),
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
        body: EventDetailModel(
          identity: widget.slug,
          title: widget.title,
          whichScreen: widget.whichScreen,
          paymentLink: widget.paymentLink,
          isLogin: widget.isLogin,
        ),
      ),
    );
  }
}
