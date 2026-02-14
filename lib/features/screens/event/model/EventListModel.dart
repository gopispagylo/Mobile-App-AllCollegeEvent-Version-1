import 'dart:math';
import 'dart:ui';

import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class EventListModel extends StatefulWidget {
  final bool isLogin;

  const EventListModel({super.key, required this.isLogin});

  @override
  State<EventListModel> createState() => _EventListModelState();
}

class _EventListModelState extends State<EventListModel> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: MyColor().whiteClr,
      color: MyColor().primaryClr,
      edgeOffset: 80,
      onRefresh: () async {
        context.read<TrendingEventListBloc>().add(
          FetchTrendingEventList(isLogin: widget.isLogin, loadMore: false),
        );
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          // Ongoing event list
          BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
            builder: (context, trendingEventState) {
              if (trendingEventState is TrendingEventListLoading) {
                return categoryShimmer();
              } else if (trendingEventState is TrendingEventListSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0, left: 16, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ongoing Events",
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
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                    isLogin: widget.isLogin,
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
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(
                          trendingEventState.trendingEventList.length,
                          15,
                        ),
                        itemBuilder: (context, index) {
                          final list =
                              trendingEventState.trendingEventList[index];

                          final title = list['title'];

                          String price;

                          if (list['tickets'] != null &&
                              list['tickets'].isNotEmpty &&
                              list['tickets'][0]['price'] != null &&
                              list['tickets'][0]['price'] != 0) {
                            price =
                                "₹${list['tickets'][0]['price'].toString()}";
                          } else {
                            price = "Free";
                          }

                          // ------ date format -------
                          String formatEventDate({required dynamic calendars}) {
                            if (calendars == null || calendars.isEmpty) {
                              return "No date";
                            }
                            final rawDate = calendars[0]['startDate'];

                            if (rawDate == null || rawDate.isEmpty) {
                              return "No date";
                            }
                            try {
                              final dateTime = DateTime.parse(rawDate);
                              return DateFormat('dd MMM yy').format(dateTime);
                            } catch (e) {
                              return "No date";
                            }
                          }

                          String venue;
                          // venue format
                          if (list['mode'] == "ONLINE") {
                            venue = 'Online';
                          } else {
                            venue = list['org']['city'];
                          }

                          // ------- image path ---------
                          final featuredImage =
                              (list['bannerImages'] != null &&
                                  list['bannerImages'].isNotEmpty)
                              ? list['bannerImages'][0]
                              : '';

                          // -------- identity ---------
                          final identity = list['slug'];
                          final paymentLink = list['paymentLink'];

                          // --------- categoryName ------
                          final categoryName =
                              list['categoryName'] ?? "No Categories";

                          // ---------- view count -----
                          final viewCount = list['viewCount'];

                          // event identity
                          final eventId = list['identity'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                    isLogin: widget.isLogin,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: index == 0 ? 16 : 0,
                              ),
                              width: 250,
                              decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ------ featured image -------
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 147,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Hero(
                                          tag: 'event_image_$identity',
                                          // child: Stack(
                                          //   fit: StackFit.expand,
                                          //   children: [
                                          //     ImageFiltered(
                                          //       imageFilter: ImageFilter.blur(
                                          //         sigmaX: 12,
                                          //         sigmaY: 12,
                                          //       ),
                                          //       child: CachedNetworkImage(
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //
                                          //     Center(
                                          //       child: CachedNetworkImage(
                                          //         fadeInDuration: Duration.zero,
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.contain,
                                          //         placeholder: (context, url) =>
                                          //             CircularProgressIndicator(
                                          //               color: MyColor().primaryClr,
                                          //             ),
                                          //         errorWidget:
                                          //             (context, url, error) =>
                                          //                 const Icon(
                                          //                   Iconsax.image,
                                          //                   size: 50,
                                          //                 ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImage ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Iconsax.image,
                                                        size: 50,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        child:
                                            BlocConsumer<
                                              RemoveSaveEventBloc,
                                              RemoveSaveEventState
                                            >(
                                              listener: (context, addSaveSate) {
                                                if (addSaveSate
                                                        is RemoveSaveEventFail &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  FlutterToast().flutterToast(
                                                    addSaveSate.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                } else if (addSaveSate
                                                        is AddSave &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  list['isSaved'] =
                                                      addSaveSate.checkSave;
                                                }
                                              },
                                              builder: (context, addSaveSate) {
                                                final bloc = context
                                                    .watch<
                                                      RemoveSaveEventBloc
                                                    >();
                                                final checkSave =
                                                    bloc.checkSave[list['identity']
                                                        .toString()] ??
                                                    list['isSaved'] ??
                                                    false;

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context
                                                              .read<
                                                                RemoveSaveEventBloc
                                                              >()
                                                              .add(
                                                                ClickRemoveSaveEvent(
                                                                  eventId:
                                                                      list['identity'],
                                                                ),
                                                              );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: ClipOval(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaY: 4,
                                                        sigmaX: 4,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: MyColor()
                                                                    .borderClr
                                                                    .withValues(
                                                                      alpha:
                                                                          0.2,
                                                                    ),
                                                              ),
                                                              color: MyColor()
                                                                  .whiteClr
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Icon(
                                                          checkSave
                                                              ? Icons.bookmark
                                                              : Icons
                                                                    .bookmark_outline,
                                                          size: 25,
                                                          color: checkSave
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ],
                                  ),

                                  // ------ icon --------
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            BlocConsumer<
                                              EventLikeBloc,
                                              EventLikeState
                                            >(
                                              listener: (context, state) {
                                                if (state is EventLikeFail &&
                                                    state.id == eventId) {
                                                  FlutterToast().flutterToast(
                                                    state.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                final bloc = context
                                                    .watch<EventLikeBloc>();

                                                final isLiked =
                                                    bloc.favStatus[eventId] ??
                                                    list['isLiked'] ??
                                                    false;

                                                final count =
                                                    bloc.likeCount[eventId] ??
                                                    (list['likeCount'] is int
                                                        ? list['likeCount']
                                                        : int.tryParse(
                                                                list['likeCount']
                                                                        ?.toString() ??
                                                                    '0',
                                                              ) ??
                                                              0);

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId: eventId,
                                                              initialFav:
                                                                  list['isLiked'],
                                                              initialCount: int.parse(
                                                                list['likeCount']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLiked
                                                            ? Iconsax.heart
                                                            : Iconsax
                                                                  .heart_copy,
                                                        color: isLiked
                                                            ? MyColor().redClr
                                                            : null,
                                                        size: 25,
                                                      ),
                                                      if (count != 0)
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      if (count != 0)
                                                        Text(
                                                          count.toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyColor()
                                                                    .secondaryClr,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.location_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  venue,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.ticket_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  price,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.calendar_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  formatEventDate(
                                                    calendars:
                                                        list['calendars'],
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------- event content --------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Iconsax.eye_copy,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              viewCount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor().secondaryClr,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0,
                                          right: 10,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryClr
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadiusGeometry.circular(40),
                                        ),
                                        child: Text(
                                          categoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
              }
              return SizedBox.shrink(child: Text("hdhfhf"));
            },
          ),

          // Upcoming event list
          BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
            builder: (context, trendingEventState) {
              if (trendingEventState is TrendingEventListLoading) {
                return categoryShimmer();
              } else if (trendingEventState is TrendingEventListSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 16, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upcoming Events",
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
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                    isLogin: widget.isLogin,
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
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(
                          trendingEventState.trendingEventList.length,
                          15,
                        ),
                        itemBuilder: (context, index) {
                          final list =
                              trendingEventState.trendingEventList[index];

                          final title = list['title'];

                          String price;

                          if (list['tickets'] != null &&
                              list['tickets'].isNotEmpty &&
                              list['tickets'][0]['price'] != null &&
                              list['tickets'][0]['price'] != 0) {
                            price =
                                "₹${list['tickets'][0]['price'].toString()}";
                          } else {
                            price = "Free";
                          }

                          // ------ date format -------
                          String formatEventDate({required dynamic calendars}) {
                            if (calendars == null || calendars.isEmpty) {
                              return "No date";
                            }
                            final rawDate = calendars[0]['startDate'];

                            if (rawDate == null || rawDate.isEmpty) {
                              return "No date";
                            }
                            try {
                              final dateTime = DateTime.parse(rawDate);
                              return DateFormat('dd MMM yy').format(dateTime);
                            } catch (e) {
                              return "No date";
                            }
                          }

                          String venue;
                          // venue format
                          if (list['mode'] == "ONLINE") {
                            venue = 'Online';
                          } else {
                            venue = list['org']['city'];
                          }

                          // ------- image path ---------
                          final featuredImage =
                              (list['bannerImages'] != null &&
                                  list['bannerImages'].isNotEmpty)
                              ? list['bannerImages'][0]
                              : '';

                          // -------- identity ---------
                          final identity = list['slug'];
                          final paymentLink = list['paymentLink'];

                          // --------- categoryName ------
                          final categoryName =
                              list['categoryName'] ?? "No Categories";

                          // ---------- view count -----
                          final viewCount = list['viewCount'];

                          // event identity
                          final eventId = list['identity'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                    isLogin: widget.isLogin,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: index == 0 ? 16 : 0,
                              ),
                              width: 250,
                              decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ------ featured image -------
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 147,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Hero(
                                          tag: 'event_image_$identity',
                                          // child: Stack(
                                          //   fit: StackFit.expand,
                                          //   children: [
                                          //     ImageFiltered(
                                          //       imageFilter: ImageFilter.blur(
                                          //         sigmaX: 12,
                                          //         sigmaY: 12,
                                          //       ),
                                          //       child: CachedNetworkImage(
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //
                                          //     Center(
                                          //       child: CachedNetworkImage(
                                          //         fadeInDuration: Duration.zero,
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.contain,
                                          //         placeholder: (context, url) =>
                                          //             CircularProgressIndicator(
                                          //               color: MyColor().primaryClr,
                                          //             ),
                                          //         errorWidget:
                                          //             (context, url, error) =>
                                          //                 const Icon(
                                          //                   Iconsax.image,
                                          //                   size: 50,
                                          //                 ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImage ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Iconsax.image,
                                                        size: 50,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        child:
                                            BlocConsumer<
                                              RemoveSaveEventBloc,
                                              RemoveSaveEventState
                                            >(
                                              listener: (context, addSaveSate) {
                                                if (addSaveSate
                                                        is RemoveSaveEventFail &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  FlutterToast().flutterToast(
                                                    addSaveSate.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                } else if (addSaveSate
                                                        is AddSave &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  list['isSaved'] =
                                                      addSaveSate.checkSave;
                                                }
                                              },
                                              builder: (context, addSaveSate) {
                                                final bloc = context
                                                    .watch<
                                                      RemoveSaveEventBloc
                                                    >();
                                                final checkSave =
                                                    bloc.checkSave[list['identity']
                                                        .toString()] ??
                                                    list['isSaved'] ??
                                                    false;

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context
                                                              .read<
                                                                RemoveSaveEventBloc
                                                              >()
                                                              .add(
                                                                ClickRemoveSaveEvent(
                                                                  eventId:
                                                                      list['identity'],
                                                                ),
                                                              );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: ClipOval(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaY: 4,
                                                        sigmaX: 4,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: MyColor()
                                                                    .borderClr
                                                                    .withValues(
                                                                      alpha:
                                                                          0.2,
                                                                    ),
                                                              ),
                                                              color: MyColor()
                                                                  .whiteClr
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Icon(
                                                          checkSave
                                                              ? Icons.bookmark
                                                              : Icons
                                                                    .bookmark_outline,
                                                          size: 25,
                                                          color: checkSave
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ],
                                  ),

                                  // ------ icon --------
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            BlocConsumer<
                                              EventLikeBloc,
                                              EventLikeState
                                            >(
                                              listener: (context, state) {
                                                if (state is EventLikeFail &&
                                                    state.id == eventId) {
                                                  FlutterToast().flutterToast(
                                                    state.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                final bloc = context
                                                    .watch<EventLikeBloc>();

                                                final isLiked =
                                                    bloc.favStatus[eventId] ??
                                                    list['isLiked'] ??
                                                    false;

                                                final count =
                                                    bloc.likeCount[eventId] ??
                                                    (list['likeCount'] is int
                                                        ? list['likeCount']
                                                        : int.tryParse(
                                                                list['likeCount']
                                                                        ?.toString() ??
                                                                    '0',
                                                              ) ??
                                                              0);

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId: eventId,
                                                              initialFav:
                                                                  list['isLiked'],
                                                              initialCount: int.parse(
                                                                list['likeCount']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLiked
                                                            ? Iconsax.heart
                                                            : Iconsax
                                                                  .heart_copy,
                                                        color: isLiked
                                                            ? MyColor().redClr
                                                            : null,
                                                        size: 25,
                                                      ),
                                                      if (count != 0)
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      if (count != 0)
                                                        Text(
                                                          count.toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyColor()
                                                                    .secondaryClr,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.location_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  venue,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.ticket_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  price,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.calendar_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  formatEventDate(
                                                    calendars:
                                                        list['calendars'],
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------- event content --------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Iconsax.eye_copy,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              viewCount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor().secondaryClr,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0,
                                          right: 10,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryClr
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadiusGeometry.circular(40),
                                        ),
                                        child: Text(
                                          categoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
              }
              return SizedBox.shrink(child: Text("hdhfhf"));
            },
          ),

          // Featured event list
          BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
            builder: (context, trendingEventState) {
              if (trendingEventState is TrendingEventListLoading) {
                return categoryShimmer();
              } else if (trendingEventState is TrendingEventListSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 16, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured Events",
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
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                    isLogin: widget.isLogin,
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
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(
                          trendingEventState.trendingEventList.length,
                          15,
                        ),
                        itemBuilder: (context, index) {
                          final list =
                              trendingEventState.trendingEventList[index];

                          final title = list['title'];

                          String price;

                          if (list['tickets'] != null &&
                              list['tickets'].isNotEmpty &&
                              list['tickets'][0]['price'] != null &&
                              list['tickets'][0]['price'] != 0) {
                            price =
                                "₹${list['tickets'][0]['price'].toString()}";
                          } else {
                            price = "Free";
                          }

                          // ------ date format -------
                          String formatEventDate({required dynamic calendars}) {
                            if (calendars == null || calendars.isEmpty) {
                              return "No date";
                            }
                            final rawDate = calendars[0]['startDate'];

                            if (rawDate == null || rawDate.isEmpty) {
                              return "No date";
                            }
                            try {
                              final dateTime = DateTime.parse(rawDate);
                              return DateFormat('dd MMM yy').format(dateTime);
                            } catch (e) {
                              return "No date";
                            }
                          }

                          String venue;
                          // venue format
                          if (list['mode'] == "ONLINE") {
                            venue = 'Online';
                          } else {
                            venue = list['org']['city'];
                          }

                          // ------- image path ---------
                          final featuredImage =
                              (list['bannerImages'] != null &&
                                  list['bannerImages'].isNotEmpty)
                              ? list['bannerImages'][0]
                              : '';

                          // -------- identity ---------
                          final identity = list['slug'];
                          final paymentLink = list['paymentLink'];

                          // --------- categoryName ------
                          final categoryName =
                              list['categoryName'] ?? "No Categories";

                          // ---------- view count -----
                          final viewCount = list['viewCount'];

                          // event identity
                          final eventId = list['identity'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                    isLogin: widget.isLogin,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: index == 0 ? 16 : 0,
                              ),
                              width: 250,
                              decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ------ featured image -------
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 147,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Hero(
                                          tag: 'event_image_$identity',
                                          // child: Stack(
                                          //   fit: StackFit.expand,
                                          //   children: [
                                          //     ImageFiltered(
                                          //       imageFilter: ImageFilter.blur(
                                          //         sigmaX: 12,
                                          //         sigmaY: 12,
                                          //       ),
                                          //       child: CachedNetworkImage(
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //
                                          //     Center(
                                          //       child: CachedNetworkImage(
                                          //         fadeInDuration: Duration.zero,
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.contain,
                                          //         placeholder: (context, url) =>
                                          //             CircularProgressIndicator(
                                          //               color: MyColor().primaryClr,
                                          //             ),
                                          //         errorWidget:
                                          //             (context, url, error) =>
                                          //                 const Icon(
                                          //                   Iconsax.image,
                                          //                   size: 50,
                                          //                 ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImage ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Iconsax.image,
                                                        size: 50,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        child:
                                            BlocConsumer<
                                              RemoveSaveEventBloc,
                                              RemoveSaveEventState
                                            >(
                                              listener: (context, addSaveSate) {
                                                if (addSaveSate
                                                        is RemoveSaveEventFail &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  FlutterToast().flutterToast(
                                                    addSaveSate.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                } else if (addSaveSate
                                                        is AddSave &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  list['isSaved'] =
                                                      addSaveSate.checkSave;
                                                }
                                              },
                                              builder: (context, addSaveSate) {
                                                final bloc = context
                                                    .watch<
                                                      RemoveSaveEventBloc
                                                    >();
                                                final checkSave =
                                                    bloc.checkSave[list['identity']
                                                        .toString()] ??
                                                    list['isSaved'] ??
                                                    false;

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context
                                                              .read<
                                                                RemoveSaveEventBloc
                                                              >()
                                                              .add(
                                                                ClickRemoveSaveEvent(
                                                                  eventId:
                                                                      list['identity'],
                                                                ),
                                                              );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: ClipOval(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaY: 4,
                                                        sigmaX: 4,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: MyColor()
                                                                    .borderClr
                                                                    .withValues(
                                                                      alpha:
                                                                          0.2,
                                                                    ),
                                                              ),
                                                              color: MyColor()
                                                                  .whiteClr
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Icon(
                                                          checkSave
                                                              ? Icons.bookmark
                                                              : Icons
                                                                    .bookmark_outline,
                                                          size: 25,
                                                          color: checkSave
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ],
                                  ),

                                  // ------ icon --------
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            BlocConsumer<
                                              EventLikeBloc,
                                              EventLikeState
                                            >(
                                              listener: (context, state) {
                                                if (state is EventLikeFail &&
                                                    state.id == eventId) {
                                                  FlutterToast().flutterToast(
                                                    state.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                final bloc = context
                                                    .watch<EventLikeBloc>();

                                                final isLiked =
                                                    bloc.favStatus[eventId] ??
                                                    list['isLiked'] ??
                                                    false;

                                                final count =
                                                    bloc.likeCount[eventId] ??
                                                    (list['likeCount'] is int
                                                        ? list['likeCount']
                                                        : int.tryParse(
                                                                list['likeCount']
                                                                        ?.toString() ??
                                                                    '0',
                                                              ) ??
                                                              0);

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId: eventId,
                                                              initialFav:
                                                                  list['isLiked'],
                                                              initialCount: int.parse(
                                                                list['likeCount']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLiked
                                                            ? Iconsax.heart
                                                            : Iconsax
                                                                  .heart_copy,
                                                        color: isLiked
                                                            ? MyColor().redClr
                                                            : null,
                                                        size: 25,
                                                      ),
                                                      if (count != 0)
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      if (count != 0)
                                                        Text(
                                                          count.toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyColor()
                                                                    .secondaryClr,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.location_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  venue,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.ticket_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  price,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.calendar_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  formatEventDate(
                                                    calendars:
                                                        list['calendars'],
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------- event content --------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Iconsax.eye_copy,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              viewCount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor().secondaryClr,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0,
                                          right: 10,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryClr
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadiusGeometry.circular(40),
                                        ),
                                        child: Text(
                                          categoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
              }
              return SizedBox.shrink(child: Text("hdhfhf"));
            },
          ),

          // trending event list
          BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
            builder: (context, trendingEventState) {
              if (trendingEventState is TrendingEventListLoading) {
                return categoryShimmer();
              } else if (trendingEventState is TrendingEventListSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 16, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending Events",
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
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                    isLogin: widget.isLogin,
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
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(
                          trendingEventState.trendingEventList.length,
                          15,
                        ),
                        itemBuilder: (context, index) {
                          final list =
                              trendingEventState.trendingEventList[index];

                          final title = list['title'];

                          String price;

                          if (list['tickets'] != null &&
                              list['tickets'].isNotEmpty &&
                              list['tickets'][0]['price'] != null &&
                              list['tickets'][0]['price'] != 0) {
                            price =
                                "₹${list['tickets'][0]['price'].toString()}";
                          } else {
                            price = "Free";
                          }

                          // ------ date format -------
                          String formatEventDate({required dynamic calendars}) {
                            if (calendars == null || calendars.isEmpty) {
                              return "No date";
                            }
                            final rawDate = calendars[0]['startDate'];

                            if (rawDate == null || rawDate.isEmpty) {
                              return "No date";
                            }
                            try {
                              final dateTime = DateTime.parse(rawDate);
                              return DateFormat('dd MMM yy').format(dateTime);
                            } catch (e) {
                              return "No date";
                            }
                          }

                          String venue;
                          // venue format
                          if (list['mode'] == "ONLINE") {
                            venue = 'Online';
                          } else {
                            venue = list['org']['city'];
                          }

                          // ------- image path ---------
                          final featuredImage =
                              (list['bannerImages'] != null &&
                                  list['bannerImages'].isNotEmpty)
                              ? list['bannerImages'][0]
                              : '';

                          // -------- identity ---------
                          final identity = list['slug'];
                          final paymentLink = list['paymentLink'];

                          // --------- categoryName ------
                          final categoryName =
                              list['categoryName'] ?? "No Categories";

                          // ---------- view count -----
                          final viewCount = list['viewCount'];

                          // event identity
                          final eventId = list['identity'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                    isLogin: widget.isLogin,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: index == 0 ? 16 : 0,
                              ),
                              width: 250,
                              decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ------ featured image -------
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 147,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Hero(
                                          tag: 'event_image_$identity',
                                          // child: Stack(
                                          //   fit: StackFit.expand,
                                          //   children: [
                                          //     ImageFiltered(
                                          //       imageFilter: ImageFilter.blur(
                                          //         sigmaX: 12,
                                          //         sigmaY: 12,
                                          //       ),
                                          //       child: CachedNetworkImage(
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //
                                          //     Center(
                                          //       child: CachedNetworkImage(
                                          //         fadeInDuration: Duration.zero,
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.contain,
                                          //         placeholder: (context, url) =>
                                          //             CircularProgressIndicator(
                                          //               color: MyColor().primaryClr,
                                          //             ),
                                          //         errorWidget:
                                          //             (context, url, error) =>
                                          //                 const Icon(
                                          //                   Iconsax.image,
                                          //                   size: 50,
                                          //                 ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImage ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Iconsax.image,
                                                        size: 50,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        child:
                                            BlocConsumer<
                                              RemoveSaveEventBloc,
                                              RemoveSaveEventState
                                            >(
                                              listener: (context, addSaveSate) {
                                                if (addSaveSate
                                                        is RemoveSaveEventFail &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  FlutterToast().flutterToast(
                                                    addSaveSate.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                } else if (addSaveSate
                                                        is AddSave &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  list['isSaved'] =
                                                      addSaveSate.checkSave;
                                                }
                                              },
                                              builder: (context, addSaveSate) {
                                                final bloc = context
                                                    .watch<
                                                      RemoveSaveEventBloc
                                                    >();
                                                final checkSave =
                                                    bloc.checkSave[list['identity']
                                                        .toString()] ??
                                                    list['isSaved'] ??
                                                    false;

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context
                                                              .read<
                                                                RemoveSaveEventBloc
                                                              >()
                                                              .add(
                                                                ClickRemoveSaveEvent(
                                                                  eventId:
                                                                      list['identity'],
                                                                ),
                                                              );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: ClipOval(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaY: 4,
                                                        sigmaX: 4,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: MyColor()
                                                                    .borderClr
                                                                    .withValues(
                                                                      alpha:
                                                                          0.2,
                                                                    ),
                                                              ),
                                                              color: MyColor()
                                                                  .whiteClr
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Icon(
                                                          checkSave
                                                              ? Icons.bookmark
                                                              : Icons
                                                                    .bookmark_outline,
                                                          size: 25,
                                                          color: checkSave
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ],
                                  ),

                                  // ------ icon --------
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            BlocConsumer<
                                              EventLikeBloc,
                                              EventLikeState
                                            >(
                                              listener: (context, state) {
                                                if (state is EventLikeFail &&
                                                    state.id == eventId) {
                                                  FlutterToast().flutterToast(
                                                    state.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                final bloc = context
                                                    .watch<EventLikeBloc>();

                                                final isLiked =
                                                    bloc.favStatus[eventId] ??
                                                    list['isLiked'] ??
                                                    false;

                                                final count =
                                                    bloc.likeCount[eventId] ??
                                                    (list['likeCount'] is int
                                                        ? list['likeCount']
                                                        : int.tryParse(
                                                                list['likeCount']
                                                                        ?.toString() ??
                                                                    '0',
                                                              ) ??
                                                              0);

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId: eventId,
                                                              initialFav:
                                                                  list['isLiked'],
                                                              initialCount: int.parse(
                                                                list['likeCount']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLiked
                                                            ? Iconsax.heart
                                                            : Iconsax
                                                                  .heart_copy,
                                                        color: isLiked
                                                            ? MyColor().redClr
                                                            : null,
                                                        size: 25,
                                                      ),
                                                      if (count != 0)
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      if (count != 0)
                                                        Text(
                                                          count.toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyColor()
                                                                    .secondaryClr,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.location_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  venue,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.ticket_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  price,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.calendar_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  formatEventDate(
                                                    calendars:
                                                        list['calendars'],
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------- event content --------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Iconsax.eye_copy,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              viewCount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor().secondaryClr,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0,
                                          right: 10,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryClr
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadiusGeometry.circular(40),
                                        ),
                                        child: Text(
                                          categoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
              }
              return SizedBox.shrink(child: Text("hdhfhf"));
            },
          ),

          // Virtual event list
          BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
            builder: (context, trendingEventState) {
              if (trendingEventState is TrendingEventListLoading) {
                return categoryShimmer();
              } else if (trendingEventState is TrendingEventListSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 16, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Virtual Events",
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
                                  builder: (_) => BottomNavigationBarPage(
                                    pageIndex: 1,
                                    whichScreen: '',
                                    isLogin: widget.isLogin,
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
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(
                          trendingEventState.trendingEventList.length,
                          15,
                        ),
                        itemBuilder: (context, index) {
                          final list =
                              trendingEventState.trendingEventList[index];

                          final title = list['title'];

                          String price;

                          if (list['tickets'] != null &&
                              list['tickets'].isNotEmpty &&
                              list['tickets'][0]['price'] != null &&
                              list['tickets'][0]['price'] != 0) {
                            price =
                                "₹${list['tickets'][0]['price'].toString()}";
                          } else {
                            price = "Free";
                          }

                          // ------ date format -------
                          String formatEventDate({required dynamic calendars}) {
                            if (calendars == null || calendars.isEmpty) {
                              return "No date";
                            }
                            final rawDate = calendars[0]['startDate'];

                            if (rawDate == null || rawDate.isEmpty) {
                              return "No date";
                            }
                            try {
                              final dateTime = DateTime.parse(rawDate);
                              return DateFormat('dd MMM yy').format(dateTime);
                            } catch (e) {
                              return "No date";
                            }
                          }

                          String venue;
                          // venue format
                          if (list['mode'] == "ONLINE") {
                            venue = 'Online';
                          } else {
                            venue = list['org']['city'];
                          }

                          // ------- image path ---------
                          final featuredImage =
                              (list['bannerImages'] != null &&
                                  list['bannerImages'].isNotEmpty)
                              ? list['bannerImages'][0]
                              : '';

                          // -------- identity ---------
                          final identity = list['slug'];
                          final paymentLink = list['paymentLink'];

                          // --------- categoryName ------
                          final categoryName =
                              list['categoryName'] ?? "No Categories";

                          // ---------- view count -----
                          final viewCount = list['viewCount'];

                          // event identity
                          final eventId = list['identity'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                    isLogin: widget.isLogin,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: index == 0 ? 16 : 0,
                              ),
                              width: 250,
                              decoration: BoxDecoration(
                                color: MyColor().boxInnerClr,
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ------ featured image -------
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 147,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Hero(
                                          tag: 'event_image_$identity',
                                          // child: Stack(
                                          //   fit: StackFit.expand,
                                          //   children: [
                                          //     ImageFiltered(
                                          //       imageFilter: ImageFilter.blur(
                                          //         sigmaX: 12,
                                          //         sigmaY: 12,
                                          //       ),
                                          //       child: CachedNetworkImage(
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //
                                          //     Center(
                                          //       child: CachedNetworkImage(
                                          //         fadeInDuration: Duration.zero,
                                          //         imageUrl: featuredImage ?? '',
                                          //         fit: BoxFit.contain,
                                          //         placeholder: (context, url) =>
                                          //             CircularProgressIndicator(
                                          //               color: MyColor().primaryClr,
                                          //             ),
                                          //         errorWidget:
                                          //             (context, url, error) =>
                                          //                 const Icon(
                                          //                   Iconsax.image,
                                          //                   size: 50,
                                          //                 ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImage ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Iconsax.image,
                                                        size: 50,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        child:
                                            BlocConsumer<
                                              RemoveSaveEventBloc,
                                              RemoveSaveEventState
                                            >(
                                              listener: (context, addSaveSate) {
                                                if (addSaveSate
                                                        is RemoveSaveEventFail &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  FlutterToast().flutterToast(
                                                    addSaveSate.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                } else if (addSaveSate
                                                        is AddSave &&
                                                    addSaveSate.eventId ==
                                                        list['identity']) {
                                                  list['isSaved'] =
                                                      addSaveSate.checkSave;
                                                }
                                              },
                                              builder: (context, addSaveSate) {
                                                final bloc = context
                                                    .watch<
                                                      RemoveSaveEventBloc
                                                    >();
                                                final checkSave =
                                                    bloc.checkSave[list['identity']
                                                        .toString()] ??
                                                    list['isSaved'] ??
                                                    false;

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context
                                                              .read<
                                                                RemoveSaveEventBloc
                                                              >()
                                                              .add(
                                                                ClickRemoveSaveEvent(
                                                                  eventId:
                                                                      list['identity'],
                                                                ),
                                                              );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: ClipOval(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaY: 4,
                                                        sigmaX: 4,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: MyColor()
                                                                    .borderClr
                                                                    .withValues(
                                                                      alpha:
                                                                          0.2,
                                                                    ),
                                                              ),
                                                              color: MyColor()
                                                                  .whiteClr
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Icon(
                                                          checkSave
                                                              ? Icons.bookmark
                                                              : Icons
                                                                    .bookmark_outline,
                                                          size: 25,
                                                          color: checkSave
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ],
                                  ),

                                  // ------ icon --------
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            BlocConsumer<
                                              EventLikeBloc,
                                              EventLikeState
                                            >(
                                              listener: (context, state) {
                                                if (state is EventLikeFail &&
                                                    state.id == eventId) {
                                                  FlutterToast().flutterToast(
                                                    state.errorMessage,
                                                    ToastificationType.error,
                                                    ToastificationStyle.flat,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                final bloc = context
                                                    .watch<EventLikeBloc>();

                                                final isLiked =
                                                    bloc.favStatus[eventId] ??
                                                    list['isLiked'] ??
                                                    false;

                                                final count =
                                                    bloc.likeCount[eventId] ??
                                                    (list['likeCount'] is int
                                                        ? list['likeCount']
                                                        : int.tryParse(
                                                                list['likeCount']
                                                                        ?.toString() ??
                                                                    '0',
                                                              ) ??
                                                              0);

                                                return InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: widget.isLogin
                                                      ? () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId: eventId,
                                                              initialFav:
                                                                  list['isLiked'],
                                                              initialCount: int.parse(
                                                                list['likeCount']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () async {
                                                          final getUserClick =
                                                              await DBHelper()
                                                                  .getUser();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginPage(
                                                                    whichScreen:
                                                                        getUserClick!,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLiked
                                                            ? Iconsax.heart
                                                            : Iconsax
                                                                  .heart_copy,
                                                        color: isLiked
                                                            ? MyColor().redClr
                                                            : null,
                                                        size: 25,
                                                      ),
                                                      if (count != 0)
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      if (count != 0)
                                                        Text(
                                                          count.toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyColor()
                                                                    .secondaryClr,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.location_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  venue,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.ticket_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  price,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.calendar_copy,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  formatEventDate(
                                                    calendars:
                                                        list['calendars'],
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------- event content --------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Iconsax.eye_copy,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              viewCount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor().secondaryClr,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0,
                                          right: 10,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().primaryClr
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadiusGeometry.circular(40),
                                        ),
                                        child: Text(
                                          categoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
              }
              return SizedBox.shrink(child: Text("hdhfhf"));
            },
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }

  // ------ skeleton loading ------
  Widget categoryShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Shimmer(
            child: Container(
              margin: EdgeInsets.only(
                left: 16,
                right: index == 5 ? 16 : 0,
                top: 15,
              ),
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColor().sliderDotClr,
              ),
            ),
          );
        }),
      ),
    );
  }
}
