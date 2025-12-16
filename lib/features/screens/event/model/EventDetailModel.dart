import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailModel extends StatefulWidget {
  const EventDetailModel({super.key});

  @override
  State<EventDetailModel> createState() => _EventDetailModelState();
}

class _EventDetailModelState extends State<EventDetailModel> {


  // Smooth Indicator controller
  final scrollController = CarouselSliderController();

  int currentPage = 0;

  List<String> photoList = [
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  final descriptionText = "Mathematics is one of the most essential subjects for developing logical thinking, analytical skills, and structured problem-solving abilities. A strong foundation in mathematics helps students understand patterns, build reasoning skills, and apply concepts to real-life situations.";

  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("International Conference on ICRSEM II - 2025",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
        ),),
      ),
      body: Column(
        children: [
          // --------- Carousel Slider ------
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
              autoPlay: true,
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

          // ------- Title & Share & Add to cart -----------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text("International Conference on ICRSEM II - 2025",style: GoogleFonts.poppins(
                    fontSize: 18,fontWeight: FontWeight.w600,color: MyColor().blackClr
                  ),),
                ),
                circleIcon(Icons.share),
                SizedBox(width: 10,),
                circleIcon(Icons.bookmark_outline),
              ],
            ),
          ),

          // --------- Paid & Online -------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    colorLabel(text: 'Conference', color: MyColor().yellowClr, borderColor: MyColor().yellowClr),
                    SizedBox(width: 10,),
                    colorLabel(text: 'Online', color: MyColor().blueClr, borderColor: MyColor().blueClr),
                    SizedBox(width: 10,),
                    colorLabel(text: 'Paid', color: MyColor().primaryClr, borderColor: MyColor().primaryClr),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.favorite_border,size: 18,color: MyColor().borderClr,),
                    SizedBox(width: 2,),
                    Text("1234",style: GoogleFonts.poppins(
                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined,size: 20,color: MyColor().borderClr,),
                    SizedBox(width: 2,),
                    Text("1234",style: GoogleFonts.poppins(
                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                    ),),
                  ],
                ),
              ],
            ),
          ),

          // ------ Register Button ------
          Container(
              margin: EdgeInsets.only(top: 30,left: 16,right: 16),
              child: MyModels().customButton(onPressed: (){}, title: "Register Now")),

          // ------ Description ------
         Container(
           margin: EdgeInsets.only(left: 16,right: 16,top: 30),
           child: Column(
             children: [
               Text(descriptionText,maxLines: readMore ? null : 2,),
               Align(
                 alignment: AlignmentGeometry.topRight,
                 child: GestureDetector(
                   onTap: () {
                     setState(() {
                       readMore = !readMore;
                     });
                   },
                   child: Text(
                     readMore ? "Read less" : "Read more",
                     style: const TextStyle(color: Colors.blue),
                   ),
                 ),
               ),
             ],
           ),
         )
        ],
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

// -------- Custom Color Label ----------
Widget colorLabel({required String text, required Color color, required Color borderColor}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(44),
      border: Border.all(color: borderColor)
    ),
    child: Text(text,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 12,color: MyColor().blackClr
    ),),
  );
}