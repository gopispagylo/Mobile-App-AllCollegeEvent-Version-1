import 'dart:math' as math;

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AboutUsModel extends StatefulWidget {
  const AboutUsModel({super.key});

  @override
  State<AboutUsModel> createState() => _AboutUsModelState();
}

class _AboutUsModelState extends State<AboutUsModel> {


  // ----------- reviews list -------------
  final List<Map<String,dynamic>> reviewsList = [
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/happy.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/excellent.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/happy.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/excellent.png"
    },{
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/happy.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/excellent.png"
    },{
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/happy.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/excellent.png"
    },{
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/happy.png"
    },
    {
      'name' : "Jerome Bell",
      'user_or_org' : 'Organizer',
      'comment' : "I absolutely love using Evenjo! I bought tickets for Adele’s concert in Dallas, and good.",
      'emoji' : "assets/image/excellent.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        // ------------ title --------------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("The ",style: GoogleFonts.poppins(
                fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
            ),),
            Text("Story ",style: GoogleFonts.poppins(
                fontSize: 18,color: MyColor().yellowClr,fontWeight: FontWeight.w500
            ),),
            Text("Behind the",style: GoogleFonts.poppins(
                fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
            ),),
            Text(" Fest",style: GoogleFonts.poppins(
                fontSize: 18,color: MyColor().primaryClr,fontWeight: FontWeight.w500
            ),),
          ],
        ),

        // ------------- Photo --------------
        Container(
          margin: EdgeInsets.only(top: 20,left: 16,right: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: MyColor().redClr,
                        borderRadius: BorderRadiusGeometry.circular(8)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(child: Image.asset(ImagePath().banner_2,fit: BoxFit.cover,)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: MyColor().redClr,
                          borderRadius: BorderRadiusGeometry.circular(8)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(child: Image.asset(ImagePath().banner_4,fit: BoxFit.cover,)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: MyColor().redClr,
                          borderRadius: BorderRadiusGeometry.circular(8)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(child: Image.asset(ImagePath().banner_5,fit: BoxFit.cover,)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: MyColor().redClr,
                            borderRadius: BorderRadiusGeometry.circular(8)
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ClipRRect(child: Image.asset(ImagePath().banner_3,fit: BoxFit.cover,)),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: MyColor().redClr,
                            borderRadius: BorderRadiusGeometry.circular(8)
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ClipRRect(child: Image.asset(ImagePath().banner_1,fit: BoxFit.cover,)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --------------- About ---------
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("About ",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
              ),),
              Text("AllCollegeEvent",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().primaryClr,fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 5),
          child: Text(textAlign: TextAlign.center,ConfigMessage().aboutText,style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,color: MyColor().blackClr,fontSize: 14
          ),),
        ),

        // --------------- What We Stand For ---------
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("What We ",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
              ),),
              Text("Stand For",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().primaryClr,fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),

        // ------------ mission, vision and value ------------
        Stack(
          alignment: Alignment.center,
          children: [

            // ----------- vector of dot dot lines ------------
            Container(
                margin: EdgeInsets.only(left: 30,right: 30,top: 60),
                child: Image.asset(ImagePath().lineVictor)),


            // ---------------- card -----------------
            Column(
              children: [

                // ------ mission card -------
                Align(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: -5 * math.pi / 180,
                        child: Container(
                          margin: EdgeInsets.only(left: 20,top: 35),
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().whiteClr,
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor().blackClr.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                )
                              ]
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                                color: MyColor().primaryBackgroundClr.withOpacity(0.50),
                                borderRadius: BorderRadius.circular(14)
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.xd,color: MyColor().primaryClr,),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(ConfigMessage().missionText,style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,color: MyColor().blackClr,fontSize: 12
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(

                          top: 0,
                          child: Image.asset(ImagePath().pinFirst,height: 90,)),
                    ],
                  ),
                ),

                // ------ vision card -------
                Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: 5 * math.pi / 180,
                        child: Container(
                          margin: EdgeInsets.only(right: 20,top: 35),
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().whiteClr,
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor().blackClr.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                )
                              ]
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                                color: MyColor().yellowClr.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(14)
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.eye,color: MyColor().yellowClr,),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(ConfigMessage().visionText,style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,color: MyColor().blackClr,fontSize: 12
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          child: Image.asset(ImagePath().pinSecond,height: 75,)),
                    ],
                  ),
                ),

                // ------ value card -------
                Align(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      Transform.rotate(
                        angle: -5 * math.pi / 180,
                        child: Container(
                          margin: EdgeInsets.only(left: 20,top: 50),
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor().whiteClr,
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor().blackClr.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                )
                              ]
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                                color: MyColor().blueClr.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(14)
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.diamonds_copy,color: MyColor().blueClr,),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(ConfigMessage().valueText,style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,color: MyColor().blackClr,fontSize: 12
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          child: Image.asset(ImagePath().pinThird,height: 90,)),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),

        // ---------------- journey ----------
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Our Journey ",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().primaryClr,fontWeight: FontWeight.w500
              ),),
              Text("in Numbers",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),

        // --------- event counts ------------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 18),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Image.asset(ImagePath().ourJourney),
                Row(
                  children: List.generate(3, (index){
                    return Expanded(
                      child: Column(
                        children: [
                          Text("0",style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().whiteClr
                          ),),
                          Text(textAlign: TextAlign.center,"Event Organizers",style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().whiteClr
                          ),),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            )),

        // ----------- voice of trust ------------
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Voice Of ",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().blackClr,fontWeight: FontWeight.w500
              ),),
              Text("Trust",style: GoogleFonts.poppins(
                  fontSize: 18,color: MyColor().primaryClr,fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),

        // --------------- carousel slider -------------
        CarouselSlider.builder(itemCount: reviewsList.length,itemBuilder: (context, index, realIndex) {
          final list = reviewsList[index];
          return Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(list['name']),
                          Text(list['user_or_org']),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: MyColor().boxInnerClr,
                            shape: BoxShape.circle,
                            border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                            boxShadow: [
                              BoxShadow(
                                color: MyColor().blackClr.withOpacity(0.15),
                                blurRadius: 2,
                                offset: Offset(2, 2)
                              )
                            ]
                          ),
                          child: Image.asset(list['emoji'],height: 30,))
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(list['comment'])),
                ],
              ),
            ),
          );
        },
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: false,
            height: null, // allow dynamic height
          ),
        ),
      ],
    );
  }
}
