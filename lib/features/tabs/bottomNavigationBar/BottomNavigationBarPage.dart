import 'package:all_college_event_app/features/screens/categories/ui/CategoriesPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/ui/HomePage.dart';
import 'package:all_college_event_app/features/screens/profile/ui/ProfilePage.dart';
import 'package:all_college_event_app/features/screens/search/ui/SearchPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomNavigationBarPage extends StatefulWidget {
  final int pageIndex;

  const BottomNavigationBarPage({super.key, required this.pageIndex});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {


  // Page index its working navigation bar to change the page
  int pageIndex = 0;


  // List of pages
  List<Widget> pagesList = [
    HomePage(),
    SearchPage(),
    CategoriesPage(),
    EventPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: MyColor().boxInnerClr,
        backgroundColor: MyColor().whiteClr,
        buttonBackgroundColor: MyColor().primaryClr,
        items: [
        CurvedNavigationBarItem(
          child: Icon(Symbols.home,color: pageIndex == 0 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Home',
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: MyColor().blackClr
          )
        ),
        CurvedNavigationBarItem(
          child: Icon(Symbols.search,color: pageIndex == 1 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Search',
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColor().blackClr
            )
        ),
        CurvedNavigationBarItem(
          child: Icon(Symbols.category_search,color: pageIndex == 2 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Categories',
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColor().blackClr
            )
        ),
        CurvedNavigationBarItem(
          child: Icon(Symbols.event,color: pageIndex == 3 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Event',
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColor().blackClr
            )
        ),
        CurvedNavigationBarItem(
          child: Icon(Symbols.person,color: pageIndex == 4 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Profile',
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColor().blackClr
            )
        ),
      ],
      index: pageIndex,
      onTap: (index){
        setState(() {
          pageIndex = index;
        });
      },
      ),
      body: pagesList[pageIndex],
    );
  }
}
