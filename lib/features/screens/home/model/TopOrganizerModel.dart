import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerSeeAllModel.dart';
import 'package:all_college_event_app/features/screens/organization/ui/OrganizationPage.dart';
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
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                            builder: (_) => TopOrganizerSeeAllModel(),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(topOrganizerState.topOrganizer.length, (
                    index,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => OrganizationPage(title:topOrganizerState.topOrganizer[index]['organizationName'],)),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 16 : 0,
                          right: 16,
                        ),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: MyColor().whiteClr,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl:
                              topOrganizerState
                                  .topOrganizer[index]['profileImage'] ??
                              '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: MyColor().primaryClr,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Center(
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
                    );
                  }),
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
