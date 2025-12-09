import 'package:all_college_event_app/features/screens/categories/ui/CategoriesPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventPage.dart';
import 'package:all_college_event_app/features/screens/home/ui/HomePage.dart';
import 'package:all_college_event_app/features/screens/profile/ui/ProfilePage.dart';
import 'package:all_college_event_app/features/screens/search/ui/SearchPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

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
          child: Icon(Icons.home_outlined,color: pageIndex == 0 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.search,color: pageIndex == 1 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Search',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.chat_bubble_outline,color: pageIndex == 2 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Chat',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.newspaper,color: pageIndex == 3 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Feed',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.perm_identity,color: pageIndex == 4 ? MyColor().whiteClr : MyColor().borderClr,),
          label: 'Personal',
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
