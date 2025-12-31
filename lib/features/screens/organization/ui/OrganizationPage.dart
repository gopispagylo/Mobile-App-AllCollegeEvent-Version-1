import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationCarouselSliderModel.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationHeaderModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

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
         "widget.title",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => EventListBloc(apiController: ApiController())..add(FetchEventList()),
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async{
                context.read<EventListBloc>().add(FetchEventList());
              },
              child: ListView(
                children: [

                  // -------- Carousel Slider ------
                  OrganizationCarouselSliderModel(),

                  // ------ Name Header -------
                  OrganizationHeaderModel()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
