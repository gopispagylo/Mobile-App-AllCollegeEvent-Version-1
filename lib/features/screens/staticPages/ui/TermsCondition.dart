import 'package:all_college_event_app/features/screens/staticPages/model/TermsConditionModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Terms & Condition",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      backgroundColor: MyColor().whiteClr,
      body: TermsConditionModel(),
    );
  }
}
