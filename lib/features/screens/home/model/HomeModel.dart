import 'dart:ui';

import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/CarouselSliderPage.dart';
import 'package:all_college_event_app/features/screens/home/model/CategoriesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/CountriesAndCitiesModel.dart';
import 'package:all_college_event_app/features/screens/home/model/LocationModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerModel.dart';
import 'package:all_college_event_app/features/screens/home/model/TrendingEventModel.dart';
import 'package:all_college_event_app/features/screens/notification/ui/NotificationPage.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeModel extends StatefulWidget {
  final ScrollController scrollController;

  const HomeModel({super.key, required this.scrollController});

  @override
  State<HomeModel> createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {
  // username
  String? userName;

  @override
  void initState() {
    super.initState();
    getUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 400));
      context.read<TrendingEventListBloc>().add(FetchTrendingEventList());
      context.read<EventTypeAllBloc>().add(EventTypeAll());
      context.read<TopOrganizerBloc>().add(FetchTopOrganizer());
    });
  }

  // get a username from the local database
  void getUserName() async {
    final name = await DBHelper().getUserDetails();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TrendingEventListBloc>().add(FetchTrendingEventList());
        context.read<EventTypeAllBloc>().add(EventTypeAll());
        context.read<TopOrganizerBloc>().add(FetchTopOrganizer());
      },
      child: SafeArea(
        child: CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Welcome ",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            userName == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor().primaryClr,
                                    ),
                                  )
                                : Text(
                                    "$userName!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: MyColor().primaryClr,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Location
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LocationModel(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Iconsax.location_copy, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    "Coimbatore, India",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: MyColor().primaryClr,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down, size: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    NotificationPage(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  var tween = Tween(
                                    begin: Offset(1, 0),
                                    end: Offset.zero,
                                  ).chain(CurveTween(curve: Curves.easeInOut));
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: MyColor().locationClr,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Badge.count(
                            count: 10,
                            child: Icon(Icons.notifications, size: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sliver AppBar (Welcome Header)
            SliverAppBar(
              expandedHeight: 0,
              pinned: true,
              floating: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(18),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor().whiteClr.withOpacity(0.07),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 16,
                            left: 16,
                            right: 16,
                          ),
                          width: 380,
                          child: TextFormField(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                  ),
                                ),
                              );
                            },
                            onTapOutside: (onChanged) {
                              WidgetsBinding.instance.focusManager.primaryFocus!
                                  .unfocus();
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: MyColor().borderClr,
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: MyColor().primaryClr,
                                  width: 0.5,
                                ),
                              ),
                              prefixIcon: Icon(Icons.search, size: 18),
                              hintText: "Search Events",
                              fillColor: MyColor().whiteClr.withValues(
                                alpha: 0.5,
                              ),
                              filled: true,
                              hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColor().hintTextClr,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Normal widgets as slivers
            SliverToBoxAdapter(child: CarouselSliderPage()),
            SliverToBoxAdapter(child: HomeCategoriesModel()),
            SliverToBoxAdapter(child: TrendingEventModel()),
            SliverToBoxAdapter(child: TopOrganizerModel()),
            SliverToBoxAdapter(child: CountriesAndCitiesModel()),
          ],
        ),
      ),
    );
  }
}
