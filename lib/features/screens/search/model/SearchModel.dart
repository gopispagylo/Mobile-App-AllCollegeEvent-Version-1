import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/search/bloc/searchEventListBloc/search_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/globalUnFocus/GlobalUnFocus.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  // -------- controller --------
  final searchController = TextEditingController();

  // ---------- recent search active inactive ----------
  bool isRecent = false;

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
              // onTapOutside: (onChanged) {
              //   GlobalUnFocus.unFocus();
              //   setState(() {
              //     isRecent = false;
              //   });
              // },
              onTap: () {
                setState(() {
                  isRecent = true;
                });
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
              ),
            ),
          ),
        ),

        // ----- recent search ------
        Visibility(
          visible: isRecent,
          child: Container(
            decoration: BoxDecoration(
                color: MyColor().whiteClr
            ),
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
              }
              else if (searchEventListState is SearchEventListSuccess) {
                return RefreshIndicator(
                  color: MyColor().primaryClr,
                  onRefresh: () async{
                    context.read<SearchEventListBloc>().add(FetchSearchEventList());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 20,),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchEventListState.searchEventList.length,
                      itemBuilder: (context, index) {
                        final list = searchEventListState.searchEventList[index];
          
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
                            final parsedDate = DateFormat('dd/MM/yyyy').parse(rawDate);
                            dateFormat = DateFormat('dd MMM yyyy').format(parsedDate);
                          } catch (e) {
                            debugPrint("Date parsing error: $e");
                            dateFormat = rawDate; // Fallback to raw string if parsing fails
                          }
                        }
          
                        // ---- venue ---
                        final venue = list['venue'] ?? "no venue";
          
                        // -------- identity ---------
                        final identity = list['slug'];
                        final paymentLink = list['paymentLink'];
          
                        // ------- Tween Animation -----------
                        return TweenAnimationBuilder(
                          tween: Tween(begin: 50.0, end: 0.0),
                          duration: Duration(milliseconds: 600),
                          builder: (context, value, child) {
                            return Transform.translate(offset: Offset(0, value),
                                child: Opacity(
                                  opacity: 1 - (value / 50),
                                  child: child,)
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              if(!isRecent){
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(pageBuilder: (_,__,___)=> EventDetailPage(slug: identity, title: title, whichScreen: 'view', paymentLink: paymentLink,),
                                        transitionsBuilder: (_, animation, __, child){
                                          return SlideTransition( position: Tween(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                            child: child,);
                                        }
                                    )
                                );
                              } else{
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
                                        imageUrl: featuredImagePath,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.image_not_supported),
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              SizedBox(width: 5),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  BlocConsumer<EventLikeBloc, EventLikeState>(
                                                    listener: (context, eventState) {
                                                      if (eventState is EventLikeFail && eventState.id == list['identity']) {
                                                        FlutterToast().flutterToast(
                                                          eventState.errorMessage,
                                                          ToastificationType.error,
                                                          ToastificationStyle.flat,
                                                        );
                                                      } else if (eventState is EventLikeSuccess && eventState.id == list['identity']) {
                                                        list['isLiked'] = eventState.checkFav;
                                                      }
                                                    },
                                                    builder: (context, eventState) {
                                                      final bloc = context.watch<EventLikeBloc>();
                                                      final checkFav = bloc.favStatus[list['identity'].toString()] ?? list['isLiked'];
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
                                                  BlocConsumer<RemoveSaveEventBloc, RemoveSaveEventState>(
                                                    listener: (context, addSaveSate) {
                                                      if(addSaveSate is RemoveSaveEventFail && addSaveSate.eventId == list['identity']){
                                                        FlutterToast().flutterToast(addSaveSate.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                                                      } else if(addSaveSate is AddSave && addSaveSate.eventId == list['identity']){
                                                        list['isSaved'] = addSaveSate.checkSave;
                                                      }
                                                    },
                                                    builder: (context, addSaveSate) {
                                                      final bloc = context.watch<RemoveSaveEventBloc>();
                                                      final checkSave = bloc.checkSave[list['identity'].toString()] ?? list['isSaved'];

                                                      return InkWell(
                                                        onTap: () {
                                                          context.read<RemoveSaveEventBloc>().add(ClickRemoveSaveEvent(eventId: list['identity']));
                                                        },
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
                                                            checkSave ? Icons.bookmark : Icons.bookmark_outline,
                                                            size: 15,
                                                            color: checkSave ? MyColor().primaryClr : null,
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
                                                MyColor().blueBackgroundClr.withOpacity(
                                                  0.35,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month, size: 14),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  dateFormat,
                                                  overflow: TextOverflow.ellipsis,
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
                                              Icon(Icons.location_on_outlined, size: 14),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  venue,
                                                  overflow: TextOverflow.ellipsis,
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
                                                  color: MyColor().primaryBackgroundClr
                                                      .withOpacity(0.35),
                                                  borderRadius: BorderRadius.circular(8),
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
              }
              else if (searchEventListState is SearchEventListFail) {
                return RefreshIndicator(
                  onRefresh: () async{
                    context.read<SearchEventListBloc>().add(FetchSearchEventList());
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

}
