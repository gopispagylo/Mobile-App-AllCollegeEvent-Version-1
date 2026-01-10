import 'package:all_college_event_app/features/screens/staticPages/model/ContactUsModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        centerTitle: true,
        title: Text("Contact Us",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      backgroundColor: MyColor().whiteClr,
      body: ContactUsModel(),
    );
  }
}
