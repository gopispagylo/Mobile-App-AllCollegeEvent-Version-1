import 'package:all_college_event_app/features/auth/organizer/signUp/model/OrganizationDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class OrganizationDetailPage extends StatefulWidget {
  final String categories;
  final String type;

  const OrganizationDetailPage({super.key, required this.categories, required this.type});

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: OrganizationDetailModel(categories: widget.categories, type: widget.type,),
    );
  }
}
