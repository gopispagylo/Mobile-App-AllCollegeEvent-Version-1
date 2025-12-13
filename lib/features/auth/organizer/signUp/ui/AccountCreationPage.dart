import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/organizer/signUp/bloc/orgAccCreationBloc/org_acc_creation_bloc.dart';
import 'package:all_college_event_app/features/auth/organizer/signUp/model/AccountCreationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCreationPage extends StatefulWidget {
  final String country;
  final String city;
  final String state;
  final String orgName;
  final String categories;
  final String type;

  const AccountCreationPage({super.key, required this.country, required this.city, required this.state, required this.orgName, required this.categories,required this.type});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrgAccCreationBloc(apiController: ApiController()),
      child: Scaffold(
        body: AccountCreationModel(country: widget.country, city: widget.city, state: widget.state, orgName: widget.orgName, categories: widget.categories, type: widget.type,),
      ),
    );
  }
}
