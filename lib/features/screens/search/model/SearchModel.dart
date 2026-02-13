import 'dart:io';
import 'dart:ui';

import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/accommodation/accommodation_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/certification/certification_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/eventType/event_type_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/perks/perks_bloc.dart';
import 'package:all_college_event_app/features/screens/search/bloc/searchEventListBloc/search_event_list_bloc.dart';
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
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class SearchModel extends StatefulWidget {
  final bool isLogin;

  const SearchModel({super.key, required this.isLogin});

  @override
  State<SearchModel> createState() => _SearchModelState();
}

class _SearchModelState extends State<SearchModel> {
  Map<String, dynamic> accommodationValues = {};

  // event type multiple select
  List<Map<String, dynamic>> selectEventTypeList = [];
  List<Map<String, dynamic>> filterEventTypeList = [];
  List<Map<String, dynamic>> eventTypeList = [];

  // perks type multiple select
  List<Map<String, dynamic>> selectPerksList = [];
  List<Map<String, dynamic>> filterPerksList = [];
  List<Map<String, dynamic>> perksList = [];

  // accommodation type multiple select
  List<Map<String, dynamic>> selectAccommodationList = [];
  List<Map<String, dynamic>> filterAccommodationList = [];
  List<Map<String, dynamic>> accommodationList = [];

  // ----------- Status --------
  List<Map<String, dynamic>> statusList = [
    {'title': 'Trending', 'value': 'trending'},
    {'title': 'Featured', 'value': 'featured'},
  ];

  // -------- Mode list ----------
  List<Map<String, dynamic>> modeList = [
    {'title': 'Offline', "value": "OFFLINE"},
    {'title': 'Online', "value": "ONLINE"},
    {'title': 'Hybrid', "value": "HYBRID"},
  ];

  // price
  double minPrice = 0;
  double maxPrice = 10000;

  double priceMinLimit = 0;
  double priceMaxLimit = 10000;

  String? selectEventStatus;
  String? selectEventMode;
  String? selectEventType;
  String? perksValue;
  String? selectAccommodation;
  String? selectCertification;

  // country, state and city
  String? selectCountry;
  String? selectState;
  String? selectCity;

  // pagination
  int page = 1;
  final limit = 10;
  bool isLoadingMore = false;
  final scrollController = ScrollController();

  // -------- controller --------
  final searchController = TextEditingController();

  // ---------- recent search active inactive ----------
  bool isRecent = false;

  // -------- controller ---------
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore) {
        fetchEvents(loadMore: true);
      }
    });
    fetchEvents();
  }

  // initial fetch a data
  void fetchEvents({bool loadMore = false}) {
    if (loadMore && isLoadingMore) return;

    if (!loadMore) {
      page = 1;
    }
    isLoadingMore = loadMore;

    final DateTime? startDate = startDateController.text.isNotEmpty
        ? DateTime.parse(startDateController.text)
        : null;

    final DateTime? endDate = endDateController.text.isNotEmpty
        ? DateTime.parse(endDateController.text)
        : null;

    context.read<SearchEventListBloc>().add(
      FetchSearchEventList(
        isLoadMore: loadMore,
        page: page,
        limit: limit,

        eventTypes: selectEventStatus != null && selectEventStatus!.isNotEmpty
            ? [selectEventStatus!]
            : null,

        modes: selectEventMode != null && selectEventMode!.isNotEmpty
            ? [selectEventMode!]
            : null,

        eventTypeIdentity: selectEventTypeList.isNotEmpty
            ? selectEventTypeList.map((e) => e['identity'].toString()).toList()
            : null,

        certIdentity:
            selectAccommodation != null && selectAccommodation!.isNotEmpty
            ? selectAccommodation
            : null,

        perkIdentities: perksValue != null && perksValue!.isNotEmpty
            ? [perksValue!]
            : null,

        accommodationIdentities:
            selectAccommodation != null && selectAccommodation!.isNotEmpty
            ? [selectAccommodation!]
            : null,

        eligibleDeptIdentities: null,

        startDate: startDate,
        endDate: endDate,

        minPrice: minPrice.toInt(),
        maxPrice: maxPrice.toInt(),

        country: selectCountry != null && selectCountry!.isNotEmpty
            ? selectCountry
            : null,

        state: selectState != null && selectState!.isNotEmpty
            ? selectState
            : null,

        city: selectCity != null && selectCity!.isNotEmpty ? selectCity : null,

        searchText: searchController.text.isNotEmpty
            ? searchController.text
            : null,
        isLogin: widget.isLogin,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          edgeOffset: 80,
          backgroundColor: MyColor().whiteClr,
          color: MyColor().primaryClr,
          onRefresh: () async {
            fetchEvents();
          },
          child: ListView(
            children: [
              Expanded(
                child: BlocBuilder<SearchEventListBloc, SearchEventListState>(
                  builder: (context, searchEventListState) {
                    if (searchEventListState is SearchEventListLoading) {
                      return Container(
                        margin: EdgeInsets.only(top: 80),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return eventCardShimmer();
                          },
                        ),
                      );
                    } else if (searchEventListState is SearchEventListSuccess) {
                      if (isLoadingMore) {
                        isLoadingMore = false;

                        if (searchEventListState.hasMore) {
                          page++;
                        }
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 80),
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount:
                              searchEventListState.searchEventList.length +
                              (searchEventListState.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index ==
                                searchEventListState.searchEventList.length) {
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

                            final list =
                                searchEventListState.searchEventList[index];

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
                              venue = list['location']['venue'];
                            }

                            // -------- identity ---------
                            final identity = list['slug'];
                            final paymentLink = list['paymentLink'] ?? "";

                            print(
                              "paymentLinkpaymentLinkpaymentLinkpaymentLink$paymentLink",
                            );
                            // event identity
                            final eventId = list['identity'].toString();

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
                                  if (!isRecent) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            EventDetailPage(
                                              slug: identity,
                                              title: title,
                                              whichScreen: 'view',
                                              paymentLink: paymentLink ?? "",
                                              isLogin: widget.isLogin,
                                            ),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                              return SlideTransition(
                                                position: Tween(
                                                  begin: const Offset(1, 0),
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
                                  margin: EdgeInsets.only(left: 0, bottom: 16),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: MyColor().whiteClr,
                                    border: Border.all(
                                      color: MyColor().borderClr.withOpacity(
                                        0.15,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
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
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: CachedNetworkImage(
                                              // memCacheHeight: 300,
                                              fadeInDuration: Duration.zero,
                                              imageUrl: featuredImagePath,
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
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => const Icon(
                                                    Icons.image_not_supported,
                                                  ),
                                            ),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                          final bloc = context
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
                                                                widget.isLogin
                                                                ? () {
                                                                    context
                                                                        .read<
                                                                          EventLikeBloc
                                                                        >()
                                                                        .add(
                                                                          ClickEventLike(
                                                                            eventId:
                                                                                eventId,
                                                                            initialFav:
                                                                                list['isLiked'],
                                                                            initialCount: int.parse(
                                                                              list['likeCount'].toString(),
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
                                                                        builder: (_) => LoginPage(
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
                                                                      ? Iconsax
                                                                            .heart
                                                                      : Iconsax
                                                                            .heart_copy,
                                                                  color: isLiked
                                                                      ? MyColor()
                                                                            .redClr
                                                                      : null,
                                                                  size: 25,
                                                                ),
                                                                if (count != 0)
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                if (count != 0)
                                                                  Text(
                                                                    count
                                                                        .toString(),
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          12,
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
                                                      SizedBox(width: 5),
                                                      BlocConsumer<
                                                        RemoveSaveEventBloc,
                                                        RemoveSaveEventState
                                                      >(
                                                        listener: (context, addSaveSate) {
                                                          if (addSaveSate
                                                                  is RemoveSaveEventFail &&
                                                              addSaveSate
                                                                      .eventId ==
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
                                                              addSaveSate
                                                                      .eventId ==
                                                                  list['identity']) {
                                                            list['isSaved'] =
                                                                addSaveSate
                                                                    .checkSave;
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
                                                            onTap:
                                                                widget.isLogin
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
                                                                        builder: (_) => LoginPage(
                                                                          whichScreen:
                                                                              getUserClick!,
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
                                                                  color: MyColor()
                                                                      .borderClr
                                                                      .withOpacity(
                                                                        0.15,
                                                                      ),
                                                                ),
                                                                color: MyColor()
                                                                    .boxInnerClr,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                checkSave
                                                                    ? Icons
                                                                          .bookmark
                                                                    : Icons
                                                                          .bookmark_outline,
                                                                size: 20,
                                                                color: checkSave
                                                                    ? MyColor()
                                                                          .primaryClr
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
                                                        .withOpacity(0.35),
                                                  ),
                                                  chip(
                                                    "Entertainment",
                                                    MyColor().blueBackgroundClr
                                                        .withOpacity(0.35),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
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
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      venue,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                                          .withOpacity(0.35),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      "Ongoing",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                      );
                    } else if (searchEventListState is SearchEventListFail) {
                      return RefreshIndicator(
                        backgroundColor: MyColor().whiteClr,
                        color: MyColor().primaryClr,
                        onRefresh: () async {
                          fetchEvents();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
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
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        // ----------- search bar ----------
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.white.withOpacity(0.07), // IMPORTANT
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  // width: 360,
                  child: TextFormField(
                    focusNode: GlobalUnFocus.focusNode,
                    controller: searchController,
                    onChanged: (onChanged) {
                      fetchEvents();
                    },
                    onTapOutside: (onOutSideClick) {
                      GlobalUnFocus.unFocus();

                      // setState(() {
                      //   isRecent = false;
                      // });
                    },
                    // onTap: () {
                    //   setState(() {
                    //     isRecent = true;
                    //   });
                    // },
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: MyColor().borderClr,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: MyColor().primaryClr,
                          width: 0.5,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            backgroundColor: MyColor().whiteClr,
                            context: context,
                            builder: (_) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: context.read<EventTypeBloc>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<PerksBloc>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<AccommodationBloc>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<CertificationBloc>(),
                                  ),
                                ],
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 16,
                                              bottom: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Filter",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: MyColor().blackClr,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(
                                                    Iconsax.close_circle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Expanded(
                                            child: ListView(
                                              children: [
                                                // event status
                                                Wrap(
                                                  spacing: 12,
                                                  runSpacing: 12,
                                                  children: statusList.map((
                                                    item,
                                                  ) {
                                                    final bool isSelected =
                                                        selectEventStatus ==
                                                        item['value'];
                                                    return InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      onTap: () {
                                                        setState(() {
                                                          selectEventStatus =
                                                              item['value'];
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 250,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 10,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: isSelected
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : MyColor()
                                                                    .whiteClr,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? MyColor()
                                                                      .primaryClr
                                                                : Colors
                                                                      .grey
                                                                      .shade300,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              item['title'],
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    isSelected
                                                                    ? MyColor()
                                                                          .whiteClr
                                                                    : MyColor()
                                                                          .blackClr,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),

                                                // price
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 16,
                                                  ),
                                                  child: Text(
                                                    "Pricing",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MyColor().blackClr,
                                                    ),
                                                  ),
                                                ),
                                                RangeSlider(
                                                  values: RangeValues(
                                                    minPrice,
                                                    maxPrice,
                                                  ),
                                                  min: priceMinLimit,
                                                  max: priceMaxLimit,
                                                  divisions: 100,
                                                  activeColor:
                                                      MyColor().primaryClr,
                                                  inactiveColor:
                                                      Colors.grey.shade300,
                                                  onChanged: (RangeValues values) {
                                                    setState(() {
                                                      minPrice = priceMinLimit;
                                                      maxPrice = values.end;
                                                    });

                                                    print(
                                                      'minPriceminPriceminPriceminPrice$minPrice to $maxPrice',
                                                    );
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    priceChip(minPrice),
                                                    priceChip(maxPrice),
                                                  ],
                                                ),

                                                // date & time
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 16,
                                                    bottom: 10,
                                                  ),
                                                  child: Text(
                                                    "Select Event Dates",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MyColor().blackClr,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: TextField(
                                                        controller:
                                                            startDateController,
                                                        enableInteractiveSelection:
                                                            false,
                                                        readOnly: true,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: MyColor()
                                                                  .primaryClr,
                                                            ),
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Start Date",
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide: BorderSide(
                                                              color: MyColor()
                                                                  .borderClr,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide: BorderSide(
                                                              color: MyColor()
                                                                  .primaryClr,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide:
                                                                BorderSide(
                                                                  color: MyColor()
                                                                      .redClr,
                                                                  width: 0.5,
                                                                ),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color: MyColor()
                                                                          .redClr,
                                                                      width:
                                                                          0.5,
                                                                    ),
                                                              ),
                                                          hintStyle:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: MyColor()
                                                                    .borderClr,
                                                              ),
                                                          prefixIcon: Icon(
                                                            Iconsax.calendar,
                                                            color: MyColor()
                                                                .borderClr,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          final result =
                                                              await DateAndTimeController()
                                                                  .selectedDate(
                                                                    context,
                                                                  );
                                                          if (result != null) {
                                                            startDateController
                                                                    .text =
                                                                result;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      flex: 1,
                                                      child: TextField(
                                                        controller:
                                                            endDateController,
                                                        enableInteractiveSelection:
                                                            false,
                                                        readOnly: true,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: MyColor()
                                                                  .primaryClr,
                                                            ),
                                                        decoration: InputDecoration(
                                                          hintText: "End Date",
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide: BorderSide(
                                                              color: MyColor()
                                                                  .borderClr,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide: BorderSide(
                                                              color: MyColor()
                                                                  .primaryClr,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide:
                                                                BorderSide(
                                                                  color: MyColor()
                                                                      .redClr,
                                                                  width: 0.5,
                                                                ),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color: MyColor()
                                                                          .redClr,
                                                                      width:
                                                                          0.5,
                                                                    ),
                                                              ),
                                                          hintStyle:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: MyColor()
                                                                    .borderClr,
                                                              ),
                                                          prefixIcon: Icon(
                                                            Iconsax.calendar,
                                                            color: MyColor()
                                                                .borderClr,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          final result =
                                                              await DateAndTimeController()
                                                                  .selectedDate(
                                                                    context,
                                                                  );
                                                          if (result != null) {
                                                            endDateController
                                                                    .text =
                                                                result;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // event mode
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 16,
                                                    bottom: 10,
                                                  ),
                                                  child: Text(
                                                    "Event Mode",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MyColor().blackClr,
                                                    ),
                                                  ),
                                                ),
                                                Wrap(
                                                  spacing: 12,
                                                  runSpacing: 12,
                                                  children: modeList.map((
                                                    item,
                                                  ) {
                                                    final bool isSelected =
                                                        selectEventMode ==
                                                        item['value'];
                                                    return InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      onTap: () {
                                                        setState(() {
                                                          selectEventMode =
                                                              item['value'];
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 250,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 10,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: isSelected
                                                              ? MyColor()
                                                                    .primaryClr
                                                              : MyColor()
                                                                    .whiteClr,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? MyColor()
                                                                      .primaryClr
                                                                : Colors
                                                                      .grey
                                                                      .shade300,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              item['title'],
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    isSelected
                                                                    ? MyColor()
                                                                          .whiteClr
                                                                    : MyColor()
                                                                          .blackClr,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),

                                                // event type
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                    top: 20,
                                                  ),
                                                  child: BlocBuilder<EventTypeBloc, EventTypeState>(
                                                    builder: (context, eventTypeState) {
                                                      if (eventTypeState
                                                          is EventTypeLoading) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: MyColor()
                                                                    .primaryClr,
                                                              ),
                                                        );
                                                      } else if (eventTypeState
                                                          is EventTypeSuccess) {
                                                        eventTypeList =
                                                            List<
                                                              Map<
                                                                String,
                                                                dynamic
                                                              >
                                                            >.from(
                                                              eventTypeState
                                                                  .eventTypeList,
                                                            );
                                                        filterEventTypeList =
                                                            eventTypeList;

                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    top: 16,
                                                                    bottom: 10,
                                                                  ),
                                                              child: Text(
                                                                "Event Type",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: MyColor()
                                                                      .blackClr,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                final result =
                                                                    await openEventTypeMultiSelect();

                                                                if (result !=
                                                                    null) {
                                                                  setState(() {
                                                                    selectEventTypeList =
                                                                        result;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          14,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: MyColor()
                                                                        .borderClr,
                                                                    width: 0.5,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        12,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        selectEventTypeList.isEmpty
                                                                            ? "Select event type"
                                                                            : selectEventTypeList
                                                                                  .map(
                                                                                    (
                                                                                      e,
                                                                                    ) => e['name'],
                                                                                  )
                                                                                  .join(", "),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Wrap(
                                                              spacing: 8,
                                                              children: selectEventTypeList.map((
                                                                e,
                                                              ) {
                                                                return Chip(
                                                                  label: Text(
                                                                    e['name'],
                                                                  ),
                                                                  onDeleted: () {
                                                                    setState(() {
                                                                      selectEventTypeList
                                                                          .remove(
                                                                            e,
                                                                          );
                                                                    });
                                                                  },
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ],
                                                        );
                                                      } else if (eventTypeState
                                                          is EventTypeFail) {
                                                        return Center(
                                                          child: Text(
                                                            eventTypeState
                                                                .errorMessage,
                                                          ),
                                                        );
                                                      }
                                                      return SizedBox.shrink();
                                                    },
                                                  ),
                                                ),

                                                // perks
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                    top: 0,
                                                  ),
                                                  child: BlocBuilder<PerksBloc, PerksState>(
                                                    builder: (context, perksState) {
                                                      if (perksState
                                                          is PerksLoading) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: MyColor()
                                                                    .primaryClr,
                                                              ),
                                                        );
                                                      } else if (perksState
                                                          is PerksSuccess) {
                                                        perksList =
                                                            List<
                                                              Map<
                                                                String,
                                                                dynamic
                                                              >
                                                            >.from(
                                                              perksState
                                                                  .perksList,
                                                            );
                                                        filterPerksList =
                                                            perksList;
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    top: 16,
                                                                    bottom: 10,
                                                                  ),
                                                              child: Text(
                                                                "Perks",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: MyColor()
                                                                      .blackClr,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                final result =
                                                                    await openPerksMultiSelect();

                                                                if (result !=
                                                                    null) {
                                                                  setState(() {
                                                                    selectPerksList =
                                                                        result;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          14,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: MyColor()
                                                                        .borderClr,
                                                                    width: 0.5,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        12,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        selectEventTypeList.isEmpty
                                                                            ? "Select perks"
                                                                            : selectEventTypeList
                                                                                  .map(
                                                                                    (
                                                                                      e,
                                                                                    ) => e['name'],
                                                                                  )
                                                                                  .join(", "),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Wrap(
                                                              spacing: 8,
                                                              children: selectPerksList.map((
                                                                e,
                                                              ) {
                                                                return Chip(
                                                                  label: Text(
                                                                    e['perkName'],
                                                                  ),
                                                                  onDeleted: () {
                                                                    setState(() {
                                                                      selectPerksList
                                                                          .remove(
                                                                            e,
                                                                          );
                                                                    });
                                                                  },
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ],
                                                        );
                                                      } else if (perksState
                                                          is PerksFail) {
                                                        return Text(
                                                          perksState
                                                              .errorMessage,
                                                        );
                                                      }
                                                      return SizedBox.shrink();
                                                    },
                                                  ),
                                                ),

                                                // Certification
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 16,
                                                    bottom: 10,
                                                  ),
                                                  child: Text(
                                                    "Certification",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MyColor().blackClr,
                                                    ),
                                                  ),
                                                ),
                                                BlocBuilder<
                                                  CertificationBloc,
                                                  CertificationState
                                                >(
                                                  builder: (context, certificationState) {
                                                    if (certificationState
                                                        is CertificationLoading) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color: MyColor()
                                                                  .primaryClr,
                                                            ),
                                                      );
                                                    } else if (certificationState
                                                        is CertificationSuccess) {
                                                      return Wrap(
                                                        spacing: 12,
                                                        runSpacing: 12,
                                                        children: certificationState.certificationList.map((
                                                          item,
                                                        ) {
                                                          final bool
                                                          isSelected =
                                                              selectCertification ==
                                                              item['identity'];

                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                selectCertification =
                                                                    item['identity'];
                                                              });
                                                            },
                                                            child: AnimatedContainer(
                                                              duration: Duration(
                                                                milliseconds:
                                                                    250,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    isSelected
                                                                    ? MyColor()
                                                                          .primaryClr
                                                                    : MyColor()
                                                                          .whiteClr,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                                border: Border.all(
                                                                  color:
                                                                      isSelected
                                                                      ? MyColor()
                                                                            .primaryClr
                                                                      : Colors
                                                                            .grey
                                                                            .shade300,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    item['certName'],
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          isSelected
                                                                          ? MyColor().whiteClr
                                                                          : MyColor().blackClr,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      );
                                                    } else if (certificationState
                                                        is CertificationFail) {
                                                      return RefreshIndicator(
                                                        backgroundColor:
                                                            MyColor().whiteClr,
                                                        color: MyColor()
                                                            .primaryClr,
                                                        onRefresh: () async {
                                                          context
                                                              .read<
                                                                CertificationBloc
                                                              >()
                                                              .add(
                                                                (FetchCertification()),
                                                              );
                                                        },
                                                        child: Center(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              Center(
                                                                child: SizedBox(
                                                                  height: 100,
                                                                  child: Image.asset(
                                                                    ImagePath()
                                                                        .errorMessageImg,
                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  certificationState
                                                                      .errorMessage,
                                                                  style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        18,
                                                                    color: MyColor()
                                                                        .blackClr,
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

                                                // accommodation
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 20,
                                                  ),
                                                  child:
                                                      BlocBuilder<
                                                        AccommodationBloc,
                                                        AccommodationState
                                                      >(
                                                        builder:
                                                            (
                                                              context,
                                                              accommodationState,
                                                            ) {
                                                              if (accommodationState
                                                                  is AccommodationLoading) {
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: MyColor()
                                                                        .primaryClr,
                                                                  ),
                                                                );
                                                              } else if (accommodationState
                                                                  is AccommodationSuccess) {
                                                                accommodationList =
                                                                    List<
                                                                      Map<
                                                                        String,
                                                                        dynamic
                                                                      >
                                                                    >.from(
                                                                      accommodationState
                                                                          .accommodationList,
                                                                    );
                                                                filterPerksList =
                                                                    perksList;
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                        top: 16,
                                                                        bottom:
                                                                            10,
                                                                      ),
                                                                      child: Text(
                                                                        "Accommodation",
                                                                        style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              MyColor().blackClr,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        final result =
                                                                            await openAccommodationMultiSelect();

                                                                        if (result !=
                                                                            null) {
                                                                          setState(
                                                                            () {
                                                                              selectAccommodationList = result;
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              12,
                                                                          vertical:
                                                                              14,
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color:
                                                                                MyColor().borderClr,
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                        ),
                                                                        child: Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                selectAccommodationList.isEmpty
                                                                                    ? "Select accommodation"
                                                                                    : selectAccommodationList
                                                                                          .map(
                                                                                            (
                                                                                              e,
                                                                                            ) => e['accommodationName'],
                                                                                          )
                                                                                          .join(
                                                                                            ", ",
                                                                                          ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              Icons.arrow_drop_down,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          8,
                                                                      children: selectAccommodationList.map((
                                                                        e,
                                                                      ) {
                                                                        return Chip(
                                                                          label: Text(
                                                                            e['accommodationName'],
                                                                          ),
                                                                          onDeleted: () {
                                                                            setState(() {
                                                                              selectAccommodationList.remove(
                                                                                e,
                                                                              );
                                                                            });
                                                                          },
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else if (accommodationState
                                                                  is AccommodationFail) {
                                                                return Text(
                                                                  accommodationState
                                                                      .errorMessage,
                                                                );
                                                              }
                                                              return SizedBox.shrink();
                                                            },
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // apply & clear button
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 16,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(0, 40),
                                                      backgroundColor:
                                                          MyColor().whiteClr,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                        side: BorderSide(
                                                          color: MyColor()
                                                              .primaryClr,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      clearAllFilters(setState);
                                                    },
                                                    child: Text(
                                                      "Clear",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: MyColor()
                                                                .primaryClr,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  flex: 1,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(0, 40),
                                                      backgroundColor:
                                                          MyColor().primaryClr,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      applyFilter();
                                                    },
                                                    child: Text(
                                                      "Apply",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: MyColor()
                                                                .whiteClr,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.tune),
                        ),
                      ),
                      prefixIcon: Icon(Icons.search, size: 24),
                      hintText: "Search Events",
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
        ),
      ],
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

  // clear function for after apply the values
  void clearAllFilters(StateSetter setState) {
    setState(() {
      // event status
      selectEventStatus = null;

      // pricing
      minPrice = priceMinLimit;
      maxPrice = priceMaxLimit;

      // dates
      startDateController.clear();
      endDateController.clear();

      // event mode
      selectEventMode = null;

      // event type
      selectEventType = null;

      // perks
      perksValue = null;
      perksList.clear();

      // accommodation
      selectAccommodation = null;
      accommodationValues.clear();
    });
    fetchEvents();
    Navigator.pop(context);
  }

  // apply the filter
  void applyFilter() {
    fetchEvents();
    Navigator.pop(context);
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

  // price widget
  Widget priceChip(double value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        "₹${value.toInt()}",
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  // multiple dropdown event type
  Future<List<Map<String, dynamic>>?> openEventTypeMultiSelect() async {
    filterEventTypeList = List.from(eventTypeList);

    return await showModalBottomSheet<List<Map<String, dynamic>>>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        List<Map<String, dynamic>> tempSelected = List.from(
          selectEventTypeList,
        );
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search text field
                  TextFormField(
                    onChanged: (value) {
                      setModalState(() {
                        filterEventTypeList = eventTypeList
                            .where(
                              (e) => e['name'].toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search event type",
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().borderClr,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().primaryClr,
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // List
                  Flexible(
                    child: ListView.builder(
                      itemCount: filterEventTypeList.length,
                      itemBuilder: (_, index) {
                        final item = filterEventTypeList[index];
                        final isSelected = tempSelected.any(
                          (e) => e['identity'] == item['identity'],
                        );

                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(item['name']),
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                if (!tempSelected.any(
                                  (e) => e['identity'] == item['identity'],
                                )) {
                                  tempSelected.add(item);
                                }
                              } else {
                                tempSelected.removeWhere(
                                  (e) => e['identity'] == item['identity'],
                                );
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, tempSelected);
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // multiple dropdown perks
  Future<List<Map<String, dynamic>>?> openPerksMultiSelect() async {
    filterPerksList = List.from(perksList);

    return await showModalBottomSheet<List<Map<String, dynamic>>>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        List<Map<String, dynamic>> tempSelected = List.from(selectPerksList);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search text field
                  TextFormField(
                    onChanged: (value) {
                      setModalState(() {
                        filterEventTypeList = perksList
                            .where(
                              (e) => e['perkName'].toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search perks",
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().borderClr,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().primaryClr,
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // List perks
                  Flexible(
                    child: ListView.builder(
                      itemCount: filterPerksList.length,
                      itemBuilder: (_, index) {
                        final item = filterPerksList[index];
                        final isSelected = tempSelected.any(
                          (e) => e['identity'] == item['identity'],
                        );

                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(item['perkName']),
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                if (!tempSelected.any(
                                  (e) => e['identity'] == item['identity'],
                                )) {
                                  tempSelected.add(item);
                                }
                              } else {
                                tempSelected.removeWhere(
                                  (e) => e['identity'] == item['identity'],
                                );
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, tempSelected);
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // multiple dropdown accommodation
  Future<List<Map<String, dynamic>>?> openAccommodationMultiSelect() async {
    filterAccommodationList = List.from(accommodationList);

    return await showModalBottomSheet<List<Map<String, dynamic>>>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        List<Map<String, dynamic>> tempSelected = List.from(
          selectAccommodationList,
        );
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search text field
                  TextFormField(
                    onChanged: (value) {
                      setModalState(() {
                        filterAccommodationList = accommodationList
                            .where(
                              (e) => e['accommodationName']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                            )
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search perks",
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().borderClr,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().primaryClr,
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColor().redClr,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // List perks
                  Flexible(
                    child: ListView.builder(
                      itemCount: filterAccommodationList.length,
                      itemBuilder: (_, index) {
                        final item = filterAccommodationList[index];
                        final isSelected = tempSelected.any(
                          (e) => e['identity'] == item['identity'],
                        );

                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(item['accommodationName']),
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                if (!tempSelected.any(
                                  (e) => e['identity'] == item['identity'],
                                )) {
                                  tempSelected.add(item);
                                }
                              } else {
                                tempSelected.removeWhere(
                                  (e) => e['identity'] == item['identity'],
                                );
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // apply & cancel button
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(0, 40),
                              backgroundColor: MyColor().whiteClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: MyColor().primaryClr),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColor().primaryClr,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(0, 40),
                              backgroundColor: MyColor().primaryClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, tempSelected);
                            },
                            child: Text(
                              "Apply",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColor().whiteClr,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
