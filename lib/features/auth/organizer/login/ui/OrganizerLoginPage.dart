import 'package:all_college_event_app/features/auth/organizer/login/model/OrganizerLoginModel.dart';
import 'package:flutter/material.dart';

class OrganizerLoginPage extends StatefulWidget {
  const OrganizerLoginPage({super.key});

  @override
  State<OrganizerLoginPage> createState() => _OrganizerLoginPageState();
}

class _OrganizerLoginPageState extends State<OrganizerLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrganizerLoginModel(),
    );
  }
}
