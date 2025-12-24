import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/HomeModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor().boxInnerClr,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TrendingEventListBloc(apiController: ApiController())..add(FetchTrendingEventList()),
          ),
        ],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: MyColor().whiteClr,
            ),
            backgroundColor: MyColor().whiteClr,
            body: HomeModel(),
          ),
      ),
    );
  }
}
