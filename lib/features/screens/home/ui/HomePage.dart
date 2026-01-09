import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/global/bloc/categories/categories_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/HomeModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/OrganizationCreateDetailPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isScrolling = false;

  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TrendingEventListBloc(apiController: ApiController())..add(FetchTrendingEventList()),
        ), BlocProvider(
          create: (context) => CategoriesBloc(apiController: ApiController())..add(FetchCategories()),
        ), BlocProvider(
          create: (context) => TopOrganizerBloc(apiController: ApiController())..add(FetchTopOrganizer()),
        ),
      ],
        child: Scaffold(
          backgroundColor: MyColor().whiteClr,
          body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              if (!isScrolling) {
                setState(() => isScrolling = true);
              }
            }
            if (notification.direction == ScrollDirection.forward) {
              if (isScrolling) {
                setState(() => isScrolling = false);
              }
            }
            return false;
          },

          child: HomeModel(scrollController: scrollController),
        ),

        floatingActionButton: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: isScrolling
                  ? FloatingActionButton.extended(
                backgroundColor: MyColor().primaryClr,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationCreateDetailPage()));
                },
                icon:  Icon(Icons.add,color: MyColor().whiteClr,size: 25,),
                label: Text("Create Event",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,color: MyColor().whiteClr,fontSize: 14
                ),),
              )
                  : FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                backgroundColor: MyColor().primaryClr,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationCreateDetailPage()));
                },
                child: Icon(Icons.add, size: 25,color: MyColor().whiteClr),
              ),
            ),

        ),
    );
  }
}
