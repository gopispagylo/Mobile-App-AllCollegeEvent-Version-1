import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountCreationModel extends StatefulWidget {
  const AccountCreationModel({super.key});

  @override
  State<AccountCreationModel> createState() => _AccountCreationModelState();
}

class _AccountCreationModelState extends State<AccountCreationModel> {

  // ------ Controller ------
  final domainMailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Global Key
  final formKey = GlobalKey<FormState>();


  bool obscureTexPassword = true;
  bool obscureTexConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(
            ImagePath().backgroundImg, fit: BoxFit.contain)),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                // ------ TabBar --------
                Container(
                  margin: EdgeInsets.only(top: 20,left: 16,right: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.menu,color: MyColor().blackClr,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nCategory",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person,size: 18,color: MyColor().blackClr,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nDetails",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().primaryBackgroundClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().primaryClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.check_circle_outline,size: 18,color: MyColor().primaryClr,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Account\nCreation",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Image.asset(ImagePath().orgSignUpImg),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Account Creation",
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 25),
                // ------ Organization Name --------
                MyModels().customTextField(
                  label: "Domain Email",
                  controller: domainMailController,
                  hintText: "Enter your Domain",
                  validator: Validators().validName,
                ),
                SizedBox(height: 20),
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
                // -------- Button ----------
                Center(
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
                      // if(formKey.currentState!.validate()){
                      //   context.read<SignUpBloc>().add(ClickedSignUp(name: nameController.text, email: emailController.text, password: passwordController.text, type: widget.whichScreen));
                      // }
                    },
                    child: Text(
                      "Verify your Domain",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyColor().whiteClr,
                      ),
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
                        Navigator.pop(context);
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
