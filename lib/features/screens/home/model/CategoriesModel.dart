import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCategoriesModel extends StatefulWidget {
  const HomeCategoriesModel({super.key});

  @override
  State<HomeCategoriesModel> createState() => _HomeCategoriesModelState();
}

class _HomeCategoriesModelState extends State<HomeCategoriesModel> {

  List<Map<String, dynamic>> categoriesList = [
    {
      "title": "Hackathon",
      "image": "assets/images/hackathon.png",
      "bgColor": 0xFFE7F7FF,
    },
    {
      "title": "Conference",
      "image": "assets/images/conference.png",
      "bgColor": 0xFFFDF1DC,
    },
    {
      "title": "Athletics",
      "image": "assets/images/athletics.png",
      "bgColor": 0xFFFFE8E8,
    },
    {
      "title": "Competition",
      "image": "assets/images/competition.png",
      "bgColor": 0xFFF4EAFF,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30,left: 16,right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pick Your Vibe!",style: TextStyle(
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
            children: List.generate(categoriesList.length, (index) {
              return Container(
                margin: EdgeInsets.only(left: 16,right: index == categoriesList.length - 1 ? 16 : 0,top: 15),
                height: 104,
                width: 104,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(categoriesList[index]['bgColor'])
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note),
                      Text(categoriesList[index]['title'],overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),),
                    ],
                  ),
                ),
              );
            },),
          ),
        )
      ],
    );
  }
}
