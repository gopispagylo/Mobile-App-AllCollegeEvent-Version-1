import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/global/bloc/multipleImageController/image_controller_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/accommodation/accommodation_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/certification/certification_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/perks/perks_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/MediaAndTicketsModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaAndTicketsPage extends StatefulWidget {
  final Map<String,dynamic> orgDetailList;

  const MediaAndTicketsPage({super.key, required this.orgDetailList});

  @override
  State<MediaAndTicketsPage> createState() => _MediaAndTicketsPageState();
}

class _MediaAndTicketsPageState extends State<MediaAndTicketsPage> {


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
      body: MultiBlocProvider(
        providers: [

          BlocProvider(create: (context) => PerksBloc(apiController: ApiController())..add(FetchPerks())),

          BlocProvider(create: (context) => CertificationBloc(apiController: ApiController())..add(FetchCertification())),

          BlocProvider(create: (context) => AccommodationBloc(apiController: ApiController())..add(FetchAccommodation())),

          BlocProvider(create: (context) => ImageControllerBloc()),

        ],
        child: MediaAndTicketsModel(orgDetailList: widget.orgDetailList,),
      ),
    );
  }
}
