import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/global/ui/filter/FilterPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/globalUnFocus/GlobalUnFocus.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class EventListModel extends StatefulWidget {
  const EventListModel({super.key});

  @override
  State<EventListModel> createState() => _EventListModelState();
}

class _EventListModelState extends State<EventListModel> {
  // -------- controller --------
  final searchController = TextEditingController();

  // -------- store filter values ----------
  Map<String, dynamic> filterPageValues = {};

  // ----------- remove function ui & api --------
  void removeFiler(int index, String text) {
    setState(() {
      filterPageValues['display'].removeAt(index);

      filterPageValues['api'].forEach((key, value) {
        if (value is List) {
          value.remove(text);
          if (value.isEmpty) {
            filterPageValues['api'].remove(key);
          }
        } else {
          if (value == text) {
            filterPageValues['api'].remove(key);
          }
        }
      });
    });

    context.read<EventListBloc>().add(
      FetchEventList(
        eventTypes: filterPageValues['api']['eventTypes'],
        modes: filterPageValues['api']['modes'],
        eligibleDeptIdentities:
            filterPageValues['api']['eligibleDeptIdentities'],
        certIdentity: filterPageValues['api']['certIdentity'],
        eventTypeIdentity: filterPageValues['api']['eventTypeIdentity'],
        perkIdentities: filterPageValues['api']['perkIdentities'],
        accommodationIdentities:
            filterPageValues['api']['accommodationIdentities'],
        country: filterPageValues['api']['country'],
        state: filterPageValues['api']['state'],
        city: filterPageValues['api']['city'],
        startDate: filterPageValues['api']['dateRange'],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
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
              onTapOutside: (onChanged) {
                GlobalUnFocus.unFocus();
              },
              onChanged: (onChanged) {
                if (searchController.text.isNotEmpty) {
                  context.read<EventListBloc>().add(
                    SearchEventList(searchText: searchController.text),
                  );
                } else {
                  context.read<EventListBloc>().add(
                    FetchEventList(
                      eventTypes: [],
                      modes: [],
                      // searchText: '',
                      eligibleDeptIdentities: [],
                      certIdentity: '',
                      eventTypeIdentity: '',
                      perkIdentities: [],
                      accommodationIdentities: [],
                      country: '',
                      state: '',
                      city: '',
                      startDate: null,
                    ),
                  );
                }
                print(
                  "searchControllersearchControllersearchControllersearchController${searchController.text}",
                );
              },
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
                prefixIcon: Icon(Icons.search, size: 24),
                hintText: "Search Events",
                hintStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: MyColor().hintTextClr,
                ),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => FilterPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          return SlideTransition(
                            position: Tween(
                              begin: Offset(-1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );

                    if (result != null) {
                      final Map<String, dynamic> apiMap = {};
                      final List<String> displayList = [];

                      for (final item in result) {
                        // ---- API values ----
                        switch (item.type) {
                          case "eventTypes":
                            apiMap['eventTypes'] = item.keys;
                            break;

                          case "modes":
                            apiMap['modes'] = item.keys;
                            break;

                          case "eligibleDeptIdentities":
                            apiMap['eligibleDeptIdentities'] = item.keys;
                            break;

                          case "certIdentity":
                            apiMap['certIdentity'] = item.keys.first;
                            break;

                          case "eventTypeIdentity":
                            apiMap['eventTypeIdentity'] = item.keys.first;
                            break;

                          case "perkIdentities":
                            apiMap['perkIdentities'] = item.keys;
                            break;

                          case "accommodationIdentities":
                            apiMap['accommodationIdentities'] = item.keys;
                            break;

                          case "country":
                            apiMap['country'] = item.keys.first;
                            break;

                          case "state":
                            apiMap['state'] = item.keys.first;
                            break;

                          case "city":
                            apiMap['city'] = item.keys.first;
                            break;

                          case "dateRange":
                            apiMap['dateRange'] = item.keys.first;
                            break;
                        }

                        // ---- Display values (chips) ----
                        displayList.addAll(item.values);
                      }

                      setState(() {
                        filterPageValues['api'] = apiMap;
                        filterPageValues['display'] = displayList;
                      });

                      // ---- Fetch using stored filters ----
                      context.read<EventListBloc>().add(
                        FetchEventList(
                          eventTypes: apiMap['eventTypes'],
                          modes: apiMap['modes'],
                          eligibleDeptIdentities:
                              apiMap['eligibleDeptIdentities'],
                          certIdentity: apiMap['certIdentity'],
                          eventTypeIdentity: apiMap['eventTypeIdentity'],
                          perkIdentities: apiMap['perkIdentities'],
                          accommodationIdentities:
                              apiMap['accommodationIdentities'],
                          country: apiMap['country'],
                          state: apiMap['state'],
                          city: apiMap['city'],
                          startDate: apiMap['dateRange'],
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // color: MyColor().boxInnerClr,
                      // border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.tune),
                  ),
                ),
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 16, right: 0),
          child: Row(
            children: [
              // GestureDetector(
              //   onTap: () async{
              //     final result = await Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=> FilterPage(),
              //         transitionsBuilder: (_, animation, __, child){
              //           return SlideTransition(position: Tween(
              //               begin: Offset(-1, 0),
              //               end: Offset.zero
              //           ).animate(animation),child: child,);
              //         }
              //     ));
              //
              //     if (result != null) {
              //
              //       final Map<String, dynamic> apiMap = {};
              //       final List<String> displayList = [];
              //
              //       for (final item in result) {
              //
              //         // ---- API values ----
              //         switch (item.type) {
              //
              //           case "eventTypes":
              //             apiMap['eventTypes'] = item.keys;
              //             break;
              //
              //           case "modes":
              //             apiMap['modes'] = item.keys;
              //             break;
              //
              //           case "eligibleDeptIdentities":
              //             apiMap['eligibleDeptIdentities'] = item.keys;
              //             break;
              //
              //           case "certIdentity":
              //             apiMap['certIdentity'] = item.keys.first;
              //             break;
              //
              //           case "eventTypeIdentity":
              //             apiMap['eventTypeIdentity'] = item.keys.first;
              //             break;
              //
              //           case "perkIdentities":
              //             apiMap['perkIdentities'] = item.keys;
              //             break;
              //
              //           case "accommodationIdentities":
              //             apiMap['accommodationIdentities'] = item.keys;
              //             break;
              //
              //           case "country":
              //             apiMap['country'] = item.keys.first;
              //             break;
              //
              //           case "state":
              //             apiMap['state'] = item.keys.first;
              //             break;
              //
              //           case "city":
              //             apiMap['city'] = item.keys.first;
              //             break;
              //
              //           case "dateRange":
              //             apiMap['dateRange'] = item.keys.first;
              //             break;
              //         }
              //
              //         // ---- Display values (chips) ----
              //         displayList.addAll(item.values);
              //       }
              //
              //       setState(() {
              //         filterPageValues['api'] = apiMap;
              //         filterPageValues['display'] = displayList;
              //       });
              //
              //       // ---- Fetch using stored filters ----
              //       context.read<EventListBloc>().add(
              //         FetchEventList(
              //           eventTypes: apiMap['eventTypes'],
              //           modes: apiMap['modes'],
              //           eligibleDeptIdentities: apiMap['eligibleDeptIdentities'],
              //           certIdentity: apiMap['certIdentity'],
              //           eventTypeIdentity: apiMap['eventTypeIdentity'],
              //           perkIdentities: apiMap['perkIdentities'],
              //           accommodationIdentities: apiMap['accommodationIdentities'],
              //           country: apiMap['country'],
              //           state: apiMap['state'],
              //           city: apiMap['city'],
              //           startDate: apiMap['dateRange'],
              //         ),
              //       );
              //     }
              //
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //         color: MyColor().boxInnerClr,
              //         border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
              //         borderRadius: BorderRadius.circular(100)
              //     ),
              //     child: Icon(
              //       Icons.tune,
              //     ),
              //   ),
              // ),
              // SizedBox(width: 10,),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (filterPageValues['display'] ?? []).length,
                      (index) {
                        final e = filterPageValues['display'][index];
                        return filterChip(e, index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: BlocBuilder<EventListBloc, EventListState>(
            builder: (context, eventListState) {
              if (eventListState is EventListLoading) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return eventCardShimmer();
                  },
                );
              } else if (eventListState is EventSuccess) {
                return RefreshIndicator(
                  color: MyColor().primaryClr,
                  onRefresh: () async {
                    context.read<EventListBloc>().add(
                      filterPageValues != null && filterPageValues.isNotEmpty
                          ? FetchEventList(
                              eventTypes:
                                  filterPageValues['api']['eventTypes'] ?? "",
                              modes: filterPageValues['api']['modes'] ?? '',
                              eligibleDeptIdentities:
                                  filterPageValues['api']['eligibleDeptIdentities'] ??
                                  '',
                              certIdentity:
                                  filterPageValues['api']['certIdentity'] ?? '',
                              eventTypeIdentity:
                                  filterPageValues['api']['eventTypeIdentity'] ??
                                  '',
                              perkIdentities:
                                  filterPageValues['api']['perkIdentities'] ??
                                  '',
                              accommodationIdentities:
                                  filterPageValues['api']['accommodationIdentities'] ??
                                  "",
                              country: filterPageValues['api']['country'] ?? '',
                              state: filterPageValues['api']['state'] ?? '',
                              city: filterPageValues['api']['city'] ?? "",
                              startDate:
                                  filterPageValues['api']['dateRange'] ?? '',
                            )
                          : FetchEventList(
                              eventTypes: [],
                              modes: [],
                              // searchText: '',
                              eligibleDeptIdentities: [],
                              certIdentity: '',
                              eventTypeIdentity: '',
                              perkIdentities: [],
                              accommodationIdentities: [],
                              country: '',
                              state: '',
                              city: '',
                              startDate: null,
                              // endDate: null,
                              // minPrice: null,
                              // maxPrice: null,
                              // page: null,
                              // limit: null,
                              // sortBy: ''
                            ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: ListView.builder(
                      itemCount: eventListState.eventList.length,
                      itemBuilder: (context, index) {
                        final list = eventListState.eventList[index];

                        // -------- field name ------------
                        final title = list['title'] ?? "No title";

                        final featuredImagePath =
                            (list['bannerImages'] != null &&
                                list['bannerImages'].isNotEmpty)
                            ? list['bannerImages'][0]
                            : '';

                        // ------ date format -------
                        final rawDate = list['eventDate']?.toString() ?? "";

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
                            debugPrint("Date parsing error: $e");
                            dateFormat =
                                rawDate; // Fallback to raw string if parsing fails
                          }
                        }

                        // ---- venue ---
                        final venue = list['venue'] ?? "no venue";

                        // -------- identity ---------
                        final identity = list['slug'];

                        // final identity = list['slug'];

                        final paymentLink = list['paymentLink'];

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
                                  builder: (_) => EventDetailPage(
                                    slug: identity,
                                    title: title,
                                    whichScreen: 'view',
                                    paymentLink: paymentLink,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 0, bottom: 16),
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 5,
                                bottom: 5,
                                top: 5,
                              ),
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
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Hero(
                                        tag: 'event_image_$identity',
                                        child: CachedNetworkImage(
                                          memCacheHeight: 300,
                                          fadeInDuration: Duration.zero,
                                          imageUrl: featuredImagePath,
                                          fit: BoxFit.cover,
                                          height: 110,
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
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
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
                                                    listener: (context, eventState) {
                                                      if (eventState
                                                              is EventLikeFail &&
                                                          eventState.id ==
                                                              list['identity']) {
                                                        FlutterToast()
                                                            .flutterToast(
                                                              eventState
                                                                  .errorMessage,
                                                              ToastificationType
                                                                  .error,
                                                              ToastificationStyle
                                                                  .flat,
                                                            );
                                                      } else if (eventState
                                                              is EventLikeSuccess &&
                                                          eventState.id ==
                                                              list['identity']) {
                                                        list['isLiked'] =
                                                            eventState.checkFav;
                                                      }
                                                    },
                                                    builder: (context, eventState) {
                                                      final bloc = context
                                                          .watch<
                                                            EventLikeBloc
                                                          >();
                                                      final checkFav =
                                                          bloc.favStatus[list['identity']
                                                              .toString()] ??
                                                          list['isLiked'];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context.read<EventLikeBloc>().add(
                                                            ClickEventLike(
                                                              eventId:
                                                                  list['identity']
                                                                      .toString(),
                                                              initialFav:
                                                                  list['isLiked'] ??
                                                                  false,
                                                              initialCount:
                                                                  int.tryParse(
                                                                    list['likeCount']
                                                                            ?.toString() ??
                                                                        '0',
                                                                  ) ??
                                                                  0,
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
                                                            checkFav
                                                                ? Icons.favorite
                                                                : Icons
                                                                      .favorite_border,
                                                            size: 20,
                                                            color: checkFav
                                                                ? MyColor()
                                                                      .redClr
                                                                : null,
                                                          ),
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

                                                      return GestureDetector(
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
                                                  dateFormat,
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
              } else if (eventListState is EventFail) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<EventListBloc>().add(
                      FetchEventList(
                        eventTypes: [],
                        modes: [],
                        eligibleDeptIdentities: [],
                        certIdentity: '',
                        eventTypeIdentity: '',
                        perkIdentities: [],
                        accommodationIdentities: [],
                        country: '',
                        state: '',
                        city: '',
                        startDate: null,
                        // endDate: null,
                        // minPrice: null,
                        // maxPrice: null,
                        // page: null,
                        // limit: null,
                        // sortBy: ''
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

  // ----------- filter pop up ui ---------------
  Widget filterChip(String text, int index) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Text(text),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => removeFiler(index, text),
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }
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

// ---------- Skeleton loading ui model -------
Widget eventCardShimmer() {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
