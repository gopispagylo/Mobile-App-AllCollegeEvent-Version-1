import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerDetailBloc/organizer_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationHeaderModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrganizationPage extends StatefulWidget {
  final String title;
  final String slug;

  const OrganizationPage({super.key, required this.title, required this.slug});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => OrganizerDetailBloc(apiController: ApiController())..add(ClickOrgDetail(slug: widget.slug)),
        child: OrganizationHeaderModel(),
      ),
    );
  }
}
