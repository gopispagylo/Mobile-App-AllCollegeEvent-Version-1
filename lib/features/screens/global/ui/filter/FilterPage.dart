import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  // ----------- Status --------
  List<Map<String, dynamic>> statusList = [
    {'title': 'All', 'value': false},
    {'title': 'Trending', 'value': false},
    {'title': 'Ongoing', 'value': false},
    {'title': 'Upcoming', 'value': false},
  ];

  // -------- Mode list ----------
  List<Map<String, dynamic>> modeList = [
    {'title': 'Offline'},
    {'title': 'Online'},
    {'title': 'Hybrid'},
  ];

  String? selectedMode;

  // ----------- Certification ----------
  List<Map<String, dynamic>> certificationList = [
    {'title': 'All Participants', 'value': false},
    {'title': 'No Price', 'value': false},
    {'title': 'Not Provided', 'value': false},
  ];

  // ------------- Perks ---------------
  List<Map<String, dynamic>> perksList = [
    {'title': 'Certificates', 'value': false},
    {'title': 'Medal', 'value': false},
    {'title': 'Awards', 'value': false},
  ];

  // ---------- Types of Categories ----------
  List<Map<String, dynamic>> categoryList = [
    {'title': 'Entertainment', 'value': false},
    {'title': 'Networking', 'value': false},
    {'title': 'Education', 'value': false},
    {'title': 'Sports', 'value': false},
    {'title': 'Others', 'value': false},
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        centerTitle: true,
        title: Text("Filter",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      body: Container(
        child: ListView(
          children: [

            // --------- status ---------
            Container(
                margin: EdgeInsets.only(left: 16),
                child: Text("Status",style: GoogleFonts.poppins(
                  fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(statusList.length, (index){
                  return Row(
                    children: [
                      Checkbox(value: statusList[index]['value'], onChanged: (onChanged){
                        setState(() {
                          statusList[index]['value'] = onChanged;
                        });
                      }),
                      Text(statusList[index]['title'])
                    ],
                  );
                }),
              ),
            ),

            SizedBox(height: 10,),

            // ----- mode --------
            Container(
                margin: EdgeInsets.only(left: 16),
                child: Text("Mode",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(modeList.length, (index){
                  return Row(
                    children: [
                      Radio(groupValue: selectedMode,value: modeList[index]['title'],onChanged: (onChanged){
                        setState(() {
                          selectedMode = onChanged;
                        });
                      },),
                      Text(modeList[index]['title'])
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
