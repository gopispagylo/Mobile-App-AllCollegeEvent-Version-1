import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/user/signUp/bloc/signUp/sign_up_bloc.dart';
import 'package:all_college_event_app/features/auth/user/signUp/model/SignUpModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  final String whichScreen;

  const SignUpPage({super.key, required this.whichScreen});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(apiController: ApiController()),
      child: Scaffold(
        body: SignUpModel(whichScreen: widget.whichScreen),
      ),
    );
  }
}
