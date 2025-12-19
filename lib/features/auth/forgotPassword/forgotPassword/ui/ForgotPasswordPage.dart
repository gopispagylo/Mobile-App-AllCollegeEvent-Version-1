import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/forgotPasswordBloc/forgot_password_bloc.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/resetPassword/reset_password_bloc.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/verifyOtp/verify_otp_bloc.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/model/ForgotPasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String whichScreen;

  const ForgotPasswordPage({super.key, required this.whichScreen});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForgotPasswordBloc(apiController: ApiController()),
        ),
        BlocProvider(
          create: (context) => ResetPasswordBloc(apiController: ApiController()),
        ),
      ],
      child: Scaffold(
        body: ForgotPasswordModel(whichScreen: widget.whichScreen,),
      ),
    );
  }
}
