import 'package:all_college_event_app/features/screens/event/model/EventDetailModel.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/home/bloc/eventListBloc/trending_event_list_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
                margin: EdgeInsets.only(top: 30,left: 16,right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending Events",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "blMelody"
                    ),),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("See all",style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 0.0),
                duration: (Duration(milliseconds: 600)),
                builder:  (context, value, child) {
                  return Transform.translate(offset: Offset(value, 0),child: Opacity(
                      opacity: 1 - (value / 50),
                      child: child),);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(trendingEventState.trendingEventList.length, (index) {

                      final list = trendingEventState.trendingEventList[index];
                      final title = list['title'];
                      final venue = list['venue'];

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

                      print("object");

                      // ------ event mode ------
                      final eventMode = list['mode'];

                      // ------- image path ---------
                      final featuredImage = list['bannerImage'];

                      // -------- identity ---------
                      final identity = list['identity'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailPage(identity: identity, title: title,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0, top: 15),
                          width: 220,
                          decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              borderRadius: BorderRadiusGeometry.circular(12),
                              border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15))
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl: featuredImage ?? '',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Iconsax.image,size: 50,),
                                ),
                              ),

                              // ------ icon --------
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(title,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                        ),
                                        Row(
                                          children: [
                                            circleIcon(Icons.favorite_border),
                                            SizedBox(width: 5,),
                                            circleIcon(Icons.bookmark_outline),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on, size: 15,),
                                            SizedBox(width: 5,),
                                            Text(venue ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Icon(Icons.local_activity_outlined,
                                              size: 15,),
                                            SizedBox(width: 5,),
                                            Text(
                                              "₹1999", style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12
                                            ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month, size: 15,),
                                            SizedBox(width: 5,),
                                            Text(dateFormat,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                  color: eventMode == "offline" ? MyColor().redClr : MyColor().greenClr,
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(eventMode,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),

                              // ------- event content --------
                              Container(
                                margin: EdgeInsets.only(bottom: 10, right: 10),
                                width: 52,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: MyColor().primaryBackgroundClr,
                                    border: Border.all(
                                        color: MyColor().primaryClr),
                                    borderRadius: BorderRadiusGeometry.circular(
                                        40)
                                ),
                                child: Text("Paid", style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                )),
                              )
                            ],
                          ),
                        ),
                      );

                    }),
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

