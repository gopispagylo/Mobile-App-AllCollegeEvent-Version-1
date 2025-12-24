import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/event/model/EventListModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventListBloc(apiController: ApiController())..add(FetchEventList()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColor().whiteClr,
        ),
        backgroundColor: MyColor().whiteClr,
        body: EventListModel(),
      ),
    );
  }
}
