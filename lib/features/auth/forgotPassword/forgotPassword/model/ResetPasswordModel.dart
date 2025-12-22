import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/resetPassword/reset_password_bloc.dart';
import 'package:all_college_event_app/features/auth/organizer/login/ui/OrganizerLoginPage.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordModel extends StatefulWidget {
  final String whichScreen;
  final String email;

  const ResetPasswordModel({super.key, required this.whichScreen, required this.email});

  @override
  State<ResetPasswordModel> createState() => _ResetPasswordModelState();
}

class _ResetPasswordModelState extends State<ResetPasswordModel> {


  // ------- Controllers ---------
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ----------- Global key for input field ---------
  final formKey = GlobalKey<FormState>();

  // ----------- Hide Password ---------
  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    print("whichScreenwhichScreenwhichScreenwhichScreen${widget.whichScreen}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ResetPasswordBloc(apiController: ApiController()),
  child: Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImagePath().backgroundImg, fit: BoxFit.cover),
          ),
          // ------ Text input field --------
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              children: [
                SizedBox(height: 32),
                widget.whichScreen == 'login'
                    ? Image.asset(ImagePath().authForgetImg)
                    : Image.asset(ImagePath().orgForgotImg),
                SizedBox(height: 20),
                Text(
                  "Forgot Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "No worries, we’ll send you a code to reset the password",
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
                      MyModels().customTextFieldPassword(
                        label: "Password",
                        controller: passwordController,
                        hintText: "Enter your password",
                        errorText: Validators().validPassword,
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
                        errorText: Validators().validConfirmPassword,
                        obscureText: obscureTexConfirmPassword,
                        eyeIcon: IconButton(
                          onPressed: () => setState(() => obscureTexConfirmPassword = !obscureTexConfirmPassword),
                          icon: Icon(
                            obscureTexConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                  listener: (context, resetPasswordState) {
                    if (resetPasswordState is ResetPasswordSuccess) {
                      MyModels().alertDialogContentCustom(context: context, content: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.tick_circle,color: MyColor().greenClr,),
                            SizedBox(height: 10,),
                            Container(
                              child: Text("Password Changed !",style: GoogleFonts.poppins(
                                fontSize: 18,fontWeight: FontWeight.w600,color: MyColor().blackClr
                              ),),
                            ),
                          ],
                        ),
                      ));

                        Future.delayed(Duration(milliseconds: 500),(){
                          if(widget.whichScreen == 'user'){
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage(whichScreen: 'user',)));
                          }else{
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> OrganizerLoginPage(whichScreen: 'org',)));
                          }
                        });

                    }
                    else if (resetPasswordState is ResetPasswordFail) {
                      FlutterToast().flutterToast(resetPasswordState.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                    }
                  },
                  builder: (context, resetPasswordState) {
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
                            context.read<ResetPasswordBloc>().add(
                              ClickedResetPassword(
                                email: widget.email,
                                password: confirmPasswordController.text
                              ),
                            );
                          }
                        },
                        child: resetPasswordState is ResetPasswordLoading
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
          ),
        ],
      ),
    ),
);
  }
}
