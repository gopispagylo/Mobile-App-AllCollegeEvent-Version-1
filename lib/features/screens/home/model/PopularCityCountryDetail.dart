import 'dart:io';
import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/countryBasedEventBloc/country_based_event_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/globalUnFocus/GlobalUnFocus.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class PopularCityCountryDetail extends StatefulWidget {
  final bool isLogin;
  final String country;
  final String countryCode;

  const PopularCityCountryDetail({
    super.key,
    required this.isLogin,
    required this.country,
    required this.countryCode,
  });

  @override
  State<PopularCityCountryDetail> createState() =>
      _PopularCityCountryDetailState();
}

class _PopularCityCountryDetailState extends State<PopularCityCountryDetail> {
  // ---------- recent search active inactive ----------
  bool isRecent = false;

  // ------ pagination setup -----
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  CountryBasedEventBloc(apiController: ApiController())..add(
                    FetchCountryBaseEvent(
                      isLogin: widget.isLogin,
                      countryCode: widget.countryCode,
                      name: widget.country,
                    ),
                  ),
            ),
            BlocProvider(
              create: (context) =>
                  RemoveSaveEventBloc(apiController: ApiController()),
            ),
            BlocProvider(
              create: (context) =>
                  EventLikeBloc(apiController: ApiController()),
            ),
          ],
          child: Builder(
            builder: (context) {
              return RefreshIndicator(
                backgroundColor: MyColor().whiteClr,
                color: MyColor().primaryClr,
                onRefresh: () async {
                  final bloc = context.read<CountryBasedEventBloc>();

                  bloc.add(
                    FetchCountryBaseEvent(
                      isLogin: widget.isLogin,
                      countryCode: widget.countryCode,
                      name: widget.country,
                    ),
                  );

                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    final bloc = context.read<CountryBasedEventBloc>();

                    if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                      if (bloc.hasMore && !bloc.isLoadingMore) {
                        bloc.add(
                          FetchCountryBaseEvent(
                            isLogin: widget.isLogin,
                            countryCode: widget.countryCode,
                            name: widget.country,
                            loadMore: true,
                          ),
                        );
                      }
                    }
                    return false;
                  },
                  child: CustomScrollView(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Container(
                              height: 160,
                              child: Image.asset(
                                ImagePath().worldImg,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Platform.isAndroid
                                        ? Icons.arrow_back
                                        : Icons.arrow_back_ios,
                                    color: MyColor().whiteClr,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 80,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        floating: false,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(18),
                          child:
                              BlocBuilder<
                                CountryBasedEventBloc,
                                CountryBasedEventState
                              >(
                                builder: (context, state) {
                                  return ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5,
                                        sigmaY: 5,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColor().whiteClr.withOpacity(
                                            0.07,
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 16,
                                              left: 16,
                                              right: 16,
                                            ),
                                            child: TextFormField(
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (_) => BottomNavigationBarPage(
                                                //       pageIndex: 1,
                                                //       whichScreen: '',
                                                //       isLogin: true,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              onTapOutside: (onChanged) {
                                                WidgetsBinding
                                                    .instance
                                                    .focusManager
                                                    .primaryFocus!
                                                    .unfocus();
                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(
                                                  10,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            100,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            MyColor().borderClr,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: MyColor()
                                                            .primaryClr,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  size: 18,
                                                ),
                                                hintText: "Search Events",
                                                fillColor: MyColor().whiteClr
                                                    .withValues(alpha: 0.5),
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
                                  );
                                },
                              ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        sliver: BlocBuilder<CountryBasedEventBloc, CountryBasedEventState>(
                          builder: (context, countryCityBasedEventState) {
                            if (countryCityBasedEventState
                                is CountryBasedEventLoading) {
                              return SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (countryCityBasedEventState
                                is CountryBasedEventSuccess) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index ==
                                        countryCityBasedEventState
                                            .countryBasedEventList
                                            .length) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Center(
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator(
                                                  color: MyColor().primaryClr,
                                                )
                                              : CupertinoActivityIndicator(
                                                  color: MyColor().primaryClr,
                                                ),
                                        ),
                                      );
                                    }
                                    final list = countryCityBasedEventState
                                        .countryBasedEventList[index];

                                    // -------- field name ------------
                                    final title = list['title'] ?? "No title";

                                    final featuredImagePath =
                                        (list['bannerImages'] != null &&
                                            list['bannerImages'].isNotEmpty)
                                        ? list['bannerImages'][0]
                                        : '';

                                    // ------ date format -------
                                    String formatEventDate({
                                      required dynamic calendars,
                                    }) {
                                      if (calendars == null ||
                                          calendars.isEmpty) {
                                        return "No date";
                                      }
                                      final rawDate = calendars[0]['startDate'];

                                      if (rawDate == null || rawDate.isEmpty) {
                                        return "No date";
                                      }
                                      try {
                                        final dateTime = DateTime.parse(
                                          rawDate,
                                        );
                                        return DateFormat(
                                          'dd MMM yy',
                                        ).format(dateTime);
                                      } catch (e) {
                                        return "No date";
                                      }
                                    }

                                    String venue;
                                    // venue format
                                    if (list['mode'] == "ONLINE") {
                                      venue = 'Online';
                                    } else {
                                      venue = list['location']['venue'];
                                    }

                                    // -------- identity ---------
                                    final identity = list['slug'];
                                    final paymentLink =
                                        list['paymentLink'] ?? "";
                                    // event identity
                                    final eventId = list['identity'].toString();
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
                                          if (!isRecent) {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    EventDetailPage(
                                                      slug: identity,
                                                      title: title,
                                                      whichScreen: 'view',
                                                      paymentLink:
                                                          paymentLink ?? "",
                                                      isLogin: widget.isLogin,
                                                    ),
                                                transitionsBuilder:
                                                    (_, animation, __, child) {
                                                      return SlideTransition(
                                                        position: Tween(
                                                          begin: const Offset(
                                                            1,
                                                            0,
                                                          ),
                                                          end: Offset.zero,
                                                        ).animate(animation),
                                                        child: child,
                                                      );
                                                    },
                                              ),
                                            );
                                          } else {
                                            GlobalUnFocus.unFocus();
                                            setState(() {
                                              isRecent = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 0,
                                            bottom: 16,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: MyColor().whiteClr,
                                            border: Border.all(
                                              color: MyColor().borderClr
                                                  .withOpacity(0.15),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    child: CachedNetworkImage(
                                                      // memCacheHeight: 300,
                                                      fadeInDuration:
                                                          Duration.zero,
                                                      imageUrl:
                                                          featuredImagePath,
                                                      fit: BoxFit.cover,
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
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              BlocConsumer<
                                                                EventLikeBloc,
                                                                EventLikeState
                                                              >(
                                                                listener: (context, state) {
                                                                  if (state
                                                                          is EventLikeFail &&
                                                                      state.id ==
                                                                          eventId) {
                                                                    FlutterToast().flutterToast(
                                                                      state
                                                                          .errorMessage,
                                                                      ToastificationType
                                                                          .error,
                                                                      ToastificationStyle
                                                                          .flat,
                                                                    );
                                                                  }
                                                                },
                                                                builder: (context, state) {
                                                                  final bloc =
                                                                      context
                                                                          .watch<
                                                                            EventLikeBloc
                                                                          >();

                                                                  final isLiked =
                                                                      bloc.favStatus[eventId] ??
                                                                      list['isLiked'] ??
                                                                      false;

                                                                  final count =
                                                                      bloc.likeCount[eventId] ??
                                                                      int.parse(
                                                                        list['likeCount']
                                                                            .toString(),
                                                                      );

                                                                  return InkWell(
                                                                    customBorder:
                                                                        const CircleBorder(),
                                                                    onTap:
                                                                        widget
                                                                            .isLogin
                                                                        ? () {
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
                                                                          }
                                                                        : () async {
                                                                            final getUserClick =
                                                                                await DBHelper().getUser();
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder:
                                                                                    (
                                                                                      _,
                                                                                    ) => LoginPage(
                                                                                      whichScreen: getUserClick!,
                                                                                    ),
                                                                              ),
                                                                            );
                                                                          },
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          isLiked
                                                                              ? Iconsax.heart
                                                                              : Iconsax.heart_copy,
                                                                          color:
                                                                              isLiked
                                                                              ? MyColor().redClr
                                                                              : null,
                                                                          size:
                                                                              25,
                                                                        ),
                                                                        if (count !=
                                                                            0)
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                        if (count !=
                                                                            0)
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
                                                                          addSaveSate
                                                                              .errorMessage,
                                                                          ToastificationType
                                                                              .error,
                                                                          ToastificationStyle
                                                                              .flat,
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
                                                                      final checkSave =
                                                                          bloc.checkSave[list['identity']
                                                                              .toString()] ??
                                                                          list['isSaved'] ??
                                                                          false;

                                                                      return InkWell(
                                                                        onTap:
                                                                            widget.isLogin
                                                                            ? () {
                                                                                context
                                                                                    .read<
                                                                                      RemoveSaveEventBloc
                                                                                    >()
                                                                                    .add(
                                                                                      ClickRemoveSaveEvent(
                                                                                        eventId: list['identity'],
                                                                                      ),
                                                                                    );
                                                                              }
                                                                            : () async {
                                                                                final getUserClick = await DBHelper().getUser();
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder:
                                                                                        (
                                                                                          _,
                                                                                        ) => LoginPage(
                                                                                          whichScreen: getUserClick!,
                                                                                        ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                        child: Container(
                                                                          padding:
                                                                              EdgeInsets.all(
                                                                                7,
                                                                              ),
                                                                          decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              color: MyColor().borderClr.withOpacity(
                                                                                0.15,
                                                                              ),
                                                                            ),
                                                                            color:
                                                                                MyColor().boxInnerClr,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child: Icon(
                                                                            checkSave
                                                                                ? Icons.bookmark
                                                                                : Icons.bookmark_outline,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                checkSave
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
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                            child: Text(
                                                              formatEventDate(
                                                                calendars:
                                                                    list['calendars'],
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 12,
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
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                            child: Text(
                                                              venue,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 3,
                                                                  horizontal: 8,
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
                                                                fontSize: 12,
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
                                  childCount:
                                      countryCityBasedEventState
                                          .countryBasedEventList
                                          .length +
                                      (countryCityBasedEventState.hasMore
                                          ? 1
                                          : 0),
                                ),
                              );
                            } else if (countryCityBasedEventState
                                is CountryBasedEventFail) {
                              return SliverFillRemaining(
                                hasScrollBody: false,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 250,
                                          child: Image.asset(
                                            ImagePath().errorMessageImg,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "No Results Found",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SliverToBoxAdapter(child: SizedBox());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
}
