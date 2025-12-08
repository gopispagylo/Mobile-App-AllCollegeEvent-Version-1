import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/model/ForgotPasswordModel.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String whichScreen;

  const ForgotPasswordPage({super.key, required this.whichScreen});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordModel(whichScreen: widget.whichScreen,),
    );
  }
}
