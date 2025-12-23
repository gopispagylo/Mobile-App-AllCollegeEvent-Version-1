import 'dart:math';

import 'package:all_college_event_app/features/screens/event/bloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/event/model/EventDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ListModel extends StatefulWidget {
  const ListModel({super.key});

  @override
  State<ListModel> createState() => _ListModelState();
}

class _ListModelState extends State<ListModel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, EventListState>(
      builder: (context, eventListState) {
        if (eventListState is EventListLoading) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return eventCardShimmer();
            },
          );
        }
        else if (eventListState is EventSuccess) {
          return RefreshIndicator(
            color: MyColor().primaryClr,
            onRefresh: () async{
              context.read<EventListBloc>().add(FetchEventList());
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 20,),
              child: ListView.builder(
                itemCount: eventListState.eventList.length,
                itemBuilder: (context, index) {
                  final list = eventListState.eventList[index];

                  // -------- field name ------------
                  final title = list['title'] ?? "No title";
                  final featuredImagePath = list['bannerImage'];

                  // --- date format -----
                  final eventStartDateFormat = list['eventDate'];
                  final parsedDate = DateFormat('dd/MM/yyyy').parse(eventStartDateFormat);
                  final eventStartDate = DateFormat('dd MMM yyyy').format(parsedDate);

                  // ---- venue ---
                  final venue = list['venue'];


                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EventDetailModel()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 0, bottom: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyColor().whiteClr,
                        border: Border.all(
                          color: MyColor().borderClr.withOpacity(0.15),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                featuredImagePath ,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Row(
                                        children: [
                                          circleIcon(Icons.favorite_border),
                                          SizedBox(width: 5),
                                          circleIcon(Icons.bookmark_outline),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      chip(
                                        "Paid",
                                        MyColor().primaryBackgroundClr
                                            .withOpacity(0.35),
                                      ),
                                      chip(
                                        "Entertainment",
                                        MyColor().blueBackgroundClr.withOpacity(
                                          0.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month, size: 14),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          eventStartDate,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 14),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          venue,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryBackgroundClr
                                              .withOpacity(0.35),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Ongoing",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        else if (eventListState is EventFail) {
          return RefreshIndicator(
            onRefresh: () async{
              context.read<EventListBloc>().add(FetchEventList());
            },
            child: Center(
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
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

// --------- Dummy Button ---------
Widget chip(String text, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
    ),
  );
}

// --------- Fav & Add to cart Icon ---------
Widget circleIcon(IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
      color: MyColor().boxInnerClr,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 15),
  );
}

// ---------- Skeleton loading ui model -------
Widget eventCardShimmer() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        // Image shimmer
        Expanded(
          flex: 2,
          child: Shimmer(
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Content shimmer
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + icons
              Row(
                children: [
                  Expanded(
                    child: Shimmer(
                      child: Container(
                        width: double.infinity,
                        height: 14,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Shimmer(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Shimmer(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Chips
              Row(
                children: [
                  Shimmer(
                    child: Container(
                      width: 50,
                      height: 18,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Shimmer(
                    child: Container(
                      width: 90,
                      height: 18,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Date
              Shimmer(
                child: Container(
                  width: 160,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Location + status
              Row(
                children: [
                  Expanded(
                    child: Shimmer(
                      child: Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Shimmer(
                    child: Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
