import 'dart:io';

import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
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
import 'package:all_college_event_app/utlis/validator/validator.dart';
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
  const SearchModel({super.key});

  @override
  State<SearchModel> createState() => _SearchModelState();
}

class _SearchModelState extends State<SearchModel> {
  Map<String, dynamic> accommodationValues = {};

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

  // perks list
  List<String> perksList = [];

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

        eventTypeIdentity:
            selectEventType != null && selectEventType!.isNotEmpty
            ? selectEventType
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
    return Column(
      children: [
        // ----------- search bar ----------
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
            width: 380,
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
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 16,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            child: Icon(Iconsax.close_circle),
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
                                            children: statusList.map((item) {
                                              final bool isSelected =
                                                  selectEventStatus ==
                                                  item['value'];
                                              return InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  setState(() {
                                                    selectEventStatus =
                                                        item['value'];
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? MyColor().primaryClr
                                                        : MyColor().whiteClr,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? MyColor().primaryClr
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
                                                              FontWeight.w500,
                                                          color: isSelected
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
                                            margin: EdgeInsets.only(top: 16),
                                            child: Text(
                                              "Pricing",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
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
                                            activeColor: MyColor().primaryClr,
                                            inactiveColor: Colors.grey.shade300,
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
                                                MainAxisAlignment.spaceBetween,
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
                                                fontWeight: FontWeight.w600,
                                                color: MyColor().blackClr,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  controller:
                                                      startDateController,
                                                  enableInteractiveSelection:
                                                      false,
                                                  readOnly: true,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColor().primaryClr,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "Start Date",
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .borderClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
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
                                                      borderSide: BorderSide(
                                                        color: MyColor().redClr,
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
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: MyColor()
                                                              .borderClr,
                                                        ),
                                                    prefixIcon: Icon(
                                                      Iconsax.calendar,
                                                      color:
                                                          MyColor().borderClr,
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final result =
                                                        await DateAndTimeController()
                                                            .selectedDate(
                                                              context,
                                                            );
                                                    if (result != null) {
                                                      startDateController.text =
                                                          result;
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  controller: endDateController,
                                                  enableInteractiveSelection:
                                                      false,
                                                  readOnly: true,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColor().primaryClr,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "End Date",
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .borderClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
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
                                                      borderSide: BorderSide(
                                                        color: MyColor().redClr,
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
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: MyColor()
                                                              .borderClr,
                                                        ),
                                                    prefixIcon: Icon(
                                                      Iconsax.calendar,
                                                      color:
                                                          MyColor().borderClr,
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final result =
                                                        await DateAndTimeController()
                                                            .selectedDate(
                                                              context,
                                                            );
                                                    if (result != null) {
                                                      endDateController.text =
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
                                                fontWeight: FontWeight.w600,
                                                color: MyColor().blackClr,
                                              ),
                                            ),
                                          ),
                                          Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: modeList.map((item) {
                                              final bool isSelected =
                                                  selectEventMode ==
                                                  item['value'];
                                              return InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  setState(() {
                                                    selectEventMode =
                                                        item['value'];
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? MyColor().primaryClr
                                                        : MyColor().whiteClr,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? MyColor().primaryClr
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
                                                              FontWeight.w500,
                                                          color: isSelected
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
                                            margin: EdgeInsets.only(top: 20),
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
                                                  return SizedBox(
                                                    width: 320,
                                                    child: MyModels().customDropdown(
                                                      label: "Event Type",
                                                      hint:
                                                          "Select Type of Event",
                                                      value: selectEventType,
                                                      onChanged: (eventType) {
                                                        setState(() {
                                                          selectEventType =
                                                              eventType;
                                                        });

                                                        print(
                                                          'selectEventTypeselectEventTypeselectEventTypeselectEventType$selectEventType',
                                                        );
                                                      },
                                                      items: eventTypeState
                                                          .eventTypeList
                                                          .map(
                                                            (e) =>
                                                                DropdownMenuItem<
                                                                  String
                                                                >(
                                                                  value:
                                                                      e['identity'],
                                                                  child: Text(
                                                                    e['name'],
                                                                  ),
                                                                ),
                                                          )
                                                          .toList(),
                                                      valid: Validators()
                                                          .validOrgCategories,
                                                    ),
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
                                            margin: EdgeInsets.only(top: 20),
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
                                                  return MyModels().customDropdown(
                                                    label: "Perks *",
                                                    hint: "Select Perks Type",
                                                    value: perksValue,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        perksList.add(
                                                          onChanged,
                                                        );
                                                        // perksValue = onChanged;
                                                      });
                                                    },
                                                    items: perksState.perksList
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                String
                                                              >(
                                                                value:
                                                                    e['identity'],
                                                                child: Text(
                                                                  e['perkName'],
                                                                ),
                                                              ),
                                                        )
                                                        .toList(),
                                                    valid:
                                                        Validators().validPerks,
                                                  );
                                                } else if (perksState
                                                    is PerksFail) {
                                                  return Text(
                                                    perksState.errorMessage,
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
                                                fontWeight: FontWeight.w600,
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
                                                    final bool isSelected =
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
                                                              item['certName'],
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
                                                );
                                              } else if (certificationState
                                                  is CertificationFail) {
                                                return RefreshIndicator(
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            certificationState
                                                                .errorMessage,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
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
                                                  builder: (context, accommodationState) {
                                                    if (accommodationState
                                                        is AccommodationLoading) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color: MyColor()
                                                                  .primaryClr,
                                                            ),
                                                      );
                                                    } else if (accommodationState
                                                        is AccommodationSuccess) {
                                                      return MyModels().customDropdown(
                                                        label:
                                                            "Accommodation *",
                                                        hint:
                                                            "Select Accommodation Type",
                                                        value:
                                                            selectAccommodation,
                                                        onChanged: (onChanged) {
                                                          setState(() {
                                                            // accommodationValues
                                                            //     .addAll(
                                                            //       onChanged,
                                                            selectAccommodation =
                                                                onChanged;
                                                            // );
                                                            // accommodationValue = onChanged;
                                                          });
                                                          print(
                                                            "accommodationListaccommodationListaccommodationListaccommodationList$accommodationValues",
                                                          );
                                                        },
                                                        items: accommodationState
                                                            .accommodationList
                                                            .map(
                                                              (e) =>
                                                                  DropdownMenuItem<
                                                                    String
                                                                  >(
                                                                    value:
                                                                        e['identity'],
                                                                    child: Text(
                                                                      e['accommodationName'],
                                                                    ),
                                                                  ),
                                                            )
                                                            .toList(),
                                                        valid: Validators()
                                                            .validPerks,
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
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                    color: MyColor().primaryClr,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                clearAllFilters(setState);
                                              },
                                              child: Text(
                                                "Clear",
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
                                                backgroundColor:
                                                    MyColor().primaryClr,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              onPressed: () {
                                                applyFilter();
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

        // ----- recent search ------
        Visibility(
          visible: isRecent,
          child: Container(
            decoration: BoxDecoration(color: MyColor().whiteClr),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Search",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr,
                        ),
                      ),
                      Text(
                        "Clear All",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColor().borderClr,
                        ),
                      ),
                    ],
                  ),
                ),

                // -------- recent search texts ------
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  height: 100,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Iconsax.clock_copy),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "International Conference",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: MyColor().borderClr,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Iconsax.close_circle_copy),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // -------- event list ------
        Expanded(
          child: BlocBuilder<SearchEventListBloc, SearchEventListState>(
            builder: (context, searchEventListState) {
              if (searchEventListState is SearchEventListLoading) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return eventCardShimmer();
                  },
                );
              } else if (searchEventListState is SearchEventListSuccess) {
                if (isLoadingMore) {
                  isLoadingMore = false;

                  if (searchEventListState.hasMore) {
                    page++;
                  }
                }
                return RefreshIndicator(
                  color: MyColor().primaryClr,
                  onRefresh: () async {
                    fetchEvents();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 0),
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
                          venue = list['location']['venue'];
                        }

                        // -------- identity ---------
                        final identity = list['slug'];
                        final paymentLink = list['paymentLink'];
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
                                          paymentLink: paymentLink,
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
                                      height: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        memCacheHeight: 300,
                                        fadeInDuration: Duration.zero,
                                        imageUrl: featuredImagePath,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: MyColor().primaryClr,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.image_not_supported,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
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
                                                          state.id == eventId) {
                                                        FlutterToast()
                                                            .flutterToast(
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
                                                          list['isLiked'];

                                                      final count =
                                                          bloc.likeCount[eventId] ??
                                                          int.parse(
                                                            list['likeCount']
                                                                .toString(),
                                                          );

                                                      return InkWell(
                                                        customBorder:
                                                            const CircleBorder(),
                                                        onTap: () {
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
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              isLiked
                                                                  ? Icons
                                                                        .favorite
                                                                  : Icons
                                                                        .favorite_border,
                                                              color: isLiked
                                                                  ? MyColor()
                                                                        .redClr
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
                                                          addSaveSate.eventId ==
                                                              list['identity']) {
                                                        FlutterToast()
                                                            .flutterToast(
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
                                                          list['isSaved'];

                                                      return InkWell(
                                                        onTap: () {
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
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                10,
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
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            checkSave
                                                                ? Icons.bookmark
                                                                : Icons
                                                                      .bookmark_outline,
                                                            size: 15,
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
                                                MyColor().primaryBackgroundClr
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
                                                  color: MyColor()
                                                      .primaryBackgroundClr
                                                      .withOpacity(0.35),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (searchEventListState is SearchEventListFail) {
                return RefreshIndicator(
                  onRefresh: () async {
                    fetchEvents();
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
}
