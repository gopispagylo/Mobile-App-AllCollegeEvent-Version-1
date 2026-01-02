import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/report/ui/ReportPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
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
  int selectedIndex = 0;

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
  void initState() {
    super.initState();
    print("sghkghdfgdfhgdhjhjghgfhjghdfgh${widget.identity}");
  }

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
                itemCount: list['bannerImages'].length,
                itemBuilder: (BuildContext context, index, realIndex) {
                  final sliderList = list['bannerImages'][index];
                  return GestureDetector(
                    onTap: () {

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
                      child: CachedNetworkImage(
                        imageUrl: sliderList,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(color: MyColor().primaryClr,),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
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
                  count: list['bannerImages'].length,
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
                        circleIcon(Icons.favorite_border),
                        SizedBox(width: 10),
                        circleIcon(Icons.share),
                      ],
                    )
                  ],
                ),
              ),

              // ------ Event Details ------
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20,left: 16,right: 16),
                  decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: customTabBar(title: 'Events Details', index: 0)),
                      Expanded(child: customTabBar(title: 'Host Details', index: 1)),
                    ],
                  ),
                ),
              ),

             selectedIndex == 0 ? Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // ------ Event video & website ---------
                  Container(
                    margin: EdgeInsets.only(left: 16,right: 16,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Iconsax.youtube),
                              Text('Youtube')
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Iconsax.kyber_network_knc),
                              Text('Website')
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.only(left: 8,right: 8,top: 18,bottom: 18),
                          decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                          ),
                          child: Row(
                            children: [
                              Icon(Iconsax.map),
                              Text('View Map Location')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ------ Ticket Details ---------
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
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
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ------- Title -------
                          Text(
                            "Ticket Details",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: MyColor().blackClr,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ---------- Grid view --------
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list['tickets'].length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              final ticket = list['tickets'][index];
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: MyColor().blueClr.withOpacity(0.05),
                                  border: Border.all(
                                    color: MyColor().borderClr.withOpacity(0.15),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    tickerName(
                                      title: ticket['name'],
                                      icon: Iconsax.ticket,
                                      backClr: MyColor().yellowClr,
                                    ),

                                    const SizedBox(height: 6),
                                    bulletText(ticket['description'],Iconsax.tag),
                                    bulletText(ticket['price'].toString(),Iconsax.tag),
                                    bulletText('Ticket ends at ${DateFormat('dd/MM').format(DateTime.parse(ticket['sellingTo']))}',Iconsax.calendar),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
                                  Column(
                                    children:List.generate(list['eventPerks'].length, (index){
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 16,
                                            color: MyColor().greenClr,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            list['eventPerks'][index]['perk']['perkName'] ?? '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: MyColor().borderClr,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_rounded,
                                        size: 16,
                                        color: MyColor().greenClr,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        list['cert']['certName'] ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: MyColor().borderClr,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
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
                                  Column(
                                    children:List.generate(list['eventAccommodations'].length, (index){
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: MyColor().greenClr,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            list['eventAccommodations'][index]['accommodation']['accommodationName'] ?? '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: MyColor().borderClr,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                        children: List.generate(list['tags'].length, (index) {
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
                            child: Text("#${list['tags'][index] ?? ''}"),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              )
                 : Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 SizedBox(height: 20,),

                 // -------- Event Host Details -------
                 Row(
                   children: [
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
                     Expanded(
                       child: Container(
                         margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                         alignment: Alignment.center,
                         height: 40,
                         decoration: BoxDecoration(
                           color: MyColor().primaryClr,
                           borderRadius: BorderRadius.circular(100),
                         ),
                         child: Text(
                           "+ Follow",
                           style: GoogleFonts.poppins(
                             fontSize: 14,
                             color: MyColor().whiteClr,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16),
                   child: Column(
                     children: List.generate(list['Collaborator'].length, (index){
                       return Container(
                         margin: EdgeInsets.only(bottom: 20),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(
                               child: _infoCard(
                                 title: "Organization",
                                 items: [
                                   _infoRow(Iconsax.building,
                                       list['Collaborator'][index]['member']['organizationName']),
                                   _infoRow(Iconsax.location,
                                       list['Collaborator'][index]['member']['location']),
                                 ],
                               ),
                             ),
                             const SizedBox(width: 12),
                             Expanded(
                               child: _infoCard(
                                 title: "Organizer",
                                 items: [
                                   _infoRow(Iconsax.profile_circle, list['Collaborator'][index]['member']['organizerName']),
                                   _infoRow(Iconsax.call, list['Collaborator'][index]['member']['organizerNumber']),
                                   _infoRow(
                                       Iconsax.book, list['Collaborator'][index]['member']['orgDept']),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       );
                     }),
                   ),
                 ),

                 // ------- Follow us on ------
                 Container(
                   margin: EdgeInsets.only(
                     left: 16,
                     right: 16,
                     // top: 10,
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
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Follow us on",style: GoogleFonts.poppins(
                                 fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().blackClr
                               ),),
                               SizedBox(width: 10),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Iconsax.instagram, color: Colors.red),
                                   Icon(Iconsax.instagram, color: Colors.red),
                                   Icon(Iconsax.instagram, color: Colors.red),
                                 ],
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 ),

                 // --------- Rate for Organizers Field -----
                 Container(
                   margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                   child: Text(
                     "Rate for Organizers",
                     style: GoogleFonts.poppins(
                       fontWeight: FontWeight.w600,
                       fontSize: 18,
                       color: MyColor().blackClr,
                     ),
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
                 Center(
                   child: Container(
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
                 ),

                 // ----- Report & Send Button -----
                 Container(
                   margin: EdgeInsets.only(bottom: 30),
                   child: Row(
                     children: [
                       Expanded(
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (_) => ReportPage()),
                             );
                           },
                           child: Container(
                             margin: EdgeInsets.only(left: 16, right: 16,),
                             alignment: Alignment.center,
                             height: 40,
                             decoration: BoxDecoration(
                               color: MyColor().primaryBackgroundClr,
                               borderRadius: BorderRadius.circular(100),
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
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
                       ),
                       Expanded(
                         child: Container(
                           margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                           alignment: Alignment.center,
                           height: 40,
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
                   ),
                 ),

               ],
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

  // --------- Custom Tab Bar --------------
  Widget customTabBar({required String title, required int index}){
    final selectedValue = selectedIndex == index;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: !selectedValue ? MyColor().boxInnerClr : MyColor().blueClr.withOpacity(0.15)
        ),
        child: Text(title,style: GoogleFonts.poppins(
            fontSize: 12,fontWeight: FontWeight.w600,color: MyColor().blackClr
        ),),
      ),
    );
  }

  Widget bulletText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              shape: BoxShape.circle
            ),
            child: Icon(icon,size: 10,color: MyColor().primaryClr,),
          ),
          const SizedBox(width: 6),

          Expanded(
            child: Text(
              text,
              // overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: MyColor().blackClr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColor().boxInnerClr,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          ...items,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: MyColor().primaryClr.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 10,
              color: MyColor().primaryClr,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
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
Widget colorLabel({
  required String text,
  required Color color,
  required Color borderColor,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(44),
      // border: Border.all(color: borderColor),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 10,
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
        padding: EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
        decoration: BoxDecoration(
          color: backClr.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
    ],
  );
}

// -------- skeleton loader ---------
Widget eventDetailShimmer() {
  return ListView(
    children: [

      // -------- Carousel --------
      Shimmer(
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // -------- Indicator --------
      Shimmer(
        child: Center(
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
      ),

      // -------- Title + Icons --------
      Shimmer(
        child: Padding(
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
      ),

      // -------- Labels --------
      Shimmer(
        child: Padding(
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
      ),

      // -------- Register Button --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),

      // -------- Description --------
      Shimmer(
        child: Padding(
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
      ),

      const SizedBox(height: 20),

      // -------- Venue --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Host --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Discount --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Tags --------
      Shimmer(
        child: Padding(
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
      ),

      // -------- Buttons --------
      Shimmer(
        child: Padding(
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
      ),

      const SizedBox(height: 20),

      // -------- Rating --------
      Shimmer(
        child: Center(
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
      ),

      // -------- Comment Box --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Send Button --------
      Shimmer(
        child: Align(
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
      ),
    ],
  );
}


