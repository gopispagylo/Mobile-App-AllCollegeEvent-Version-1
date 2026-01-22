import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/event/model/EventListModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      EventListBloc(apiController: ApiController())
        ..add(FetchEventList(eventTypes: [],
            // trendingThreshold: null,
            modes: [],
            // searchText: '',
            eligibleDeptIdentities: [],
            certIdentity: '',
            eventTypeIdentity: '',
            perkIdentities: [],
            accommodationIdentities: [],
            country: '',
            state: '',
            city: '',
            startDate: null,
            // endDate: null,
            // minPrice: null,
            // maxPrice: null,
            // page: null,
            // limit: null,
            // sortBy: ''

        )),
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Events",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),),
          backgroundColor: MyColor().whiteClr,
        ),
        backgroundColor: MyColor().whiteClr,
        body: EventListModel(),
      ),
    );
  }
}
