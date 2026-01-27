import 'package:all_college_event_app/features/screens/categories/ui/CategoriesPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventPage.dart';
import 'package:all_college_event_app/features/screens/home/ui/HomePage.dart';
import 'package:all_college_event_app/features/screens/profile/ui/ProfilePage.dart';
import 'package:all_college_event_app/features/screens/search/ui/SearchPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomNavigationBarPage extends StatefulWidget {
  final int pageIndex;
  final String whichScreen;

  const BottomNavigationBarPage({super.key, required this.pageIndex,required this.whichScreen});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {


  // Page index its working navigation bar to change the page
  int pageIndex = 0;




  // List of pages
  late List<Widget> pagesList = [
    HomePage(whichScreen: widget.whichScreen),
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

    // when i where we go to then back button click then comes home page
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) async{
        if(pageIndex != 0){
          setState(() {
            pageIndex = 0;
          });
        }else{
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
