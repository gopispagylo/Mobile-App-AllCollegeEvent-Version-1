import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/user/login/bloc/googleSignInBloc/google_sign_in_bloc.dart';
import 'package:all_college_event_app/features/auth/user/login/bloc/login/login_bloc.dart';
import 'package:all_college_event_app/features/auth/user/login/model/LoginModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String whichScreen;

  const LoginPage({super.key, required this.whichScreen});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(apiController: ApiController()),
        ),
        BlocProvider(
          create: (context) => GoogleSignInBloc(apiController: ApiController()),
        ),
      ],
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: MyColor().whiteClr,
        body: LoginModel(whichScreen: widget.whichScreen,),
      ),
    );
  }
}
