import 'dart:io';
import 'dart:ui';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularCityCountryDetail extends StatefulWidget {
  const PopularCityCountryDetail({super.key});

  @override
  State<PopularCityCountryDetail> createState() =>
      _PopularCityCountryDetailState();
}

class _PopularCityCountryDetailState extends State<PopularCityCountryDetail> {
  // scroll controller
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    height: 160,
                    child: Image.asset(ImagePath().worldImg, fit: BoxFit.cover),
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
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor().whiteClr.withOpacity(0.07),
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
                              WidgetsBinding.instance.focusManager.primaryFocus!
                                  .unfocus();
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
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: MyColor().primaryClr,
                                  width: 0.5,
                                ),
                              ),
                              prefixIcon: Icon(Icons.search, size: 18),
                              hintText: "Search Events",
                              fillColor: MyColor().whiteClr.withValues(
                                alpha: 0.5,
                              ),
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
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  width: 100,
                  color: Colors.red,
                );
              }, childCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
