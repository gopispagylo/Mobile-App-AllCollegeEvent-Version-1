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
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 10),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: photoList.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = photoList[index];
                      final bool isActive = index == currentPage;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOut,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: isActive ? 6 : 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColor().borderClr.withValues(alpha: 0.1),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 180,
                      // enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.easeInOut,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() => currentPage = index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: currentPage,
                count: photoList.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: MyColor().primaryClr,
                  dotColor: MyColor().sliderDotClr,
                  spacing: 8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
