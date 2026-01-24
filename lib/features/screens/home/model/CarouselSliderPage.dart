import 'dart:async';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            CarouselSlider.builder(
              itemCount: photoList.length,
              itemBuilder: (BuildContext context, index, realIndex) {
                final sliderList = photoList[index];
                double opacity = 1.0;

                if(index == currentPage){
                  opacity = 1.0;
                }else if((index - currentPage).abs() == 1){
                  opacity = 0.5;
                }else{
                  opacity = 0.3;
                }

                return AnimatedOpacity(
                  duration: const Duration(microseconds: 1500),
                  opacity: opacity,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: 16,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: MyColor().whiteClr,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(sliderList,fit: BoxFit.cover,)),
                      // child: CachedNetworkImage(
                      //   imageUrl: sliderList,
                      //   fit: BoxFit.cover,
                      //   placeholder: (context, url) => Center(
                      //     child: CircularProgressIndicator(
                      //       color: MyColor().primaryClr,
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) =>
                      //   const Icon(Icons.image_not_supported),
                      // ),
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
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlayCurve: Curves.easeOutBack,
                scrollPhysics: const BouncingScrollPhysics(),
                enableInfiniteScroll: true,
                viewportFraction: 0.55,
                aspectRatio: 1.2,
                pageSnapping: true,
                padEnds: true,
                animateToClosest: true,
              ),
            ),
            Container(
              child: Center(
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
            ),
          ],
        ),
      ],
    );
  }

}
