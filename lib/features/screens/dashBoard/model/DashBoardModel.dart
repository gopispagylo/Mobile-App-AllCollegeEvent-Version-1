import 'dart:math';

import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerEventListBloc/organizer_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardModel extends StatefulWidget {
  final String slug;

  const DashBoardModel({super.key, required this.slug});

  @override
  State<DashBoardModel> createState() => _DashBoardModelState();
}

class _DashBoardModelState extends State<DashBoardModel> {
  // select the dropdown values
  String? selectEvent;

  // list of analytics
  List<String> analyticsList = ['Likes', 'Views', 'Clicks'];

  // selec of analytics
  String selectAnalytics = "Likes";

  // List chart function
  List<FlSpot> generateSpotsFromTotal({required int total, int points = 10}) {
    // initial set index for chart
    if (total <= 0) {
      return List.generate(points, (i) => FlSpot(i.toDouble(), 0));
    }
    final random = Random();
    final avg = total / points;

    double lastValue = avg;

    return List.generate(points, (i) {
      // small random variation
      final change = (random.nextDouble() * avg * 0.6) - (avg * 0.3);

      // smooth transition
      double y = lastValue + change;

      // limits (avoid too high / too low)
      y = y.clamp(avg * 0.3, avg * 2);

      lastValue = y;

      return FlSpot(i.toDouble(), y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          BlocBuilder<OrganizerEventListBloc, OrganizerEventListState>(
            builder: (context, organizerEventState) {
              if (organizerEventState is OrganizerEventSuccess) {
                final list = organizerEventState.organizerEventList;

                // auto initial select the event
                if (selectEvent == null && list.isNotEmpty) {
                  selectEvent = list.first['slug'];

                  // trigger API for first event
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<EventDetailBloc>().add(
                      ClickEventDetail(slug: selectEvent!, isLogin: true),
                    );
                  });
                }
                return MyModels().customDropdown(
                  label: "Select Event",
                  hint: "All Events",
                  value: selectEvent,
                  onChanged: (onChanged) {
                    context.read<EventDetailBloc>().add(
                      ClickEventDetail(slug: onChanged, isLogin: true),
                    );
                  },
                  items: list
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e['slug'],
                          child: Text(e['title']),
                        ),
                      )
                      .toList(),
                  valid: (value) {},
                );
              } else if (organizerEventState is OrganizerEventFail) {
                return Center(
                  child: Text(
                    organizerEventState.errorMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor().secondaryClr,
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),

          Container(
            margin: EdgeInsets.only(top: 24),
            child: Text(
              "Analytics",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: List.generate(analyticsList.length, (index) {
              final checkSelect = analyticsList[index] == selectAnalytics;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectAnalytics = analyticsList[index];
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 5, top: 10),
                  alignment: Alignment.center,
                  height: 48,
                  width: 90,
                  decoration: BoxDecoration(
                    color: checkSelect
                        ? MyColor().primaryClr
                        : MyColor().whiteClr,
                    border: Border.all(color: MyColor().primaryClr),
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                  child: Text(
                    analyticsList[index],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: checkSelect
                          ? MyColor().whiteClr
                          : MyColor().primaryClr,
                    ),
                  ),
                ),
              );
            }),
          ),
          BlocBuilder<EventDetailBloc, EventDetailState>(
            builder: (context, getEventState) {
              if (getEventState is EventDetailLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (getEventState is EventDetailSuccess) {
                final list = getEventState.eventDetailList[0];

                final likes = list['likeCount'];
                final views = list['viewCount'];
                final clicks = list['shareCount'];

                int selectTotalCount;
                switch (selectAnalytics) {
                  case "Views":
                    selectTotalCount = views;
                    break;
                  case "Likes":
                    selectTotalCount = likes;
                    break;
                  default:
                    selectTotalCount = clicks;
                }

                final spots = generateSpotsFromTotal(total: selectTotalCount);
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MyColor().whiteClr,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: MyColor().borderClr.withOpacity(0.15),
                    ),
                  ),
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 1500,
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: false,
                        verticalInterval: 1,
                      ),
                      titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          barWidth: 0.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                MyColor().primaryClr.withOpacity(0.6),
                                MyColor().primaryClr.withOpacity(0.05),
                              ],
                            ),
                          ),
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (getEventState is EventDetailFail) {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 250,
                          child: Image.asset(ImagePath().errorMessageImg),
                        ),
                      ),
                      Center(
                        child: Text(
                          "No Results Found",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
