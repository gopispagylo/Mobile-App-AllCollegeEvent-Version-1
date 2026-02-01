import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeCategoriesModel extends StatefulWidget {
  const HomeCategoriesModel({super.key});

  @override
  State<HomeCategoriesModel> createState() => _HomeCategoriesModelState();
}

class _HomeCategoriesModelState extends State<HomeCategoriesModel> {
  int itemPerIndex = 3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventTypeAllBloc, EventTypeAllState>(
      builder: (context, eventTypeAll) {
        if (eventTypeAll is EventTypeAllLoading) {
          return categoryShimmer();
        } else if (eventTypeAll is EventTypeSuccessAll) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 16, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pick Your Vibe!",
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
                              pageIndex: 2,
                              whichScreen: '',
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
                height: 150,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: PageController(viewportFraction: 1),
                  itemCount: (eventTypeAll.eventTypeList.length / itemPerIndex)
                      .ceil(),
                  itemBuilder: (context, pageIndex) {
                    final startIndex = pageIndex * itemPerIndex;
                    final endIndex = (startIndex + itemPerIndex).clamp(
                      0,
                      eventTypeAll.eventTypeList.length,
                    );
                    final pageItems = eventTypeAll.eventTypeList.sublist(
                      startIndex,
                      endIndex,
                    );
                    return Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(pageItems.length, (index) {
                          final list = pageItems[index];
                          final bgColor = list['color'];
                          final splitBGColor = bgColor.replaceFirst(
                            "#",
                            "0xff",
                          );
                          return Container(
                            height: 104,
                            width: 104,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(
                                int.tryParse(splitBGColor)!.toInt(),
                              ).withOpacity(0.60),
                              border: Border.all(
                                color: MyColor().borderClr.withOpacity(0.15),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: list['imageUrl'] ?? '',
                                    height: 60,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().primaryClr,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    list['name'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (eventTypeAll is EventTypeFailAll) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(eventTypeAll.errorMessage),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  // ------- skeleton loading ------
  Widget categoryShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 16,
              right: index == 6 - 1 ? 16 : 0,
            ),
            height: 104,
            width: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon placeholder
                  Shimmer(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Text placeholder
                  Shimmer(
                    child: Container(
                      height: 10,
                      width: 60,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
