import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/report/ui/ReportPage.dart';
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

  final descriptionText = "Mathematics is one of the most essential subjects for developing logical thinking, analytical skills, and structured problem-solving abilities. A strong foundation in mathematics helps students understand patterns, build reasoning skills, and apply concepts to real-life situations.";

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
      body: ListView(
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
         ),

          // -------- Event Begins ------


          // ------ Venue & Ticket Details ---------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Text("Venue & Ticket Details",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: MyColor().blackClr
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 20),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(8)
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
                          child: Icon(Iconsax.location_copy,size: 14,)),
                      SizedBox(width: 5,),
                      Expanded(child: Text("22nd, brindhavan avenue, Hall - A, saravanampatti, coimbatore.",style: GoogleFonts.poppins(
                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                      ),)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    tickerName(title: 'Ticket Name', icon: Iconsax.ticket, backClr: MyColor().yellowClr),
                                    SizedBox(height: 5,),
                                    Text('Early bird registration',
                                      style: GoogleFonts.poppins(
                                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                    ),),
                                    SizedBox(height: 2,),
                                    Text('Elite Registration',style: GoogleFonts.poppins(
                                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container( padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    tickerName(title: 'Price', icon: Iconsax.ticket, backClr: MyColor().redClr),
                                    SizedBox(height: 5,),
                                    Text('₹500',style: GoogleFonts.poppins(
                                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                    ),),
                                    SizedBox(height: 2,),
                                    Text('₹500',style: GoogleFonts.poppins(
                                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  tickerName(title: 'Timeline', icon: Iconsax.clock, backClr: MyColor().blueClr),
                                  SizedBox(height: 5,),
                                  Text('Ends at 12/09',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                    ),),
                                  SizedBox(height: 2,),
                                  Text('Starts at 28/09',style: GoogleFonts.poppins(
                                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container( padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  tickerName(title: 'Ticket Status', icon: Iconsax.ticket, backClr: MyColor().primaryClr),
                                  SizedBox(height: 5,),
                                  Text('₹500',style: GoogleFonts.poppins(
                                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                  ),),
                                  SizedBox(height: 2,),
                                  Text('₹500',style: GoogleFonts.poppins(
                                      fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
                                  ),),
                                ],
                              )
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
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Text("Event Host Details",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: MyColor().blackClr
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 20),
            decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(8)
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
                            Text("Organization Name",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("ECLearnix EdTech Private Limited",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Name",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("Nandhini J",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Contact",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("+91 93455 67850",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Department",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("B.Sc Computer Science",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
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
            margin: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 20),
            decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(8)
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
                            Text("Organization Name",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("ECLearnix EdTech Private Limited",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Name",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("Nandhini J",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Contact",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("+91 93455 67850",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organizer Department",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                            ),),
                            SizedBox(height: 2,),
                            Text("B.Sc Computer Science",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                            ),),
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
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Text("Other Details",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: MyColor().blackClr
            ),),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16,right: 0,top: 10,bottom: 20),
                decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Perks",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                          ),),
                          SizedBox(height: 5),
                          Text("• Awards",style: GoogleFonts.poppins(
                            fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
                          Text("• Cash",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Certifications",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                          ),),
                          SizedBox(height: 5),
                          Text("• Awards",style: GoogleFonts.poppins(
                            fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
                          Text("• Cash",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16,right: 0,top: 10,bottom: 20),
                decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Accommodations",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr
                          ),),
                          SizedBox(height: 5),
                          Text("• Stay",style: GoogleFonts.poppins(
                            fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
                          Text("• Washrooms",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),  Text("• Food",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),  Text("• Network",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),  Text("• Stay",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),  Text("• Washrooms",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),  Text("• Food",style: GoogleFonts.poppins(
                              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().borderClr
                          ),),
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
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Text("Discounts & Offers",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: MyColor().blackClr
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 20),
            decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Iconsax.discount_circle),
                  SizedBox(width: 5,),
                  Text("Get 50% off on Elite tickets",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                  ),)
                ],
              ),
            ),
          ),

          // --------- Tags ---------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Text("Tags",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: MyColor().blackClr
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 20),
            decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Wrap(
                children: List.generate(tags.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(10),
                      child: Text(tags[index]));
                },),
              ),
            ),
          ),

          // --------- View Event Video --------
          Container(
            height: 48,
            width: 360,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20,left: 16,right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: MyColor().primaryClr)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Iconsax.youtube,color: MyColor().primaryClr,),
                Text("View Event Video",style: GoogleFonts.poppins(
                  fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),),
              ],
            ),
          ),
          Container(
            height: 48,
            width: 360,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20,left: 16,right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: MyColor().primaryClr)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Iconsax.kyber_network_knc,color: MyColor().primaryClr,),
                Text("Visit Website",style: GoogleFonts.poppins(
                  fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),),
              ],
            ),
          ),

          // ---------- Follow -------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 20),
            decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.instagram,color: Colors.red,),
                      Icon(Iconsax.instagram,color: Colors.red,),
                      Icon(Iconsax.instagram,color: Colors.red,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  MyModels().customButton(onPressed: (){}, title: "+ Follow")
                ],
              )
            ),
          ),

          // --------- Rate for Organizers Field -----
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rate for Organizers",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MyColor().blackClr
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ReportPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColor().primaryClr.withOpacity(0.10)
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.warning_2,color: MyColor().redClr,),
                        SizedBox(width: 5,),
                        Text("Report Event",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isFilled = index < starIndex;
              return GestureDetector(
                onTap: (){
                  setState(() {
                    if(starIndex == index + 1){
                      starIndex--;
                    }else{
                      starIndex = index + 1;
                    }
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Icon(
                      isFilled  ? Icons.star : Icons.star_border,color: isFilled ? MyColor().yellowClr : MyColor().borderClr ,size: 30,
                    )),
              );
            },),
          ),

          // ----------- Review Field ----------
          Container(
            margin: EdgeInsets.only(bottom: 10,left: 16,right: 16),
            child: MyModels().textFormFieldCommentLimited(context: context, label: '', hintText: 'Share Your Thoughts', valid: 'Please enter your ', controller: commentController, keyBoardType: TextInputType.multiline, textCapitalization: TextCapitalization.sentences, maxLines: 5, limit: 1500),
          ),

          // ----- Send Button -----
          Align(
            alignment: AlignmentGeometry.topRight,
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,bottom: 30),
              alignment: Alignment.center,
              height: 40,
              width: MediaQuery.of(context).size.width/3,
              decoration: BoxDecoration(
                color: MyColor().primaryClr,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Text("Send",style: GoogleFonts.poppins(
                fontSize: 14,color: MyColor().whiteClr,fontWeight: FontWeight.w500
              ),),
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

// ---------- Custom Ticket name -------
Widget tickerName({required String title,required IconData icon, required Color backClr}){
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: backClr.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: backClr,width: 0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(icon,size: 12,color: backClr,),
        ),
      ),
      SizedBox(width: 5,),
      Text(title,style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12
      ),),
    ],
  );
}