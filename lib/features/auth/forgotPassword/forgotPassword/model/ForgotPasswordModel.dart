import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordModel extends StatefulWidget {
  final String whichScreen;

  const ForgotPasswordModel({super.key, required this.whichScreen});

  @override
  State<ForgotPasswordModel> createState() => _ForgotPasswordModelState();
}

class _ForgotPasswordModelState extends State<ForgotPasswordModel> {
  final pageController = PageController();
  int initialIndex = 0;

  final emailController = TextEditingController();
  final pinPutController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;

  //Global key for input field
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImagePath().backgroundImg,
              fit: BoxFit.cover,
            ),
          ),
          PageView.builder(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            onPageChanged: (value) => setState(() => initialIndex = value),
            itemBuilder: (context, index) {
              return Container(margin: EdgeInsets.only(left: 16,right: 16,top: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      widget.whichScreen == 'login'
                          ? Image.asset(ImagePath().authForgetImg)
                          : Image.asset(ImagePath().orgForgotImg),

                      if (index != 3) ...[
                        SizedBox(height: 20),
                        Text(
                          index == 2 ? "Set New Password" : "Forgot Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "blMelody",
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          index == 2
                              ? "Must be at least 8 characters"
                              : "We will send you a code to reset your password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 25),
                      ],

                      buildPage(index),   // Your content
                      SizedBox(height: 20),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          bool active = index == initialIndex;
                          return Container(
                            margin: EdgeInsets.all(8),
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active ? MyColor().primaryClr : MyColor()
                                  .whiteClr,
                              border: Border.all(color: active
                                  ? MyColor().primaryClr
                                  : MyColor().borderClr),),
                            alignment: Alignment.center,
                            child: Text(
                              "${index + 1}", style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: active ? MyColor().whiteClr : MyColor()
                                  .secondaryClr,),),);
                        }),), SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // Page Builder UI
  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            MyModels().customTextField(
              label: widget.whichScreen == 'login' ? "Email" : "Domain Mail ID",
              controller: emailController,
              hintText: widget.whichScreen == 'login' ? "Enter your mail id" : "Enter your domain mail id" ,
              errorText: widget.whichScreen == 'login' ? "Please enter your mail id" : "Please enter your mail id",
            ),
            SizedBox(height: 30),
            Center(
              child: buildButton("Send Code", () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ),
          ],
        );

      case 1:
        return Column(
          children: [
            SizedBox(height: 10),
            Pinput(
              length: 4,
              controller: pinPutController,
              scrollPadding: EdgeInsets.only(bottom: 65),
              defaultPinTheme: PinTheme(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: MyColor().borderClr,width: 0.5),
                ),
              ),
              keyboardType: TextInputType.number,
              focusedPinTheme: PinTheme(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: MyColor().primaryClr,width: 0.5),
              )),
              onTapUpOutside: (outSideTab){
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              validator: Validators().validPinPut,
            ),
            SizedBox(height: 30),
            Center(
              child: buildButton("Continue", () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ),
          ],
        );

      case 2:
        return Column(
          children: [
            MyModels().customTextFieldPassword(
              label: "Password",
              controller: passwordController,
              hintText: "Enter your password",
              errorText: "Please enter your password",
              obscureText: obscureTexPassword,
              eyeIcon: IconButton(
                onPressed: () =>
                    setState(() => obscureTexPassword = !obscureTexPassword),
                icon: Icon(
                  obscureTexPassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            SizedBox(height: 20),
            MyModels().customTextFieldPassword(
              label: "Confirm Password",
              controller: confirmPasswordController,
              hintText: "Enter your confirm password",
              errorText: "Please enter your confirm password",
              obscureText: obscureTexConfirmPassword,
              eyeIcon: IconButton(
                onPressed: () => setState(
                        () => obscureTexConfirmPassword = !obscureTexConfirmPassword),
                icon: Icon(
                  obscureTexConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: buildButton("Continue", () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ),
            SizedBox(height: 30),
          ],
        );

      case 3:
        return Container(
          margin: EdgeInsets.only(top: 100),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              "Password Changed!",
              style: TextStyle(
                fontFamily: "blMelody",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );


      default:
        return SizedBox();
    }
  }

  // Button UI
  Widget buildButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(320, 48),
        backgroundColor: MyColor().primaryClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: MyColor().whiteClr,
        ),
      ),
    );
  }

}
