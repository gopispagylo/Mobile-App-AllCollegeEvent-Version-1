import 'package:all_college_event_app/features/screens/global/bloc/singleImageController/single_image_controller_bloc.dart';
import 'package:all_college_event_app/features/screens/staticPages/model/FaqModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Frequently Asked Questions", style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      backgroundColor: MyColor().whiteClr,
      body: BlocProvider(
        create: (context) => SingleImageControllerBloc(),
        child: FaqModel(),
      ),
    );
  }
}
