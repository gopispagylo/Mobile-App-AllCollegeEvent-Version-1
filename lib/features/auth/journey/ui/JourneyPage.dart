import 'package:all_college_event_app/features/auth/journey/model/JourneyModel.dart';
import 'package:flutter/material.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JourneyModel(),
    );
  }
}
