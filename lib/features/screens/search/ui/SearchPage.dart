import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/search/bloc/searchEventListBloc/search_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/search/model/SearchModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(backgroundColor: MyColor().whiteClr,
        title: Text("Search", style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            SearchEventListBloc(apiController: ApiController())
              ..add(FetchSearchEventList()),
          ),
          BlocProvider(
            create: (context) => RemoveSaveEventBloc(apiController: ApiController()),
          ),
          BlocProvider(
            create: (context) => EventLikeBloc(apiController: ApiController()),
          ),
        ],
        child: SearchModel(),
      ),
    );
  }
}
