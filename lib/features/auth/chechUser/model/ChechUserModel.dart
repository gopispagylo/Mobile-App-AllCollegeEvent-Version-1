import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/features/auth/organizer/login/ui/OrganizerLoginPage.dart';
import 'package:all_college_event_app/features/auth/user/login/ui/LoginPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckUserModel extends StatefulWidget {
  const CheckUserModel({super.key});

  @override
  State<CheckUserModel> createState() => _CheckUserModelState();
}

class _CheckUserModelState extends State<CheckUserModel> {


  // Which user list
  final List<Map<String,dynamic>> whichUser = [
    {"role" : "User"},{"role" : "Organizer"}
  ];

  // Selected user assign value
  String? selectUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(
              ImagePath().backgroundImg, fit: BoxFit.contain,)),
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
                    ConfigMessage().checkUserHeadMsg, style: TextStyle(
                      fontFamily: "blMelody",
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),),
                  Text(
                    textAlign: TextAlign.center,
                    ConfigMessage().checkUserSubHeadMsg, style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 30,),
                  Center(
                    child: Container(
                      width: 320,
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(whichUser.length, (index) {
                          final role = whichUser[index]['role'];
                          return Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectUser = role;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: index == 0 ? 20 : 10),
                                  padding: EdgeInsets.all(40),
                                  decoration: BoxDecoration(
                                      color: selectUser == role ? MyColor().primaryClr : MyColor().boxInnerClr,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: selectUser == role ? MyColor().primaryClr : MyColor().borderClr)
                                  ),
                                  child: Text(role,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectUser == role ? MyColor().whiteClr : MyColor().blackClr
                                    ),)),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(320, 48),
                            elevation: 0,
                            backgroundColor: MyColor().primaryClr,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(50)
                            )
                        ),
                        onPressed: selectUser != null ? ()async{

                          // ------- initial delete ---------
                          await DBHelper().deleteUser();
                            print("InitialInsertTheUserValue");
                            // ------ insert user -------------
                            await DBHelper().insertUser(selectUser!);

                          if(selectUser == 'User'){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage(whichScreen: 'user',)));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizerLoginPage(whichScreen: 'org',)));
                          }


                        } : null, child: Text("Continue",style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyColor().whiteClr
                    ),)),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
