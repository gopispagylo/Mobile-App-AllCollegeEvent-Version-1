import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventListBloc/event_list_bloc.dart';
import 'package:all_college_event_app/features/screens/organization/model/OrganizationHeaderModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrganizationPage extends StatefulWidget {
  final String title;

  const OrganizationPage({super.key, required this.title});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {

  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => EventListBloc(apiController: ApiController()),
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async{
                // context.read<EventListBloc>().add(FetchEventList());
              },
              child: ListView(
                children: [

                  // -------- Carousel Slider ------
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: "photoList".length,
                        itemBuilder: (BuildContext context, index, realIndex) {
                          final sliderList = "photoList"[index];
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
                        count: "photoList".length,
                        effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: MyColor().primaryClr,
                          dotColor: MyColor().sliderDotClr,
                          spacing: 8,
                        ),
                      ),
                    ],
                  ),

                  // ------ Name Header -------
                  OrganizationHeaderModel()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
