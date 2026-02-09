import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/SelectTimeZoneModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTimeZonePage extends StatefulWidget {
  final Map<String, dynamic> orgDetailList;

  const SelectTimeZonePage({super.key, required this.orgDetailList});

  @override
  State<SelectTimeZonePage> createState() => _SelectTimeZonePageState();
}

class _SelectTimeZonePageState extends State<SelectTimeZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "Top Organizers",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              decoration: BoxDecoration(
                color: MyColor().whiteClr.withOpacity(0.05),
              ),
            ),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CountryBloc(apiController: ApiController())
                  ..add(FetchCountry()),
          ),

          BlocProvider(
            create: (context) =>
                ChooseStateBloc(apiController: ApiController()),
          ),

          BlocProvider(
            create: (context) => CityBloc(apiController: ApiController()),
          ),
        ],
        child: SelectTimeZoneModel(orgDetailList: widget.orgDetailList),
      ),
    );
  }
}
