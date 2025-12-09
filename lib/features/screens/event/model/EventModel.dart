import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class EventModel extends StatefulWidget {
  const EventModel({super.key});

  @override
  State<EventModel> createState() => _EventModelState();
}

class _EventModelState extends State<EventModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Center(
        child: Text("THIS IS A EVENT PAGE",style: TextStyle(),),
      ),
    );
  }
}
