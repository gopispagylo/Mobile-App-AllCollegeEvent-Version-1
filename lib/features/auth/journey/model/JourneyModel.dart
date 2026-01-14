import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyModel extends StatefulWidget {
  const JourneyModel({super.key});

  @override
  State<JourneyModel> createState() => _JourneyModelState();
}

class _JourneyModelState extends State<JourneyModel> {


  List<Map<String, dynamic>> userTypes = [
    {"title": "Student", "icon": Icons.one_k, "color" : MyColor().blueClr,},
    {"title": "Faculty", "icon": Icons.one_k, "color" : MyColor().primaryClr,},
    {"title": "Professional", "icon": Icons.one_k, "color" : MyColor().yellowClr,},
    {"title": "General User", "icon": Icons.one_k, "color" : MyColor().redClr,},
  ];


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(
          ImagePath().backgroundImg, fit: BoxFit.cover,)),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Image.asset(ImagePath().yourJourneyImg),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().journeyVibe, style: TextStyle(
                      fontFamily: "blMelody",
                      fontSize: 18,
                      color: MyColor().primaryClr,
                      fontWeight: FontWeight.w500
                  ),),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().journey, style: TextStyle(
                      fontFamily: "blMelody",
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(height: 8,),
              Text(
                textAlign: TextAlign.center,
                ConfigMessage().clickAndEnjoy, style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: MyColor().borderClr,
                  fontWeight: FontWeight.w500
              ),),
              Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                    itemCount: userTypes.length,
                    itemBuilder: (context,index){
                      final usersType = userTypes[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: usersType['color'].withOpacity(0.10),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: usersType['color'],width: 0.5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(usersType['icon']),
                            Text(usersType['title']),
                          ],
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 30,crossAxisSpacing: 30,childAspectRatio: 1.5)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
