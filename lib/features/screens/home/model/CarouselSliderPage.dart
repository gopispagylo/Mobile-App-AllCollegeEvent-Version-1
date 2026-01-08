import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  // Smooth Indicator controller
  final scrollController = CarouselSliderController();

  int currentPage = 0;

  List<String> photoList = [
    ImagePath().banner_1,
    ImagePath().banner_2,
    ImagePath().banner_3,
    ImagePath().banner_4,
    ImagePath().banner_5,
    ImagePath().banner_6,
    ImagePath().banner_7,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 16, right: 16, top: 24),
          child: Text(
            "Top Spotlights",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "blMelody",
            ),
          ),
        ),
        SizedBox(height: 15),
        CarouselSlider.builder(
          itemCount: photoList.length,
          itemBuilder: (BuildContext context, index, realIndex) {
            final sliderList = photoList[index];
            return GestureDetector(
              onTap: () {
                // print("sliderListsliderListsliderListsliderListsliderList${sliderList['id']}");
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.asset(sliderList, fit: BoxFit.cover),
                ),
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            },
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1,
            aspectRatio: 1.9,
            clipBehavior: Clip.antiAlias,
            pageSnapping: true,
            padEnds: true,
            animateToClosest: true,
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: currentPage,
          count: photoList.length,
          effect: WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: MyColor().primaryClr,
            dotColor: MyColor().sliderDotClr,
            spacing: 8,
          ),
        ),
      ],
    );
  }
}
