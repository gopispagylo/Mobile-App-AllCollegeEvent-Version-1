import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/SelectTimeZoneModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTimeZonePage extends StatefulWidget {
  const SelectTimeZonePage({super.key});

  @override
  State<SelectTimeZonePage> createState() => _SelectTimeZonePageState();
}

class _SelectTimeZonePageState extends State<SelectTimeZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          "Event Creation Form",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      backgroundColor: MyColor().whiteClr,
      body: SelectTimeZoneModel(),
    );
  }
}
