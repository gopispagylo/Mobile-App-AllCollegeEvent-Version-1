import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/event/model/EventDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailPage extends StatefulWidget {
  final String identity;
  final String title;

  const EventDetailPage(
      {super.key, required this.identity, required this.title});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      EventDetailBloc(apiController: ApiController())..add(ClickEventDetail(identity: widget.identity)),
      child: Scaffold(
        backgroundColor: MyColor().whiteClr,
        appBar: AppBar(
          backgroundColor: MyColor().whiteClr,
          title: Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
        ),
        body: EventDetailModel(identity: widget.identity, title: widget.title,),
      ),
    );
  }
}
