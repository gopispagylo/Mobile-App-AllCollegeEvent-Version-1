import 'package:all_college_event_app/features/auth/organizer/signUp/model/OrganizationDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class OrganizationDetailPage extends StatefulWidget {
  const OrganizationDetailPage({super.key});

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: OrganizationDetailModel(),
    );
  }
}
