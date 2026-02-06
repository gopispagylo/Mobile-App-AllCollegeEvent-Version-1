import 'package:all_college_event_app/features/screens/global/bloc/categories/categories_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/eventTypeBloc/event_type_all_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GridViewModel extends StatefulWidget {
  const GridViewModel({super.key});

  @override
  State<GridViewModel> createState() => _GridViewModelState();
}

class _GridViewModelState extends State<GridViewModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
            width: 380,
            child: TextFormField(
              onTapOutside: (onChanged) {
                WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
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
                // suffixIcon: GestureDetector(
                //   onTap: (){
                //
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(5),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: MyColor().locationClr,
                //           borderRadius: BorderRadius.circular(100)
                //       ),
                //       child: Icon(
                //         Icons.tune,
                //       ),
                //     ),
                //   ),
                // ),
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
        // GridView
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: BlocBuilder<EventTypeAllBloc, EventTypeAllState>(
              builder: (context, eventTypeAll) {
                if (eventTypeAll is EventTypeAllLoading) {
                  return GridView.builder(
                    itemCount: 40,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      return categoryCardShimmer();
                    },
                  );
                } else if (eventTypeAll is EventTypeSuccessAll) {
                  return RefreshIndicator(
                    edgeOffset: 20,
                    backgroundColor: MyColor().whiteClr,
                    color: MyColor().primaryClr,
                    onRefresh: () async {
                      context.read<EventTypeAllBloc>().add(EventTypeAll());
                    },
                    child: GridView.builder(
                      itemCount: eventTypeAll.eventTypeList.length,
                      itemBuilder: (context, index) {
                        final list = eventTypeAll.eventTypeList[index];
                        final bgColor = list['color'];
                        final splitBGColor = bgColor.replaceFirst("#", "0xff");
                        return Container(
                          height: 104,
                          width: 104,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(int.tryParse(splitBGColor)!.toInt()),
                            border: Border.all(
                              color: MyColor().borderClr.withOpacity(0.15),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    // memCacheHeight: 300,
                                    fadeInDuration: Duration.zero,
                                    imageUrl: list['imageUrl'] ?? '',
                                    height: 45,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().primaryClr,
                                        ),
                                      );
                                    },
                                  ),
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
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                    ),
                  );
                } else if (eventTypeAll is EventTypeFailAll) {
                  return RefreshIndicator(
                    edgeOffset: 20,
                    backgroundColor: MyColor().whiteClr,
                    color: MyColor().primaryClr,
                    onRefresh: () async {
                      context.read<CategoriesBloc>().add(FetchCategories());
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
        ),
      ],
    );
  }

  // ---------- Skeleton loading ui model -------
  Widget categoryCardShimmer() {
    return Container(
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
  }
}
