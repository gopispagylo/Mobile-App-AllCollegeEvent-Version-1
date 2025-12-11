import 'package:all_college_event_app/features/auth/organizer/signUp/model/AccountCreationModel.dart';
import 'package:flutter/material.dart';

class AccountCreationPage extends StatefulWidget {
  const AccountCreationPage({super.key});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountCreationModel(),
    );
  }
}
