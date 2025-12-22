import 'package:all_college_event_app/features/screens/organization/model/OrganizationCarouselSliderModel.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationHeaderModel.dart';
import 'package:flutter/material.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          // -------- Carousel Slider ------
          OrganizationCarouselSliderModel(),

          // ------ Name Header -------
          OrganizationHeaderModel()
        ],
      ),
    );
  }
}
