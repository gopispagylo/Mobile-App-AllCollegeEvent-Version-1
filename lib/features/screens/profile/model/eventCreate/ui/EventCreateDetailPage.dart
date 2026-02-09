import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/aceCategories/ace_categories_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/eventType/event_type_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/searchableKeyWords/searchable_key_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/EventCreateDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCreateDetailPage extends StatefulWidget {
  final Map<String, dynamic> orgDetailList;

  const EventCreateDetailPage({super.key, required this.orgDetailList});

  @override
  State<EventCreateDetailPage> createState() => _EventCreateDetailPageState();
}

class _EventCreateDetailPageState extends State<EventCreateDetailPage> {
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
          "Event Creation Form",
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
                AceCategoriesBloc(apiController: ApiController())
                  ..add(FetchAceCategories()),
          ),
          BlocProvider(
            create: (context) => EventTypeBloc(apiController: ApiController()),
          ),
          BlocProvider(create: (context) => SearchableKeyBloc()),
        ],
        child: EventCreateDetailModel(orgDetailList: widget.orgDetailList),
      ),
    );
  }
}
