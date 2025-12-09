import 'dart:async';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeModel extends StatefulWidget {
  const HomeModel({super.key});

  @override
  State<HomeModel> createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {

  // Smooth Indicator controller
  // final scrollController = PageController(viewportFraction: 0.8,);
  final scrollController = CarouselSliderController();

  int currentPage = 0;

  List<String> photoList = [
    "https://cdn-icons-png.flaticon.com/128/2382/2382461.png",
    "https://img.freepik.com/free-photo/nurse-portrait-hospital_23-2150780r264.jpg?uid=R154840888&ga=GA1.1.208417098.1741326522&semt=ais_hybrid&w=740",
    "https://img.freepik.com/free-photo/portrait-female-pediatrician-work_23-2151686702.jpg?uid=R154840888&ga=GA1.1.208417098.1741326522&semt=ais_hybrid&w=740",
    "https://img.freepik.com/free-photo/nurse-portrait-hospital_23-2150780268.jpg?uid=R154840888&ga=GA1.1.208417098.1741326522&semt=ais_hybrid&w=740",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: ListView(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(44),bottomLeft: Radius.circular(44))
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Welcome Krish",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: MyColor().borderClr,),
                      Text("data")
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 24),
              child: Text("Top Spotlights",style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: "blMelody"
              ),)),
          CarouselSlider.builder(

            itemCount: photoList.length,
            itemBuilder: (BuildContext context, index, realIndex) {
              final sliderList = photoList[index];
              // final title = sliderList['title'];
              return GestureDetector(
                onTap: (){
                  print("sliderListsliderListsliderListsliderListsliderList${sliderList['id']}");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(src,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                s
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
              dotColor: MyColor().primaryClr,
              spacing: 8,
            ),
          ),
        ],
      ),
    );
  }
}
