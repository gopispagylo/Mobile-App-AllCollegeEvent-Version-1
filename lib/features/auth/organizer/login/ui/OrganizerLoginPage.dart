import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/organizer/login/bloc/orgLogin/org_login_bloc.dart';
import 'package:all_college_event_app/features/auth/organizer/login/model/OrganizerLoginModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerLoginPage extends StatefulWidget {
  final String whichScreen;

  const OrganizerLoginPage({super.key, required this.whichScreen});

  @override
  State<OrganizerLoginPage> createState() => _OrganizerLoginPageState();
}

class _OrganizerLoginPageState extends State<OrganizerLoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrgLoginBloc(apiController: ApiController()),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: MyColor().whiteClr,
        body: OrganizerLoginModel(whichScreen: widget.whichScreen,),
      ),
    );
  }
}
