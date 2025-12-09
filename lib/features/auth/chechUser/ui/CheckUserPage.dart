import 'dart:ui' as ui;

import 'package:all_college_event_app/features/auth/chechUser/model/ChechUserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckUserPage extends StatefulWidget {
  const CheckUserPage({super.key});

  @override
  State<CheckUserPage> createState() => _CheckUserPageState();
}

class _CheckUserPageState extends State<CheckUserPage> {


  void printRefreshRate() {
    final refreshRate = ui.PlatformDispatcher.instance.views.first.display.refreshRate;
    print("📱 Refresh Rate: $refreshRate Hz");
  }

  @override
  void initState() {
    super.initState();
    printRefreshRate();
  }
  

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        body: CheckUserModel()
      ),
    );
  }
}