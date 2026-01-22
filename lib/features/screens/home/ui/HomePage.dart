import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/organizer/login/ui/OrganizerLoginPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/categories/categories_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
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
  final String whichScreen;

  const HomePage({super.key, required this.whichScreen});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isScrolling = false;

  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: MyColor().whiteClr,
        body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {

          // --------- only for vertical scrolling then show the create button ----------
         if(notification.metrics.axis == Axis.vertical){
           if (notification.direction == ScrollDirection.reverse) {
             if (!isScrolling) {
               setState(() => isScrolling = true);
             }
           }
         }

         // --------- only for vertical scrolling then show the create button ----------
         if(notification.metrics.axis == Axis.vertical){
           if (notification.direction == ScrollDirection.forward) {
             if (isScrolling) {
               setState(() => isScrolling = false);
             }
           }
         }

          return false;
        },
      
        child: MultiBlocProvider(
          providers: [

            BlocProvider(create: (context) => TrendingEventListBloc(apiController: ApiController())),

            BlocProvider(create: (context) => EventTypeAllBloc(apiController: ApiController())),

            BlocProvider(create: (context) => TopOrganizerBloc(apiController: ApiController())),

          ],
          child: HomeModel(scrollController: scrollController),
        ),
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
                if(widget.whichScreen == "Organizer"){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationCreateDetailPage()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizerLoginPage(whichScreen: 'Organizer',)));
                }
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
                if(widget.whichScreen == "Organizer"){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationCreateDetailPage()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizerLoginPage(whichScreen: 'Organizer',)));
                }
              },
              child: Icon(Icons.add, size: 25,color: MyColor().whiteClr),
            ),
          ),
      
      ),
    );
  }
}
