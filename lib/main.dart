import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckUserPage(),
      ),
    );
  }
}
