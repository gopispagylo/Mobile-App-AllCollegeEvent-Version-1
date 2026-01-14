import 'package:all_college_event_app/features/screens/staticPages/model/FeedBackModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Feed back",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      backgroundColor: MyColor().whiteClr,
      body: FeedBackModel(),
    );
  }
}
