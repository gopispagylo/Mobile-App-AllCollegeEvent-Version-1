import 'package:all_college_event_app/features/screens/event/model/EventListModel.dart';
import 'package:all_college_event_app/features/screens/event/model/ListModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColor().whiteClr,
      ),
      backgroundColor: MyColor().whiteClr,
      body: Container(
        child: EventListModel()
      ),
    );
  }
}
