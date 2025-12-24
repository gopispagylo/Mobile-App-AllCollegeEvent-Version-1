
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/CarouselSliderPage.dart';
import 'package:all_college_event_app/features/screens/home/model/CategoriesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/CountriesAndCitiesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TrendingEventModel.dart';
import 'package:all_college_event_app/features/screens/home/model/WelcomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeModel extends StatefulWidget {
  const HomeModel({super.key});

  @override
  State<HomeModel> createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        context.read<TrendingEventListBloc>().add(FetchTrendingEventList());
      },
      child: ListView(
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
    );
  }
}
