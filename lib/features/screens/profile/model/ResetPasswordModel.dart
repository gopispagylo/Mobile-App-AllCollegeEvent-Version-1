import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordModel extends StatefulWidget {
  const ResetPasswordModel({super.key});

  @override
  State<ResetPasswordModel> createState() => _ResetPasswordModelState();
}

class _ResetPasswordModelState extends State<ResetPasswordModel> {


  // ----------- Controller --------
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  // ----------- Password Hide and Show -----------
  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Set Your Password",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            MyModels().customTextFieldPassword(
              label: "New Password",
              controller: passwordController,
              hintText: "Enter your new password",
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
                onPressed: () => setState(
                        () => obscureTexConfirmPassword = !obscureTexConfirmPassword),
                icon: Icon(
                  obscureTexConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
        SizedBox(height: 30,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(320, 48),
            backgroundColor: MyColor().primaryClr,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: (){

            // ---- Success Dialog -----
            MyModels().alertDialogContentCustom(context: context, content: Container(
              color: MyColor().boxInnerClr,
              child: Text(textAlign: TextAlign.center,"Password Successfully Changed!!",style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MyColor().blackClr
              ),),
            ));

            // ---- after showing completed the dialog then back to profile page ----
            Future.delayed(Duration(milliseconds: 1000),(){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            });

          },
          child: Text(
            "Save Changes",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyColor().whiteClr,
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}

// ------------ Password Success ----------

