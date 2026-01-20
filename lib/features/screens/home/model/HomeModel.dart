import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/CarouselSliderPage.dart';
import 'package:all_college_event_app/features/screens/home/model/CategoriesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/CountriesAndCitiesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TrendingEventModel.dart';
import 'package:all_college_event_app/features/screens/home/model/WelcomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeModel extends StatefulWidget {
  final ScrollController scrollController;

  const HomeModel({super.key, required this.scrollController});

  @override
  State<HomeModel> createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Future.delayed(Duration(milliseconds: 400));
      context.read<TrendingEventListBloc>().add(FetchTrendingEventList());
      context.read<EventTypeAllBloc>().add(EventTypeAll());
      context.read<TopOrganizerBloc>().add(FetchTopOrganizer());
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        context.read<TrendingEventListBloc>().add(FetchTrendingEventList());
        context.read<EventTypeAllBloc>().add(EventTypeAll());
        context.read<TopOrganizerBloc>().add(FetchTopOrganizer());
      },
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // Welcome UI
            WelcomeModel(),

            // CarouselSlider UI
            CarouselSliderPage(),

            // Categories UI
            HomeCategoriesModel(),

            // Trending Event UI
            TrendingEventModel(),

            // Top Organizer UI
            TopOrganizerModel(),

            // Countries & Cities UI
            CountriesAndCitiesModel(),

          ],
        ),
      ),
    );
  }
}
