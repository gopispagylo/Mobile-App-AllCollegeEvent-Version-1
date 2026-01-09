import 'dart:async';

import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';

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

  final PageController _pageController = PageController(viewportFraction: 0.50);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-scroll logic
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < photoList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: photoList.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1;
              if (_pageController.position.haveDimensions) {
                value = index.toDouble() - (_pageController.page ?? 0);
              } else {
                // Initial value before scroll starts
                value = index.toDouble() - _currentPage.toDouble();
              }

              // Apply rotations and scaling based on distance from center
              double scale = (1 - (value.abs() * 0.25)).clamp(0.78, 1.0);
              double rotation = value * 0.15;
              double translateX = value * 0;
              double opacity = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);

              return Transform.translate(
                offset: Offset(translateX, 0),
                child: Transform.rotate(
                  angle: rotation,
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: _card(photoList[index], index == _currentPage),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _card(String imagePath, bool isCenter) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

}
