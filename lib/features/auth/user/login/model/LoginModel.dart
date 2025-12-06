import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/user/forgotPassword/ui/ForgotPasswordPage.dart';
import 'package:all_college_event_app/features/auth/user/signUp/ui/SignUpPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginModel extends StatefulWidget {
  const LoginModel({super.key});

  @override
  State<LoginModel> createState() => _LoginModelState();
}

class _LoginModelState extends State<LoginModel> {

  // Text Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Password show & hide
  bool obscureTex = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Image.asset(ImagePath().backgroundImg, fit: BoxFit.contain),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Image.asset(ImagePath().authLoginImg),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Welcome",
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Please login your account",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 25),
                MyModels().customTextField(
                  label: "Email",
                  controller: emailController,
                  hintText: "Enter your mail id",
                  errorText: "Please enter your mail id",
                ),
                SizedBox(height: 20),
                MyModels().customTextFieldPassword(
                  label: "Password",
                  controller: passwordController,
                  hintText: "Enter your password",
                  errorText: "Please enter your password",
                  obscureText: obscureTex,
                  eyeIcon: Container(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTex = !obscureTex;
                        });
                      },
                      icon: !obscureTex
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgotPasswordPage()));
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 12),
                    child: Text("Forgot Password?",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
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
                  onPressed: () {},
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MyColor().whiteClr,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 26,
                      child: Divider(
                        color: MyColor().secondaryClr,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Or",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),),
                    ),
                    SizedBox(
                      width: 26,
                      child: Divider(
                        color: MyColor().secondaryClr,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400,width: 0.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath().googleImg,height: 30,),
                      const SizedBox(width: 10,),
                      Text("Continue with Google",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn’t have an Account!?",style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpPage()));
                      },
                      child: Text("Sign Up",style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: MyColor().primaryClr,
                        fontWeight: FontWeight.w600
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
