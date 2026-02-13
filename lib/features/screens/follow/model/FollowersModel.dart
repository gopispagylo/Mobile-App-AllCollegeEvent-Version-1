import 'package:all_college_event_app/features/screens/follow/bloc/FollowingBloc/following_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowersModel extends StatefulWidget {
  final String followingOrFollowers;

  const FollowersModel({super.key, required this.followingOrFollowers});

  @override
  State<FollowersModel> createState() => _FollowersModelState();
}

class _FollowersModelState extends State<FollowersModel> {
  final List<String> names = [
    "Nandhini Jaganathan",
    "Vanisree",
    "Kanchana Mala",
    "Sriram",
    "Prabhavathi",
    "Siva",
    "Kanishkaa",
    "Nandhini Jaganathan",
    "Vanisree",
    "Kanchana Mala",
    "Sriram",
    "Prabhavathi",
  ];

  final String imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrWsmpxWIrs7BrP7r6ttYkSKxoingrePM1SidGPsuTi_1BPPAa1_EH-Uw&s";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<FollowingBloc, FollowingState>(
        builder: (context, followState) {
          if (followState is LoadingFollowing) {
            return Center(child: CircularProgressIndicator());
          } else if (followState is SuccessFollowing) {
            return RefreshIndicator(
              edgeOffset: 40,
              backgroundColor: MyColor().whiteClr,
              color: MyColor().primaryClr,
              onRefresh: () async {
                context.read<FollowingBloc>().add(
                  FetchFollowing(
                    followingOrFollowers: widget.followingOrFollowers,
                  ),
                );
              },
              child: ListView.builder(
                itemCount: followState.followingList.length,
                itemBuilder: (BuildContext context, int index) {
                  final list = followState.followingList[index];
                  final name = list['follower']['name'];
                  final profilePath = list['follower']['profileImage'];
                  return Card(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    color: MyColor().boxInnerClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: BorderSide(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: MyColor().primaryClr,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration.zero,
                                      imageUrl: profilePath ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().primaryClr,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              name[0],
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: MyColor().primaryClr,
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        name ?? '',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                      Text(
                                        "Followers",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (followState is FailFollowing) {
            return RefreshIndicator(
              edgeOffset: 40,
              backgroundColor: MyColor().whiteClr,
              color: MyColor().primaryClr,
              onRefresh: () async {
                context.read<FollowingBloc>().add(
                  FetchFollowing(
                    followingOrFollowers: widget.followingOrFollowers,
                  ),
                );
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
                        followState.errorMessage,
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
          return SizedBox();
        },
      ),
    );
  }
}
