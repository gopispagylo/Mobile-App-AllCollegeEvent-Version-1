import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/ui/ForgotPasswordPage.dart';
import 'package:all_college_event_app/features/auth/organizer/login/bloc/orgLogin/org_login_bloc.dart';
import 'package:all_college_event_app/features/auth/organizer/signUp/ui/OrgSignUpPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizerLoginModel extends StatefulWidget {
  final String whichScreen;

  const OrganizerLoginModel({super.key, required this.whichScreen});

  @override
  State<OrganizerLoginModel> createState() => _OrganizerLoginModelState();
}

class _OrganizerLoginModelState extends State<OrganizerLoginModel> {


  // Text Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Password show & hide
  bool obscureTex = true;

  // Global Key
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(ImagePath().backgroundImg, fit: BoxFit.contain)),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Image.asset(ImagePath().orgLoginImg),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().loginOrgHeadMsg,
                    style: TextStyle(
                      fontFamily: "blMelody",
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().loginOrgSubHeadMsg,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 25),
                  MyModels().customTextField(
                    label: "Domain Mail ID",
                    controller: emailController,
                    hintText: "Enter your domain mail id",
                    validator: Validators().validDomainMail,
                  ),
                  SizedBox(height: 20),
                  MyModels().customTextFieldPassword(
                    label: "Password",
                    controller: passwordController,
                    hintText: "Enter your password",
                    errorText: Validators().validPassword,
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
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgotPasswordPage(whichScreen: 'organizerLogin',)));
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        width: 320,
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Forgot Password?",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocConsumer<OrgLoginBloc, OrgLoginState>(
  listener: (context, orgLoginState) {
    if(orgLoginState is OrgSuccess){
      emailController.clear();
      passwordController.clear();
      print("OrgSuccessOrgSuccessOrgSuccessOrgSuccessOrgSuccess");
    }else if(orgLoginState is OrgFail){
      print("OrgFailOrgFailOrgFailOrgFailOrgFailOrgFail");
    }
  },
  builder: (context, orgLoginState) {
    return Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(320, 48),
                        elevation: 0,
                        backgroundColor: MyColor().primaryClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(50),
                        ),
                      ),
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          context.read<OrgLoginBloc>().add(ClickedOrgLogin(email: emailController.text, password: passwordController.text, type: widget.whichScreen));
                        }
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MyColor().whiteClr,
                        ),
                      ),
                    ),
                  );
  },
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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> OrgSignUpPage()));
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
          ),
        ],
      ),
    );
  }
}
