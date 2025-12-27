import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/report/ui/ReportPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailModel extends StatefulWidget {
  final String identity;
  final String title;

  const EventDetailModel({
    super.key,
    required this.identity,
    required this.title,
  });

  @override
  State<EventDetailModel> createState() => _EventDetailModelState();
}

class _EventDetailModelState extends State<EventDetailModel> {
  // Smooth Indicator controller
  final scrollController = CarouselSliderController();

  // ------- Controller ----------
  final commentController = TextEditingController();

  int currentPage = 0;

  // ------- Star index --------
  int starIndex = 0;

  List<String> photoList = [
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  final descriptionText =
      "Mathematics is one of the most essential subjects for developing logical thinking, analytical skills, and structured problem-solving abilities. A strong foundation in mathematics helps students understand patterns, build reasoning skills, and apply concepts to real-life situations.";

  bool readMore = false;

  List<String> tags = [
    "#conference2025",
    "#international",
    "#2025",
    "#allconference",
    "#internationalconf",
    "#internationalconf",
    "#internationalconf",
  ];

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, eventDetailState) {
        if (eventDetailState is EventDetailLoading) {
          return eventDetailShimmer();
        } else if (eventDetailState is EventDetailSuccess) {
          final list = eventDetailState.eventDetailList[0];
          return ListView(
            children: [
              // --------- Carousel Slider ------
              CarouselSlider.builder(
                itemCount: photoList.length,
                itemBuilder: (BuildContext context, index, realIndex) {
                  final sliderList = photoList[index];
                  return GestureDetector(
                    onTap: () {
                      // print("sliderListsliderListsliderListsliderListsliderList${sliderList['id']}");
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: MyColor().borderClr.withOpacity(0.15),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(sliderList, fit: BoxFit.cover),
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
              Center(
                child: AnimatedSmoothIndicator(
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
              ),

              // ------- Title & Share & Add to cart -----------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        list['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                    circleIcon(Icons.share),
                    SizedBox(width: 10),
                    circleIcon(Icons.bookmark_outline),
                  ],
                ),
              ),

              // --------- Paid & Online -------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        colorLabel(
                          text: 'Conference',
                          color: MyColor().yellowClr,
                          borderColor: MyColor().yellowClr,
                        ),
                        SizedBox(width: 10),
                        colorLabel(
                          text: 'Online',
                          color: MyColor().blueClr,
                          borderColor: MyColor().blueClr,
                        ),
                        SizedBox(width: 10),
                        colorLabel(
                          text: 'Paid',
                          color: MyColor().primaryClr,
                          borderColor: MyColor().primaryClr,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: MyColor().borderClr,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "1234",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 20,
                          color: MyColor().borderClr,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "1234",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ------ Register Button ------
              Center(
                child: Container(
                  width: 320,
                  margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: MyModels().customButton(
                    onPressed: () {},
                    title: "Register Now",
                  ),
                ),
              ),

              // ------ Description ------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  children: [
                    Text(list['description'], maxLines: readMore ? null : 2),
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
              ),

              // -------- Event Begins ------

              // ------ Venue & Ticket Details ---------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Venue & Ticket Details",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Icon(Iconsax.location_copy, size: 14),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "22nd, brindhavan avenue, Hall - A, saravanampatti, coimbatore.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(
                                    0.15,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        tickerName(
                                          title: 'Ticket Name',
                                          icon: Iconsax.ticket,
                                          backClr: MyColor().yellowClr,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Early bird registration',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Elite Registration',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(
                                    0.15,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        tickerName(
                                          title: 'Price',
                                          icon: Iconsax.ticket,
                                          backClr: MyColor().redClr,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '₹500',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '₹500',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(
                                    0.15,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      tickerName(
                                        title: 'Timeline',
                                        icon: Iconsax.clock,
                                        backClr: MyColor().blueClr,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Ends at 12/09',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Starts at 28/09',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(
                                    0.15,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      tickerName(
                                        title: 'Ticket Status',
                                        icon: Iconsax.ticket,
                                        backClr: MyColor().primaryClr,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '₹500',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '₹500',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // -------- Event Host Details -------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Event Host Details",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organization Name",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  list['org']['organizationName'],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Name",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Nandhini J",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Contact",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "+91 93455 67850",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Department",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "B.Sc Computer Science",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 0,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organization Name",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "ECLearnix EdTech Private Limited",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Name",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Nandhini J",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Contact",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "+91 93455 67850",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer Department",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "B.Sc Computer Science",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // -------- Other Details ---------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Other Details",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 0,
                      top: 10,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Perks",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MyColor().blackClr,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "• Awards",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Cash",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Certifications",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MyColor().blackClr,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "• Awards",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Cash",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 0,
                      top: 10,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Accommodations",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MyColor().blackClr,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "• Stay",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Washrooms",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Food",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Network",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Stay",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Washrooms",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                              Text(
                                "• Food",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().borderClr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // --------- Discounts & Offers -------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Discounts & Offers",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Iconsax.discount_circle),
                      SizedBox(width: 5),
                      Text(
                        "Get 50% off on Elite tickets",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --------- Tags ---------
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Tags",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Wrap(
                    children: List.generate(tags.length, (index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(tags[index]),
                      );
                    }),
                  ),
                ),
              ),

              // --------- View Event Video --------
              Container(
                height: 48,
                width: 360,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: MyColor().primaryClr),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.youtube, color: MyColor().primaryClr),
                    Text(
                      "View Event Video",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 48,
                width: 360,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: MyColor().primaryClr),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.kyber_network_knc,
                      color: MyColor().primaryClr,
                    ),
                    Text(
                      "Visit Website",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- Follow -------
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  border: Border.all(
                    color: MyColor().borderClr.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.instagram, color: Colors.red),
                          Icon(Iconsax.instagram, color: Colors.red),
                          Icon(Iconsax.instagram, color: Colors.red),
                        ],
                      ),
                      SizedBox(height: 10),
                      MyModels().customButton(
                        onPressed: () {},
                        title: "+ Follow",
                      ),
                    ],
                  ),
                ),
              ),

              // --------- Rate for Organizers Field -----
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rate for Organizers",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ReportPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyColor().primaryClr.withOpacity(0.10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.warning_2,
                              color: MyColor().redClr,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Report Event",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final isFilled = index < starIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (starIndex == index + 1) {
                          starIndex--;
                        } else {
                          starIndex = index + 1;
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        isFilled ? Icons.star : Icons.star_border,
                        color: isFilled
                            ? MyColor().yellowClr
                            : MyColor().borderClr,
                        size: 30,
                      ),
                    ),
                  );
                }),
              ),

              // ----------- Review Field ----------
              Container(
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
                child: MyModels().textFormFieldCommentLimited(
                  context: context,
                  label: '',
                  hintText: 'Share Your Thoughts',
                  valid: 'Please enter your ',
                  controller: commentController,
                  keyBoardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 5,
                  limit: 1500,
                ),
              ),

              // ----- Send Button -----
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: MyColor().primaryClr,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Send",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: MyColor().whiteClr,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (eventDetailState is EventDetailFail) {
          return RefreshIndicator(
            onRefresh: () async {
              // context.read<EventListBloc>().add(FetchEventList());
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
Widget colorLabel({
  required String text,
  required Color color,
  required Color borderColor,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(44),
      border: Border.all(color: borderColor),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: MyColor().blackClr,
      ),
    ),
  );
}

// ---------- Custom Ticket name -------
Widget tickerName({
  required String title,
  required IconData icon,
  required Color backClr,
}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: backClr.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: backClr, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(icon, size: 12, color: backClr),
        ),
      ),
      SizedBox(width: 5),
      Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
      ),
    ],
  );
}

// -------- skeleton loader ---------
Widget eventDetailShimmer() {
  return ListView(
    children: [

      // -------- Carousel --------
      Container(
        margin: const EdgeInsets.all(16),
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColor().sliderDotClr,
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // -------- Indicator --------
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (_) => Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),

      // -------- Title + Icons --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 18,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),

      // -------- Labels --------
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 70,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 20,
              width: 60,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 20,
              width: 50,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),

      // -------- Register Button --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),

      // -------- Description --------
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 12,
                width: 70,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      // -------- Venue --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // -------- Host --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // -------- Discount --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // -------- Tags --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            6,
                (_) => Container(
              height: 32,
              width: 80,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),

      // -------- Buttons --------
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      // -------- Rating --------
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (_) => Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),

      // -------- Comment Box --------
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // -------- Send Button --------
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 30),
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    ],
  );
}

