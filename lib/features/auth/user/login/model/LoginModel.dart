import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/ui/ForgotPasswordPage.dart';
import 'package:all_college_event_app/features/auth/user/login/bloc/googleSignInBloc/google_sign_in_bloc.dart';
import 'package:all_college_event_app/features/auth/user/login/bloc/login/login_bloc.dart';
import 'package:all_college_event_app/features/auth/user/signUp/ui/SignUpPage.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toastification/toastification.dart';

class LoginModel extends StatefulWidget {
  final String whichScreen;

  const LoginModel({super.key, required this.whichScreen});

  @override
  State<LoginModel> createState() => _LoginModelState();
}

class _LoginModelState extends State<LoginModel> {
  // Text Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final googleSignIn = GoogleSignIn(
    serverClientId: dotenv.env['CLIENT_ID'],
    scopes: ['email', 'profile'],
  );

  //Global key
  final formKey = GlobalKey<FormState>();

  // Password show & hide
  bool obscureTex = true;

  // Google Sign In Function
  void googleSignInFunction() async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        FlutterToast().flutterToast(
          "Google Sign In error",
          ToastificationType.error,
          ToastificationStyle.flat,
        );
        return;
      }

      final googleAuth = await user.authentication;
      final idToken = googleAuth.idToken;

      // -------- api controller -----------
      context.read<GoogleSignInBloc>().add(
        ClickGoogleSignIn(googleToken: idToken!),
      );

      // Get Google Token
      await googleSignIn.disconnect();

    } catch (e) {
      debugPrint("Google Sign In error $e");
    }
  }

  // ------- dispose ------
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImagePath().backgroundImg, fit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(ImagePath().authLoginImg),
                  ),
                  SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().loginUserHeadMsg,
                    style: TextStyle(
                      fontFamily: "blMelody",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().loginUserSubHeadMsg,
                    style: GoogleFonts.poppins(
                      fontSize: 14,color: MyColor().borderClr,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 25),
                  MyModels().customTextField(
                    label: "Email",
                    controller: emailController,
                    hintText: "Enter your mail id",
                    validator: Validators().validEmail,
                    textInputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    readOnly: false,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ForgotPasswordPage(whichScreen: 'user'),
                          ),
                        );
                      },
                      child: Container(
                        width: 320,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Login Button
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, loginState) {
                      if (loginState is LoginSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BottomNavigationBarPage(pageIndex: 0),
                          ),
                          (route) => false,
                        );
                        emailController.clear();
                        passwordController.clear();
                      } else if (loginState is LoginFail) {
                        FlutterToast().flutterToast(
                          loginState.errorMessage,
                          ToastificationType.error,
                          ToastificationStyle.flat,
                        );
                      }
                    },
                    builder: (context, loginState) {
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

                          onPressed:
                              emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty
                              ? () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                      ClickedLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        type: widget.whichScreen,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: loginState is LoginLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor().whiteClr,
                                  ),
                                )
                              : Text(
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
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 26,
                        child: Divider(color: MyColor().secondaryClr),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Or",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 26,
                        child: Divider(color: MyColor().secondaryClr),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Google SignIn
                  BlocConsumer<GoogleSignInBloc, GoogleSignInState>(
                    listener: (context, googleSignInState) {
                      if (googleSignInState is GoogleSignInSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BottomNavigationBarPage(pageIndex: 0),
                          ),
                          (route) => false,
                        );
                      } else if (googleSignInState is GoogleSignInFail) {
                        FlutterToast().flutterToast(
                          googleSignInState.errorMessage,
                          ToastificationType.error,
                          ToastificationStyle.flat,
                        );
                      }
                    },
                    builder: (context, googleSignInState) {
                      return Center(
                        child: GestureDetector(
                          onTap: googleSignInFunction,
                          child: Container(
                            alignment: Alignment.center,
                            height: 48,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImagePath().googleImg, height: 30),
                                const SizedBox(width: 10),
                                googleSignInState is GoogleSignInLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().primaryClr,
                                        ),
                                      )
                                    : Text(
                                        "Continue with Google",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                              ],
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
                      Text(
                        "Didn’t have an Account!?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SignUpPage(whichScreen: widget.whichScreen),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: MyColor().primaryClr,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
