import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordModel extends StatefulWidget {
  const ForgotPasswordModel({super.key});

  @override
  State<ForgotPasswordModel> createState() => _ForgotPasswordModelState();
}

class _ForgotPasswordModelState extends State<ForgotPasswordModel> {

  // Page Controller
  final pageController = PageController();

  // Initial Index
  int initialIndex = 0;

  // Text Input controllers
  final emailController = TextEditingController();
  final pinPutController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  // Password show & hide
  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Image.asset(ImagePath().backgroundImg, fit: BoxFit.contain),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 48),
                  child: Image.asset(ImagePath().authForgetImg),
                ),
                if(initialIndex != 3 )  Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      initialIndex == 2 ? "Set New Password" : "Forgot Password",
                      style: TextStyle(
                        fontFamily: "blMelody",
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      initialIndex == 2 ? "Must be at least 8 characters" : "No worries, we’ll send you a code to reset the password",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                   if(initialIndex != 2) SizedBox(height: 25),
                  ],
                ),

                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: pageController,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      onPageChanged: (onChanged){
                      setState(() {
                        initialIndex = onChanged;
                      });
                      },
                      itemBuilder: (context,index){
                        switch (index){
                          case 0:
                            return ListView(
                              children: [
                                MyModels().customTextField(
                                  label: "Email",
                                  controller: emailController,
                                  hintText: "Enter your mail id",
                                  errorText: "Please enter your mail id",
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(320, 48),
                                    elevation: 0,
                                    backgroundColor: MyColor().primaryClr,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    "Send Code",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColor().whiteClr,
                                    ),
                                  ),
                                ),

                              ],
                            );
                          case 1:
                            return ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Pinput(
                                      length: 4,
                                      controller: pinPutController,
                                      defaultPinTheme: PinTheme(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                              border: Border.all(color: MyColor().borderClr, width: 1)
                                          )
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: Validators().validPinPut,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(320, 48),
                                    elevation: 0,
                                    backgroundColor: MyColor().primaryClr,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    "Continue",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColor().whiteClr,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          case 2:
                            return ListView(
                              children: [
                                MyModels().customTextFieldPassword(
                                  label: "Password",
                                  controller: passwordController,
                                  hintText: "Enter your password",
                                  errorText: "Please enter your password",
                                  obscureText: obscureTexPassword,
                                  eyeIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureTexPassword = !obscureTexPassword;
                                      });
                                    },
                                    icon: !obscureTexPassword
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
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
                                    onPressed: () {
                                      setState(() {
                                        obscureTexConfirmPassword = !obscureTexConfirmPassword;
                                      });
                                    },
                                    icon: !obscureTexConfirmPassword
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(320, 48),
                                    elevation: 0,
                                    backgroundColor: MyColor().primaryClr,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    "Continue",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColor().whiteClr,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          case 3:
                            return ListView(
                              children: [
                               Text("Password Changed !",style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontFamily: "blMelody",
                                 fontSize: 30
                               ),)
                              ],
                            );
                          default:
                            return Container();
                        }
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index){
                    print("======================$initialIndex");
                    bool checkIndex = index == initialIndex;
                    final value = index + 1;
                    return Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 24,width: 24,
                      decoration: BoxDecoration(
                          border:Border.all(color: checkIndex ? MyColor().primaryClr : MyColor().borderClr),
                          color: checkIndex ? MyColor().primaryClr : MyColor().whiteClr,
                          shape: BoxShape.circle
                      ),
                      child: Text("$value",style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: checkIndex ? MyColor().whiteClr : MyColor().secondaryClr,
                          fontWeight: FontWeight.w400
                      ),),
                    );
                  }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
