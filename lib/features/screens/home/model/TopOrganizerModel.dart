import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:all_college_event_app/features/screens/home/bloc/topOrganizerBloc/top_organizer_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/TopOrganizerSeeAllModel.dart';
import 'package:all_college_event_app/features/screens/organization/ui/OrganizationPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TopOrganizerModel extends StatefulWidget {
  final bool isLogin;

  const TopOrganizerModel({super.key, required this.isLogin});

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
                margin: EdgeInsets.only(top: 20, left: 16, right: 6),
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
                height: 175,
                child: ListView.builder(
                  itemCount: min(topOrganizerState.topOrganizer.length, 5),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 165,
                              margin: EdgeInsets.only(
                                left: index == 0 ? 16 : 5,
                                right:
                                    index ==
                                        topOrganizerState.topOrganizer.length -
                                            1
                                    ? 16
                                    : 5,
                              ),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                color: MyColor().whiteClr.withOpacity(0.4),
                                borderRadius: BorderRadiusGeometry.circular(20),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrganizationPage(
                                        title: topOrganizerState
                                            .topOrganizer[index]['organizationName'],
                                        slug: topOrganizerState
                                            .topOrganizer[index]['slug'],
                                        identity: topOrganizerState
                                            .topOrganizer[index]['identity'],
                                        isLogin: widget.isLogin,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    if (index < 3)
                                      Positioned(
                                        right: 8,
                                        top: 5,

                                        child: Image.asset(
                                          index == 0
                                              ? ImagePath().rank_1
                                              : index == 1
                                              ? ImagePath().rank_2
                                              : ImagePath().rank_3,
                                          height: 30,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: CachedNetworkImage(
                                              height: 60,
                                              width: 60,
                                              fadeInDuration: Duration.zero,
                                              imageUrl:
                                                  topOrganizerState
                                                      .topOrganizer[index]['profileImage'] ??
                                                  "",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) {
                                                return Center(
                                                  child: Platform.isAndroid
                                                      ? CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        )
                                                      : CupertinoActivityIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                          // BlocConsumer<
                                          //   CreateFollowBloc,
                                          //   CreateFollowState
                                          // >(
                                          //   listener: (context, followCreateState) {
                                          //     final orgId = topOrganizerState
                                          //         .topOrganizer[index]['identity'];
                                          //     bool isFollow = topOrganizerState
                                          //         .topOrganizer[index]['identity'];
                                          //     if (followCreateState
                                          //             is SuccessCreateFollow &&
                                          //         followCreateState.orgId ==
                                          //             orgId) {
                                          //       isFollow =
                                          //           followCreateState.isFollow;
                                          //     } else {
                                          //       if (followCreateState
                                          //               is FailCreateFollow &&
                                          //           followCreateState.orgId ==
                                          //               orgId) {
                                          //         isFollow = followCreateState
                                          //             .previousValue;
                                          //         FlutterToast().flutterToast(
                                          //           followCreateState
                                          //               .errorMessage,
                                          //           ToastificationType.error,
                                          //           ToastificationStyle.flat,
                                          //         );
                                          //       }
                                          //     }
                                          //   },
                                          //   builder: (context, followCreateState) {
                                          //     final orgId = topOrganizerState
                                          //         .topOrganizer[index]['identity'];
                                          //     bool isFollow = false;
                                          //     return SizedBox(
                                          //       height: 40,
                                          //       width: double.infinity,
                                          //       child: ElevatedButton(
                                          //         style: ElevatedButton.styleFrom(
                                          //           backgroundColor: isFollow
                                          //               ? Colors.grey
                                          //               : MyColor().primaryClr,
                                          //           shape: RoundedRectangleBorder(
                                          //             borderRadius:
                                          //                 BorderRadiusGeometry.circular(
                                          //                   10,
                                          //                 ),
                                          //           ),
                                          //         ),
                                          //         onPressed: () {
                                          //           context
                                          //               .read<
                                          //                 CreateFollowBloc
                                          //               >()
                                          //               .add(
                                          //                 ClickCreateFollow(
                                          //                   orgId: orgId,
                                          //                   isFollow: isFollow,
                                          //                 ),
                                          //               );
                                          //         },
                                          //         child: Text(
                                          //           isFollow
                                          //               ? "Following"
                                          //               : "Follow",
                                          //           style: GoogleFonts.poppins(
                                          //             fontWeight:
                                          //                 FontWeight.w600,
                                          //             fontSize: 14,
                                          //             color: MyColor().whiteClr,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ],
                                      ),
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
