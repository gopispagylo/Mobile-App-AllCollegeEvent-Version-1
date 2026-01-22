import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/features/auth/user/signUp/bloc/signUp/sign_up_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class SignUpModel extends StatefulWidget {
  final String whichScreen;

  const SignUpModel({super.key, required this.whichScreen});

  @override
  State<SignUpModel> createState() => _SignUpModelState();
}

class _SignUpModelState extends State<SignUpModel> {

  // Text Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  // Password show & hide
  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;

  // Global Key
  final formKey = GlobalKey<FormState>();


  // ------ dispose after using controller --------
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(
            ImagePath().backgroundImg, fit: BoxFit.cover)),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 250,
                  child: Image.asset(ImagePath().authSignupImg),
                ),
                SizedBox(height: 20,),
                Text(
                  textAlign: TextAlign.center,
                  ConfigMessage().signUpUserHeadMsg,
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  ConfigMessage().signUpUserSubHeadMsg,
                  style: GoogleFonts.poppins(
                    fontSize: 14,color: MyColor().borderClr,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 25),
                MyModels().customTextField(
                  label: "Name",
                  controller: nameController,
                  hintText: "Enter your name",
                  validator: Validators().validName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false,
                ),
                SizedBox(height: 20),
                MyModels().customTextField(
                  label: "Email",
                  controller: emailController,
                  hintText: "Enter your mail id",
                  validator: Validators().validEmail, textInputType: TextInputType.text, textCapitalization: TextCapitalization.none, readOnly: false,
                ),
                SizedBox(height: 20),
                MyModels().customTextFieldPassword(
                  label: "Password",
                  controller: passwordController,
                  hintText: "Enter your password",
                  errorText: Validators().validPassword,
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
                  errorText: Validators().validConfirmPassword,
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
                BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, signUpState) {
                    if(signUpState is SignUpSuccess){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage(whichScreen: widget.whichScreen,)));
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    }else if(signUpState is SignUpFail){
                      FlutterToast().flutterToast(signUpState.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                    }
                  },
                  builder: (context, signUpState) {
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
                          if(formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              context.read<SignUpBloc>().add(ClickedSignUp(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  type: widget.whichScreen));
                            } else {
                              FlutterToast().flutterToast(
                                  "Password doesn`t match",
                                  ToastificationType.error,
                                  ToastificationStyle.flat);
                            }
                          }
                        },
                        child: signUpState is SignUpLoading ? Center(child: CircularProgressIndicator(color: MyColor().whiteClr,),) : Text(
                          "Sign up",
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
                      child: Text("Or", style: GoogleFonts.poppins(
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
                Center(
                  child: Container(
                    height: 48,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey.shade400, width: 0.5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath().googleImg, height: 30,),
                        const SizedBox(width: 10,),
                        Text("Continue with Google", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                        )
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account!?", style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Sign In", style: GoogleFonts.poppins(
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
    );
  }
}
