import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class TrendingEventModel extends StatefulWidget {
  const TrendingEventModel({super.key});

  @override
  State<TrendingEventModel> createState() => _TrendingEventModelState();
}

class _TrendingEventModelState extends State<TrendingEventModel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingEventListBloc, TrendingEventListState>(
      builder: (context, trendingEventState) {
        if (trendingEventState is TrendingEventListLoading) {
          return categoryShimmer();
        } else if (trendingEventState is TrendingEventListSuccess) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 16, right: 6),
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "See all",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 0.0),
                duration: (Duration(milliseconds: 600)),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: Opacity(opacity: 1 - (value / 50), child: child),
                  );
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      trendingEventState.trendingEventList.length,
                      (index) {
                        final list =
                            trendingEventState.trendingEventList[index];

                        final title = list['title'];

                        String venue;

                        String price;

                        if (list['tickets'][0]['price'] != null &&
                            list['tickets'][0]['price'] != 0) {
                          price = "₹${list['tickets'][0]['price'].toString()}";
                        } else {
                          price = "Free";
                        }

                        // ------ date format -------
                        final rawDate = list['calendars'][0]['startDate'];

                        final parsedDate = DateFormat(
                          'dd MMM yy',
                        ).format(DateTime.parse(rawDate));

                        // ------ event mode ------
                        String eventMode;

                        if (list['mode'] == "ONLINE") {
                          eventMode = 'Online';
                          venue = 'Online';
                        } else {
                          eventMode = "Offline";
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

                        // --------- find a save bool value -------
                        bool isSaved = list['isSaved'] == true;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventDetailPage(
                                  identity: identity,
                                  title: title,
                                  whichScreen: 'view',
                                  paymentLink: paymentLink,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 16,
                              left: index == 0 ? 16 : 0,
                              top: 15,
                            ),
                            width: 220,
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
                                Container(
                                  height: 130,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Hero(
                                    tag: 'event_image_$identity',
                                    child: CachedNetworkImage(
                                      imageUrl: featuredImage ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().primaryClr,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Iconsax.image, size: 50),
                                    ),
                                  ),
                                ),

                                // ------ icon --------
                                Container(
                                  margin: EdgeInsets.all(10),
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
                                                    FlutterToast().flutterToast(
                                                      eventState.errorMessage,
                                                      ToastificationType.error,
                                                      ToastificationStyle.flat,
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
                                                      .watch<EventLikeBloc>();
                                                  final checkFav =
                                                      bloc.favStatus[list['identity']
                                                          .toString()] ??
                                                      list['isLiked'];
                                                  return InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<EventLikeBloc>()
                                                          .add(
                                                            ClickEventLike(
                                                              eventId:
                                                                  list['identity'],
                                                            ),
                                                          );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
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
                                                        color: MyColor().boxInnerClr,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        checkFav
                                                            ? Icons.favorite
                                                            : Icons.favorite_border,
                                                        size: 15,
                                                        color: checkFav
                                                            ? MyColor().redClr
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 5),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: MyColor().borderClr
                                                          .withOpacity(0.15),
                                                    ),
                                                    color: MyColor().boxInnerClr,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                                    size: 15,
                                                    color: isSaved ? MyColor().primaryClr : null,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
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
                                      SizedBox(height: 5),
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
                                                parsedDate,
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
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                    right: 10,
                                  ),
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor().primaryClr.withOpacity(
                                      0.10,
                                    ),
                                    borderRadius: BorderRadiusGeometry.circular(
                                      40,
                                    ),
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
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
