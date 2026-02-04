import 'dart:ui';

import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerSeeAllModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TopOrganizerModel extends StatefulWidget {
  const TopOrganizerModel({super.key});

  @override
  State<TopOrganizerModel> createState() => _TopOrganizerModelState();
}

class _TopOrganizerModelState extends State<TopOrganizerModel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopOrganizerBloc, TopOrganizerState>(
      builder: (context, topOrganizerState) {
        if (topOrganizerState is TopOrganizerLoading) {
          return categoryShimmer();
        } else if (topOrganizerState is TopOrganizerSuccess) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 16, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Organizers",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "blMelody",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopOrganizerSeeAllModel(
                              topOrganizerList: topOrganizerState.topOrganizer,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "See all",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, top: 0),
                height: 220,
                child: ListView.builder(
                  itemCount: topOrganizerState.topOrganizer.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: SizedBox(
                          width: 180,
                          child: Card(
                            margin: EdgeInsets.only(
                              left: index == 0 ? 16 : 5,
                              right:
                                  index ==
                                      topOrganizerState.topOrganizer.length - 1
                                  ? 16
                                  : 5,
                            ),
                            color: MyColor().whiteClr.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              side: BorderSide(
                                color: MyColor().borderClr.withOpacity(0.15),
                              ),
                            ),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      memCacheHeight: 300,
                                      fadeInDuration: Duration.zero,
                                      imageUrl:
                                          topOrganizerState
                                              .topOrganizer[index]['profileImage'] ??
                                          "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: MyColor().primaryClr,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: MyColor().whiteClr,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: MyColor().borderClr
                                                  .withOpacity(0.15),
                                            ),
                                          ),
                                          child: Text(
                                            topOrganizerState
                                                .topOrganizer[index]['organizationName'][0],
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              color: MyColor().blackClr,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // org name and event count
                                  Column(
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        topOrganizerState
                                            .topOrganizer[index]['organizationName'],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                      Text(
                                        "${topOrganizerState.topOrganizer[index]['eventCount']} Events",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: MyColor().secondaryClr,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColor().primaryClr,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Follow",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: MyColor().whiteClr,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (topOrganizerState is TopOrganizerFail) {
          return Center(child: Text(topOrganizerState.errorMessage));
        }
        return SizedBox.shrink();
      },
    );
  }

  // ------- skeleton loading ------
  Widget categoryShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Shimmer(
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 16,
                right: index == 6 - 1 ? 16 : 0,
              ),
              height: 104,
              width: 104,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
