import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/bloc/verifyOtp/verify_otp_bloc.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/model/ResetPasswordModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

class OtpVerifyModel extends StatefulWidget {
  final String whichScreen;
  final String email;

  const OtpVerifyModel({
    super.key,
    required this.whichScreen,
    required this.email,
  });

  @override
  State<OtpVerifyModel> createState() => _OtpVerifyModelState();
}

class _OtpVerifyModelState extends State<OtpVerifyModel> {
  // -------- Controller -----------
  final pinPutController = TextEditingController();

  // ----------- Global key for input field ---------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VerifyOtpBloc(apiController: ApiController()),
        ),
      ],
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
                              border: Border.all(
                                color: MyColor().borderClr,
                                width: 0.5,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          focusedPinTheme: PinTheme(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(
                                color: MyColor().primaryClr,
                                width: 0.5,
                              ),
                            ),
                          ),
                          onTapUpOutside: (outSideTab) {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                ?.unfocus();
                          },
                          validator: Validators().validPinPut,
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                    listener: (context, verifyOtpState) {
                      if (verifyOtpState is VerifyOtpSuccess) {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ResetPasswordModel(whichScreen: widget.whichScreen, email: widget.email,)));
                      } else if (verifyOtpState is VerifyOtpFail) {
                        FlutterToast().flutterToast(verifyOtpState.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                      }
                    },
                    builder: (context, verifyOtpState) {
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
                            context.read<VerifyOtpBloc>().add(
                              ClickedVerifyOtp(
                                email: widget.email,
                                otp: pinPutController.text,
                              ),
                            );
                          }
                          },
                          child: verifyOtpState is VerifyOtpLoading
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
