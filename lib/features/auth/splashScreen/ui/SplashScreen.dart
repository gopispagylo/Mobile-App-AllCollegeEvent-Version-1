import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/features/auth/splashScreen/ui/OnboardingScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double size = 50;

  @override
  void initState() {
    super.initState();
    delayAnimation();
  }

  // delay work animation
  void delayAnimation() async{
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      size = MediaQuery.of(context).size.longestSide * 2;
    });
    await Future.delayed(Duration(milliseconds: 2200));
    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => CheckUserPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(end: Offset.zero,begin: Offset(1, 0)).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween),child: child,);
    },transitionDuration: Duration(milliseconds: 400)

    ), (route) => false,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.bottomRight,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 3000),
              height: size,
              width: size,
              decoration: BoxDecoration(
                  color: Color(0xff7F00FF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(1000))
                // shape: BoxShape.circle
              ),
            ),
          ),
        ],
      ),
    );
  }
}
