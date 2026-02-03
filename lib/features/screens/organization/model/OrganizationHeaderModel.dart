import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerDetailBloc/organizer_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/bloc/organizerEventListBloc/organizer_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationHeaderModel extends StatefulWidget {
  const OrganizationHeaderModel({super.key});

  @override
  State<OrganizationHeaderModel> createState() =>
      _OrganizationHeaderModelState();
}

class _OrganizationHeaderModelState extends State<OrganizationHeaderModel> {
  // --------- tab bar index -------
  int selectedIndex = 0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizerDetailBloc, OrganizerDetailState>(
      builder: (context, orgState) {
        if (orgState is OrganizerDetailLoading) {
          return eventDetailShimmer();
        }
        if (orgState is OrganizerDetailSuccess) {
          final list = orgState.organizerDetailList[0];
          // title
          final title = list['org']['organizationName'];
          // profile photo
          final profilePhoto =
              (list['org']['profileImage'] != null &&
                  list['org']['profileImage'].isNotEmpty)
              ? list['org']['profileImage']
              : '';
          // event count
          final eventCount = list['org']['eventCount'];

          return Container(
            margin: EdgeInsets.all(16),
            child: ListView(
              children: [
                // -------- Carousel Slider ------
                if (list['bannerImages'] != null &&
                    list['bannerImages'].isNotEmpty)
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: list['bannerImages'].length,
                        itemBuilder: (BuildContext context, index, realIndex) {
                          final sliderList = list['bannerImages'][index];
                          return GestureDetector(
                            onTap: () {
                              // print("sliderListsliderListsliderListsliderListsliderList${sliderList['id']}");
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: sliderList,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Icon(Iconsax.image);
                                  },
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: MyColor().primaryClr,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          enlargeCenterPage: true,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          viewportFraction: 1,
                          aspectRatio: 1.9,
                          clipBehavior: Clip.antiAlias,
                          pageSnapping: true,
                          padEnds: true,
                          animateToClosest: true,
                        ),
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: currentPage,
                        count: list['bannerImages'].length,
                        effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: MyColor().primaryClr,
                          dotColor: MyColor().sliderDotClr,
                          spacing: 8,
                        ),
                      ),
                    ],
                  ),

                // ----- title ------
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: profilePhoto ?? '',
                        width: 70,
                        height: 70,
                        placeholder: (context, url) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Icon(Iconsax.image);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor().primaryClr,
                        border: Border.all(
                          color: MyColor().borderClr.withOpacity(0.15),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Follow",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: MyColor().whiteClr,
                        ),
                      ),
                    ),
                  ],
                ),

                // ----- rank card ---------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().primaryBackgroundClr.withOpacity(
                                0.40,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Iconsax.ticket_copy,
                                  color: MyColor().primaryClr,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '$eventCount Events',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: MyColor().blackClr,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().yellowClr.withOpacity(0.15),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.star, color: MyColor().yellowClr),
                                SizedBox(height: 5),
                                Text(
                                  '4.9/2508 reviews',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().primaryBackgroundClr.withOpacity(
                                0.40,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Iconsax.ranking_1,
                                  color: MyColor().primaryClr,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '1725 Rank',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ------- Upcoming & Past events
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: customTabBar(
                            title: 'Upcoming Events',
                            index: 0,
                          ),
                        ),
                        Expanded(
                          child: customTabBar(title: 'Past Events', index: 1),
                        ),
                      ],
                    ),
                  ),
                ),

                // --------- Upcoming & Past event ui
                BlocBuilder<OrganizerEventListBloc, OrganizerEventListState>(
                  builder: (context, organizerEventState) {
                    if (organizerEventState is OrganizerEventLoading) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return eventCardShimmer();
                        },
                      );
                    } else if (organizerEventState is OrganizerEventSuccess) {
                      return Container(
                        child: selectedIndex == 0
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 0,
                                      right: 0,
                                      top: 16,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: organizerEventState
                                          .organizerEventList
                                          .length,
                                      itemBuilder: (context, index) {
                                        final list = organizerEventState
                                            .organizerEventList[index];

                                        // -------- field name ------------
                                        final title =
                                            list['title'] ?? "No title";

                                        final featuredImagePath =
                                            (list['bannerImages'] != null &&
                                                list['bannerImages'].isNotEmpty)
                                            ? list['bannerImages'][0]
                                            : '';

                                        // ------ date format -------
                                        final rawDate =
                                            list['eventDate']?.toString() ?? "";

                                        // 2. Safe Date Parsing
                                        String dateFormat = "Date TBD";

                                        if (rawDate.isNotEmpty) {
                                          try {
                                            // Use MM for months!
                                            final parsedDate = DateFormat(
                                              'dd/MM/yyyy',
                                            ).parse(rawDate);
                                            dateFormat = DateFormat(
                                              'dd MMM yyyy',
                                            ).format(parsedDate);
                                          } catch (e) {
                                            debugPrint(
                                              "Date parsing error: $e",
                                            );
                                            dateFormat =
                                                rawDate; // Fallback to raw string if parsing fails
                                          }
                                        }

                                        // ---- venue ---
                                        final venue =
                                            list['venue'] ?? "no venue";

                                        // -------- identity ---------
                                        final identity = list['slug'];

                                        // final identity = list['slug'];

                                        final paymentLink = list['paymentLink'];

                                        // event identity
                                        final eventId = list['identity']
                                            .toString();

                                        // ------- Tween Animation -----------
                                        return TweenAnimationBuilder(
                                          tween: Tween(begin: 50.0, end: 0.0),
                                          duration: Duration(milliseconds: 600),
                                          builder: (context, value, child) {
                                            return Transform.translate(
                                              offset: Offset(0, value),
                                              child: Opacity(
                                                opacity: 1 - (value / 50),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      EventDetailPage(
                                                        slug: identity,
                                                        title: title,
                                                        whichScreen: 'view',
                                                        paymentLink:
                                                            paymentLink,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                left: 0,
                                                bottom: 16,
                                              ),
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 5,
                                                bottom: 5,
                                                top: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: MyColor().whiteClr,
                                                border: Border.all(
                                                  color: MyColor().borderClr
                                                      .withOpacity(0.15),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: Hero(
                                                        tag:
                                                            'event_image_$identity',
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              featuredImagePath,
                                                          fit: BoxFit.cover,
                                                          height: 110,
                                                          placeholder:
                                                              (
                                                                context,
                                                                url,
                                                              ) => Center(
                                                                child: CircularProgressIndicator(
                                                                  color: MyColor()
                                                                      .primaryClr,
                                                                ),
                                                              ),
                                                          errorWidget:
                                                              (
                                                                context,
                                                                url,
                                                                error,
                                                              ) => const Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        5,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  title,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  BlocConsumer<
                                                                    EventLikeBloc,
                                                                    EventLikeState
                                                                  >(
                                                                    listener:
                                                                        (
                                                                          context,
                                                                          state,
                                                                        ) {
                                                                          if (state
                                                                                  is EventLikeFail &&
                                                                              state.id ==
                                                                                  eventId) {
                                                                            FlutterToast().flutterToast(
                                                                              state.errorMessage,
                                                                              ToastificationType.error,
                                                                              ToastificationStyle.flat,
                                                                            );
                                                                          }
                                                                        },
                                                                    builder:
                                                                        (
                                                                          context,
                                                                          state,
                                                                        ) {
                                                                          final bloc = context
                                                                              .watch<
                                                                                EventLikeBloc
                                                                              >();

                                                                          final isLiked =
                                                                              bloc.favStatus[eventId] ??
                                                                              list['isLiked'];

                                                                          final count =
                                                                              bloc.likeCount[eventId] ??
                                                                              int.parse(
                                                                                list['likeCount'].toString(),
                                                                              );

                                                                          return InkWell(
                                                                            customBorder:
                                                                                const CircleBorder(),
                                                                            onTap: () {
                                                                              context
                                                                                  .read<
                                                                                    EventLikeBloc
                                                                                  >()
                                                                                  .add(
                                                                                    ClickEventLike(
                                                                                      eventId: eventId,
                                                                                      initialFav: list['isLiked'],
                                                                                      initialCount: int.parse(
                                                                                        list['likeCount'].toString(),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                            },
                                                                            child: Row(
                                                                              children: [
                                                                                Icon(
                                                                                  isLiked
                                                                                      ? Icons.favorite
                                                                                      : Icons.favorite_border,
                                                                                  color: isLiked
                                                                                      ? MyColor().redClr
                                                                                      : null,
                                                                                  size: 25,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  count.toString(),
                                                                                  style: GoogleFonts.poppins(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    color: MyColor().secondaryClr,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  BlocConsumer<
                                                                    RemoveSaveEventBloc,
                                                                    RemoveSaveEventState
                                                                  >(
                                                                    listener:
                                                                        (
                                                                          context,
                                                                          addSaveSate,
                                                                        ) {
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
                                                                    builder:
                                                                        (
                                                                          context,
                                                                          addSaveSate,
                                                                        ) {
                                                                          final bloc = context
                                                                              .watch<
                                                                                RemoveSaveEventBloc
                                                                              >();
                                                                          // final checkSave = bloc.checkSave[list['identity'].toString()] ?? list['isSaved'];
                                                                          final checkSave =
                                                                              false;

                                                                          return InkWell(
                                                                            onTap: () {
                                                                              context
                                                                                  .read<
                                                                                    RemoveSaveEventBloc
                                                                                  >()
                                                                                  .add(
                                                                                    ClickRemoveSaveEvent(
                                                                                      eventId: list['identity'],
                                                                                    ),
                                                                                  );
                                                                            },
                                                                            child: Container(
                                                                              padding: EdgeInsets.all(
                                                                                10,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: MyColor().borderClr.withOpacity(
                                                                                    0.15,
                                                                                  ),
                                                                                ),
                                                                                color: MyColor().boxInnerClr,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Icon(
                                                                                checkSave
                                                                                    ? Icons.bookmark
                                                                                    : Icons.bookmark_outline,
                                                                                size: 15,
                                                                                color: checkSave
                                                                                    ? MyColor().primaryClr
                                                                                    : null,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              chip(
                                                                "Paid",
                                                                MyColor()
                                                                    .primaryBackgroundClr
                                                                    .withOpacity(
                                                                      0.35,
                                                                    ),
                                                              ),
                                                              chip(
                                                                "Entertainment",
                                                                MyColor()
                                                                    .blueBackgroundClr
                                                                    .withOpacity(
                                                                      0.35,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                size: 14,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  dateFormat,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                size: 14,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  venue,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      vertical:
                                                                          3,
                                                                      horizontal:
                                                                          8,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color: MyColor()
                                                                      .primaryBackgroundClr
                                                                      .withOpacity(
                                                                        0.35,
                                                                      ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                                child: Text(
                                                                  "Ongoing",
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: MyColor()
                                                                        .blackClr,
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
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(height: 20),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: organizerEventState
                                        .organizerEventList
                                        .length,
                                    itemBuilder: (context, index) {
                                      final gridList =
                                          orgState.organizerDetailList[index];
                                      final featuredImagePath =
                                          (gridList['bannerImages'] != null &&
                                              gridList['bannerImages']
                                                  .isNotEmpty)
                                          ? gridList['bannerImages'][0]
                                          : '';

                                      final title =
                                          gridList['title'] ?? "No title";
                                      final view = gridList['viewCount'] ?? 0;

                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MyColor().borderClr
                                                .withOpacity(0.15),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            // -------- image -------
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      featuredImagePath ?? '',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: MyColor()
                                                                .primaryClr,
                                                          ),
                                                    );
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                        return Icon(
                                                          Iconsax.image,
                                                        );
                                                      },
                                                ),
                                              ),
                                            ),

                                            // First gradient
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black.withOpacity(
                                                        0.5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // Second stronger gradient
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.center,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black.withOpacity(
                                                        0.95,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 12,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      title,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: MyColor()
                                                                .whiteClr,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$view views",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: MyColor()
                                                                .whiteClr,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 0.6,
                                        ),
                                  ),
                                ],
                              ),
                      );
                    } else if (organizerEventState is OrganizerEventFail) {
                      return Center(
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                organizerEventState.errorMessage,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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

                // ------- social media -------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: MyColor().borderClr.withOpacity(0.15),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (list['socialLinks']['linkedin'] != null ||
                            list['socialLinks']['linkedin'].isNotEmpty ||
                            list['socialLinks']['instagram'] != null ||
                            list['socialLinks']['instagram'].isNotEmpty ||
                            list['socialLinks']['whatsapp'] != null ||
                            list['socialLinks']['whatsapp'].isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (list['socialLinks']['whatsapp'] != null &&
                                  list['socialLinks']['whatsapp'].isNotEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    final whatsApp = Uri.parse(
                                      list['socialLinks']['whatsapp'],
                                    );
                                    await launchUrl(
                                      whatsApp,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      ImagePath().whatsapp,
                                      height: 40,
                                    ),
                                  ),
                                ),

                              if (list['socialLinks']['instagram'] != null &&
                                  list['socialLinks']['instagram'].isNotEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    final whatsApp = Uri.parse(
                                      list['socialLinks']['instagram'],
                                    );
                                    await launchUrl(
                                      whatsApp,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      ImagePath().instagram,
                                      height: 37,
                                    ),
                                  ),
                                ),

                              if (list['socialLinks']['linkedin'] != null &&
                                  list['socialLinks']['linkedin'].isNotEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    final whatsApp = Uri.parse(
                                      list['socialLinks']['linkedin'],
                                    );
                                    await launchUrl(
                                      whatsApp,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      ImagePath().linkedIn,
                                      height: 35,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.add_copy),
                                    Container(child: Text("Follow")),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.share),
                                    Container(child: Text("Share")),
                                  ],
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
          );
        } else if (orgState is OrganizerDetailFail) {
          return RefreshIndicator(
            onRefresh: () async {
              // context.read<EventListBloc>().add(FetchEventList());
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
        return SizedBox();
      },
    );
  }

  // --------- Custom Tab Bar --------------
  Widget customTabBar({required String title, required int index}) {
    final selectedValue = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: !selectedValue
              ? MyColor().boxInnerClr
              : MyColor().blueClr.withOpacity(0.15),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: MyColor().blackClr,
          ),
        ),
      ),
    );
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
      margin: const EdgeInsets.only(bottom: 16, top: 20),
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
                          color: MyColor().sliderDotClr,
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

  // -------- skeleton loader ---------
  Widget eventDetailShimmer() {
    Widget box({double h = 12, double w = double.infinity, double r = 8}) {
      return Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: MyColor().sliderDotClr,
          borderRadius: BorderRadius.circular(r),
        ),
      );
    }

    Widget circle(double size) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: MyColor().sliderDotClr,
          shape: BoxShape.circle,
        ),
      );
    }

    return ListView(
      children: [
        // ---------- Carousel ----------
        Shimmer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: box(h: 200, r: 12),
          ),
        ),

        // ---------- Indicator ----------
        Shimmer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) =>
                  Padding(padding: const EdgeInsets.all(4), child: circle(10)),
            ),
          ),
        ),

        // ---------- Organizer Row ----------
        Shimmer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                circle(70),
                const SizedBox(width: 10),
                Expanded(child: box(h: 18)),
                const SizedBox(width: 10),
                box(h: 36, w: 80, r: 30),
              ],
            ),
          ),
        ),

        // ---------- Rank Cards ----------
        Shimmer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (_) => box(h: 70, w: 90, r: 10)),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ---------- Tabs ----------
        Shimmer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: box(h: 50, r: 30),
          ),
        ),

        const SizedBox(height: 16),

        // ---------- Event Cards ----------
        Shimmer(
          child: Column(
            children: List.generate(
              3,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColor().sliderDotClr.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      box(h: 90, w: 90, r: 10),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            box(h: 14),
                            const SizedBox(height: 6),
                            box(h: 12, w: 150),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                box(h: 18, w: 60, r: 20),
                                const SizedBox(width: 8),
                                box(h: 18, w: 80, r: 20),
                              ],
                            ),
                            const SizedBox(height: 10),
                            box(h: 12, w: 120),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ---------- Social Media ----------
        Shimmer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: circle(40),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: box(h: 48, r: 30)),
                    const SizedBox(width: 16),
                    Expanded(child: box(h: 48, r: 30)),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
