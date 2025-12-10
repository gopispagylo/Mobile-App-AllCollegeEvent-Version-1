import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingEventModel extends StatefulWidget {
  const TrendingEventModel({super.key});

  @override
  State<TrendingEventModel> createState() => _TrendingEventModelState();
}

class _TrendingEventModelState extends State<TrendingEventModel> {

  List<Map<String, dynamic>> eventsList = [
    {
      "title": "Comic Con Co...",
      "location": "Coimbatore",
      "price": 999,
      "date": "Jan 01, 2026",
      "mode": "Online",
      "isPaid": true,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "AI Webinar",
      "location": "Coimbatore",
      "price": 199,
      "date": "Jan 01, 2026",
      "mode": "Online",
      "isPaid": false,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Startup Meetup",
      "location": "Bangalore",
      "price": 0,
      "date": "Feb 10, 2026",
      "mode": "Offline",
      "isPaid": false,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Music Fest 2026",
      "location": "Chennai",
      "price": 1499,
      "date": "Mar 15, 2026",
      "mode": "Offline",
      "isPaid": true,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Design Workshop",
      "location": "Hyderabad",
      "price": 499,
      "date": "Apr 05, 2026",
      "mode": "Online",
      "isPaid": true,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30,left: 16,right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Trending Events",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: "blMelody"
              ),),
              Container(
                padding: EdgeInsets.all(10),
                child: Text("See all",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(eventsList.length, (index){
              return Container(
                margin: EdgeInsets.only(right: 16,left: index == 0 ? 16 : 0,top: 15),
                width: 220,
                decoration: BoxDecoration(
                  color: MyColor().boxInnerClr,
                  borderRadius: BorderRadiusGeometry.circular(12),
                  border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: 130,
                        width: 220,
                        child: Image.network("https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",fit: BoxFit.fill,)),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("AI Webinar",style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),),
                              Icon(Icons.bookmark_border)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,size: 15,),
                                  SizedBox(width: 5,),
                                  Text("Coimbatore",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                  ),),
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(Icons.local_activity_outlined,size: 15,),
                                  SizedBox(width: 5,),
                                  Text("₹1999",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                  ),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_month,size: 15,),
                                  SizedBox(width: 5,),
                                  Text("Jan 01, 2026",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                        color: MyColor().greenClr,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Online",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                  ),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10,right: 10),
                      width: 52,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                          color: MyColor().primaryBackgroundClr,
                          border: Border.all(color: MyColor().primaryClr),
                          borderRadius: BorderRadiusGeometry.circular(40)
                      ),
                      child: Text("Paid",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                      )),
                    )

                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
