import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AreYouPage extends StatefulWidget {
  final String whichScreen;

  const AreYouPage({super.key, required this.whichScreen});
  @override
  State<AreYouPage> createState() => _AreYouPageState();
}

class _AreYouPageState extends State<AreYouPage> {
  // list of who you are?
  final List<Map<String, dynamic>> areYouList = [
    {"name": "Student", "icon": Icons.cast_for_education, "color": 0xff46A6F4},
    {"name": "Faculty", "icon": Icons.face, "color": 0xff7F00FF},
    {"name": "Professional", "icon": Iconsax.briefcase, "color": 0xffFB9D10},
    {
      "name": "General User",
      "icon": Iconsax.profile_2user,
      "color": 0xffFF0000,
    },
  ];

  // select the value of are you
  String? selectTheAreYou = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImagePath().backgroundImg, fit: BoxFit.cover),
          ),
          ListView(
            children: [
              SizedBox(
                height: 250,
                child: Image.asset(ImagePath().authLoginImg),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Select your vibe!",
                      style: TextStyle(
                        fontFamily: "blMelody",
                        fontSize: 18,
                        color: MyColor().primaryClr,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      " Start your journey!",
                      style: TextStyle(
                        fontFamily: "blMelody",
                        fontSize: 18,
                        color: MyColor().blackClr,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  textAlign: TextAlign.center,
                  "Click & enjoy your events vibe !",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: MyColor().borderClr,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // ------- list of users ----------
              Container(
                margin: EdgeInsets.all(30),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: areYouList.length,
                  itemBuilder: (context, index) {
                    final clickCard = selectTheAreYou!.contains(
                      areYouList[index]['name'],
                    );
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: Color(
                        areYouList[index]['color'],
                      ).withValues(alpha: 0.4),
                      onTap: () {
                        setState(() {
                          selectTheAreYou = areYouList[index]['name'];
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BottomNavigationBarPage(
                              pageIndex: 0,
                              whichScreen: widget.whichScreen,
                              isLogin: true,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(
                            areYouList[index]['color'],
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: clickCard
                                ? Color(areYouList[index]['color'])
                                : MyColor().borderClr.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(areYouList[index]['icon']),
                            SizedBox(height: 5),
                            Text(
                              areYouList[index]['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.3,
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
