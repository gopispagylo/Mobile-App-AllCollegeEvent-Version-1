import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class OnboardingScreenModel extends StatefulWidget {
  const OnboardingScreenModel({super.key});

  @override
  State<OnboardingScreenModel> createState() => _OnboardingScreenModelState();
}

class _OnboardingScreenModelState extends State<OnboardingScreenModel> with SingleTickerProviderStateMixin {

  // ------- Page Controller --------
  final pageController = PageController();

  // -------- initial index -------
  int initialIndex = 0;

  // -------- animation ------
  Offset offsetRightSide = Offset(1, 0);
  Offset offsetBottom = Offset(0, 2);

  late AnimationController animatedContainer;
  late Animation<double> scale;

  double opacity = 0;


  final List<Map<String, String>> eventList = [
    {
      "image": ImagePath().splashScreenFirst,
      "title": "Discover Every Event",
      "description": "Events for all — academic, corporate, creative, cultural, and professional.",
    },
    {
      "image": ImagePath().splashScreenTSecond,
      "title": "Create Events Easily",
      "description": "Publish your event in minutes with simple and powerful tools.",
    },
    {
      "image": ImagePath().splashScreenThird,
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
  void initState() {
    super.initState();
    animatedContainer = AnimationController(vsync: this,duration: Duration(milliseconds: 700));
    scale = Tween<double>(begin: 0.1, end: 1).animate(
        CurvedAnimation(parent: animatedContainer, curve: Curves.easeInOut));
    playAnimation();
  }


  void playAnimation() {
    animatedContainer.reset();

    setState(() {
      offsetRightSide = const Offset(1, 0);
      offsetBottom = const Offset(0, 2);
      opacity = 0;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      animatedContainer.forward();
      setState(() {
        offsetRightSide = Offset.zero;
        offsetBottom = Offset.zero;
        opacity = 1;
      });
    });
  }

  @override
  void dispose() {
    animatedContainer.dispose();
    super.dispose();
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
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (onChanged) {
                    setState(() {
                      initialIndex = onChanged;
                    });
                    // playAnimation();
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScaleTransition(scale: scale,
                        child: Image.asset(eventList[index]['image']!)),
                        SizedBox(height: 10),
                        AnimatedOpacity(
                          opacity: opacity,
                           curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 700),
                          child: AnimatedSlide(
                            offset: offsetBottom, duration: Duration(milliseconds: 700),
                            child: Column(
                              children: [
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
                                Container(
                                  margin: EdgeInsets.only(left: 16, right: 16,top: 10),
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
                              ],
                            ),
                          ),
                        )
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
        floatingActionButton: initialIndex != eventList.length - 1 ?  AnimatedSlide(
          duration: Duration(milliseconds: 700),
          offset: offsetRightSide,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: nextPage,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: MyColor().primaryClr,
            child: Icon(Icons.arrow_forward_ios,color: MyColor().whiteClr,size: 20,),
          ),
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
