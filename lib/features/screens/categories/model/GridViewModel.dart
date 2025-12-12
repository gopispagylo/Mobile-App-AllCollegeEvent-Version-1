import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridViewModel extends StatefulWidget {
  const GridViewModel({super.key});

  @override
  State<GridViewModel> createState() => _GridViewModelState();
}

class _GridViewModelState extends State<GridViewModel> {

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
        // Search Bar
        Center(
          child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 16,left: 16,right: 16),
              width: 380,
              child: TextFormField(
                onTapOutside: (onChanged){
                  WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                  ),
                  prefixIcon: Icon(Icons.search,size: 24,),
                  suffixIcon: GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColor().locationClr,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Icon(
                          Icons.tune,
                        ),
                      ),
                    ),
                  ),
                  hintText: "Search Events",
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: MyColor().hintTextClr
                  ),
                ),
              )),
        ),
        // GridView
        Expanded(child: Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: GridView.builder(
            itemCount: categoriesList.length,
            itemBuilder: (context,index){
              return Container(
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
            },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3)),
        )),
      ],
    );
  }
}
