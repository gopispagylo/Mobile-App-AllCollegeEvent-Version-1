import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreenModel extends StatefulWidget {
  const SplashScreenModel({super.key});

  @override
  State<SplashScreenModel> createState() => _SplashScreenModelState();
}

class _SplashScreenModelState extends State<SplashScreenModel> {

  // ------- Page Controller --------
  final pageController = PageController();

  // -------- initial index -------
  int initialIndex = 0;

  final List<Map<String, String>> eventList = [
    {
      "image": "assets/image/splash_screen_3.png",
      "title": "Discover Every Event",
      "description": "Events for all — academic, corporate, creative, cultural, and professional.",
    },
    {
      "image": "assets/image/splash_screen_1.png",
      "title": "Create Events Easily",
      "description": "Publish your event in minutes with simple and powerful tools.",
    },
    {
      "image": "assets/image/splash_screen_1.png",
      "title": "Join & Participate",
      "description": "Register quickly, get reminders, and never miss an opportunity.",
    },
  ];

  // ---------- Next page function --------
  void nextPage() {
    if(initialIndex < eventList.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CheckUserPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: eventList.length,
                  onPageChanged: (onChanged) {
                    setState(() {
                      initialIndex = onChanged;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(eventList[index]['image']!),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            eventList[index]['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              fontFamily: "blMelody",
                              color: MyColor().blackClr,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            textAlign: TextAlign.center,
                            eventList[index]['description']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: MyColor().blackClr,
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     openGmailInbox();
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.all(16),
                        //     margin: EdgeInsets.only(top: 30),
                        //       decoration: BoxDecoration(
                        //         color: MyColor().primaryClr
                        //       ),
                        //       child: Text('Open Gmail',style: GoogleFonts.poppins(
                        //         fontSize: 16,fontWeight: FontWeight.w500,color: MyColor().whiteClr
                        //       ),)),
                        // )
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final checkIndex = initialIndex == index;
                    return Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 10,
                      width: checkIndex ? 20 : 10,
                      decoration: BoxDecoration(
                        color: checkIndex
                            ? MyColor().primaryClr
                            : MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: checkIndex
                              ? MyColor().primaryClr
                              : MyColor().borderClr.withOpacity(0.15),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: initialIndex != eventList.length - 1 ?  FloatingActionButton(
          elevation: 0,
          onPressed: nextPage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: MyColor().primaryClr,
          child: Icon(Icons.arrow_forward_ios,color: MyColor().whiteClr,size: 20,),
        )
            : GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CheckUserPage()));
          },
          child: Container(
            decoration: BoxDecoration(color: MyColor().primaryClr,borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Get Started",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColor().whiteClr
                  ),),
                  Icon(Icons.arrow_forward_ios,color: MyColor().whiteClr,size: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
