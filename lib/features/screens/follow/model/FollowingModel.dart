import 'dart:io';

import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/follow/bloc/FollowingBloc/following_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/CreateFollowBloc/create_follow_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class FollowingModel extends StatefulWidget {
  final String followingOrFollowers;

  const FollowingModel({super.key, required this.followingOrFollowers});

  @override
  State<FollowingModel> createState() => _FollowingModelState();
}

class _FollowingModelState extends State<FollowingModel> {
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
                // shrinkWrap: true,
                itemCount: followState.followingList.length,
                itemBuilder: (BuildContext context, int index) {
                  final list = followState.followingList[index];
                  final name = list['followingOrg'] != null
                      ? list['followingOrg']['name']
                      : list['name'];
                  final profilePath = list['followingOrg'] != null
                      ? list['followingOrg']['profileImage']
                      : list['profileImage'];

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
                                        name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                      Text(
                                        "Following",
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
                          SizedBox(width: 10),

                          BlocConsumer<CreateFollowBloc, CreateFollowState>(
                            listener: (context, followState) {
                              final id = list['followingOrg'] != null
                                  ? list['followingOrg']['identity']
                                  : list['identity'];
                              if (followState is SuccessCreateFollow) {
                                context.read<FollowingBloc>().add(
                                  FetchFollowing(
                                    followingOrFollowers:
                                        widget.followingOrFollowers,
                                  ),
                                );
                              } else if (followState is FailCreateFollow &&
                                  followState.orgId == id) {
                                FlutterToast().flutterToast(
                                  followState.errorMessage,
                                  ToastificationType.error,
                                  ToastificationStyle.flat,
                                );
                              }
                            },
                            builder: (context, followState) {
                              final id = list['followingOrg'] != null
                                  ? list['followingOrg']['identity']
                                  : list['identity'];
                              return InkWell(
                                onTap: () {
                                  context.read<CreateFollowBloc>().add(
                                    ClickCreateFollow(
                                      orgId: id,
                                      isFollow: false,
                                      unFollow: true,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 7,
                                    bottom: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor().primaryClr,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child:
                                      followState is LoadingCreateFollow &&
                                          followState.orgId == id
                                      ? Center(
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator(
                                                  color: MyColor().whiteClr,
                                                )
                                              : CupertinoActivityIndicator(
                                                  color: MyColor().whiteClr,
                                                ),
                                        )
                                      : Text(
                                          'Unfollow',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            color: MyColor().whiteClr,
                                            fontSize: 14,
                                          ),
                                        ),
                                ),
                              );
                            },
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
                        textAlign: TextAlign.center,
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
