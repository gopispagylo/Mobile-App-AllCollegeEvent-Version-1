import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/forgotPasswordBloc/forgot_password_bloc.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/model/OtpVerifyModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordModel extends StatefulWidget {
  final String whichScreen;

  const ForgotPasswordModel({super.key, required this.whichScreen});

  @override
  State<ForgotPasswordModel> createState() => _ForgotPasswordModelState();
}

class _ForgotPasswordModelState extends State<ForgotPasswordModel> {

  // ------- Controller --------
  final emailController = TextEditingController();


  // ----------- Global key for input field ---------
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
          ListView(
            children: [
              SizedBox(height: 32),
              widget.whichScreen == 'user'
                  ? Image.asset(ImagePath().authForgetImg,height: 250,)
                  : Image.asset(ImagePath().orgForgotImg,height: 250,),
              SizedBox(height: 20),
              Text(
                // index == 2 ? "Set New Password" :
                "Forgot Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "blMelody",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                // index == 2
                //     ? "Must be at least 8 characters"
                "We will send you a code to reset your password",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 25),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyModels().customTextField(
                      label: widget.whichScreen == 'user' ? "Email" : "Domain Mail ID",
                      controller: emailController,
                      hintText: widget.whichScreen == 'user' ? "Enter your mail id" : "Enter your domain mail id" ,
                      validator: widget.whichScreen == 'user' ? Validators().validEmail : Validators().validDomainMail, textInputType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none, readOnly: false,
                    ),

                    SizedBox(height: 30),
                    BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                      listener: (context, forgotPasswordState) {
                        if(forgotPasswordState is ForgotPasswordSuccess){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> OtpVerifyModel(whichScreen: widget.whichScreen, email: emailController.text,)));
                        }else if(forgotPasswordState is ForgotPasswordFail){
                          FlutterToast().flutterToast(forgotPasswordState.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                        }
                      },
                      builder: (context, forgotPasswordState) {
                        // return forgotPasswordState is ForgotPasswordLoading ? Center(child: CircularProgressIndicator(color: MyColor().whiteClr,),) :
                        // Center(
                        //   child: buildButton("Send Code", () {
                        //     if(formKey.currentState!.validate()){
                        //       print("sdkjhsdjfhsdjkfhskjfhsdjfhsdjkshdjksdhjh");
                        //     }
                        //   }),
                        // );
                        //

                        return Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(320, 48),
                              backgroundColor: MyColor().primaryClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                context.read<ForgotPasswordBloc>().add(ClickedSendMail(email: emailController.text));
                              }
                            },
                            child: forgotPasswordState is ForgotPasswordLoading
                                ? Center(
                              child: CircularProgressIndicator(
                                color: MyColor().whiteClr,
                              ),
                            )
                                : Text(
                              "Continue",
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
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Page Builder UI
  Widget buildPage(int index) {
    switch (index) {

      case 2:
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              // Center(
              //   child: buildButton("Continue", () {
              //     pageController.nextPage(
              //       duration: Duration(milliseconds: 300),
              //       curve: Curves.easeInOut,
              //     );
              //   }),
              // ),
              SizedBox(height: 30),
            ],
          ),
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
}
