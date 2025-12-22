import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrganizationCarouselSliderModel extends StatefulWidget {
  const OrganizationCarouselSliderModel({super.key});

  @override
  State<OrganizationCarouselSliderModel> createState() => _OrganizationCarouselSliderModelState();
}

class _OrganizationCarouselSliderModelState extends State<OrganizationCarouselSliderModel> {

  // Smooth Indicator controller
  final scrollController = CarouselSliderController();

  int currentPage = 0;


  List<String> photoList = [
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: photoList.length,
          itemBuilder: (BuildContext context, index, realIndex) {
            final sliderList = photoList[index];
            return GestureDetector(
              onTap: (){
                // print("sliderListsliderListsliderListsliderListsliderList${sliderList['id']}");
              },
              child: Container(
                margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(sliderList,
                  fit: BoxFit.cover,
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
            autoPlayCurve: Curves
                .fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(
                milliseconds: 800),
            viewportFraction: 1,
            aspectRatio: 1.9,
            clipBehavior: Clip
                .antiAlias,
            pageSnapping: true,
            padEnds: true,
            animateToClosest: true,
          ),),
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
