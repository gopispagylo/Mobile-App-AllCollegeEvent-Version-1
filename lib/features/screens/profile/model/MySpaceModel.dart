import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/features/screens/profile/model/MyEventsModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/OrganizationCreateDetailPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MySpaceModel extends StatefulWidget {
  final String whichScreen;

  const MySpaceModel({super.key, required this.whichScreen});

  @override
  State<MySpaceModel> createState() => _MySpaceModelState();
}

class _MySpaceModelState extends State<MySpaceModel> {

  // ------- Check Box Value ------
  bool checkNotification = false;
  bool checkEmailSetting = false;

  // ---------- Controller ------
  final deleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // ---------- access the value of whichScreen ---------
    final checkUser = widget.whichScreen == 'User';

    return Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- only visible for organizer ----------
         Visibility(
           visible: !checkUser,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 child: Text("My Space",style: GoogleFonts.poppins(
                     fontSize: 18,
                     fontWeight: FontWeight.w600,
                     color: MyColor().blackClr
                 ),),
               ),
               SizedBox(height: 10,),
               GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationCreateDetailPage()));
                   },
                   child: customContainer(name: "Create Your Event", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)))),
               customContainer(name: "Dashboard", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(0))),
               GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> MyEventsModel()));
                   },
                   child: customContainer(name: "My Events", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)))),
               SizedBox(height: 24,),
             ],
           ),
         ),

         if(!checkUser) Container(
            child: Text("Settings",style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MyColor().blackClr
            ),),
          ),
          SizedBox(height: 10,),
          customCheckBox(name: 'Notifications', borderRadius: checkUser ? BorderRadius.circular(12) : BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)), value: checkNotification, onChanged: (value) {
            setState(() {
              checkNotification = value;
            });
          }),

          // ----- only visible for organizer ----------
        if(!checkUser)  customCheckBox(name: 'Email Settings', borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)), value: checkEmailSetting, onChanged: (value) {
            setState(() {
              checkEmailSetting = value;
            });
          }),
          SizedBox(height: 24,),
          Container(
            child: Text("Account Manage",style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MyColor().blackClr
            ),),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: MyColor().whiteClr,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                ),
                child: GestureDetector(
                  onTap: (){
                    MyModels().alertDialogContentCustom(context: context, content: StatefulBuilder(
                      builder: (context,setDialogState) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(textAlign: TextAlign.center,"Are you sure you want to delete the account?",style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: MyColor().blackClr
                              ),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text("Type ",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: MyColor().blackClr
                                  ),),
                                  Text("Delete ",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: MyColor().blackClr
                                  ),),
                                  Text("to confirm",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: MyColor().blackClr
                                  ),),
                                ],
                              ),
                              SizedBox(height: 16,),
                              TextFormField(
                                controller: deleteController,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (_){
                                  setDialogState((){});
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: MyColor().redClr,width: 0.5)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: MyColor().redClr, width: 0.5)
                                  ),
                                ),
                              ),
                              SizedBox(height: 16,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: MyColor().primaryClr,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: deleteController.text.trim() == "Delete" ?  () async{
                                          await DBHelper().deleteAllLoginData();
                                          await DBHelper().deleteUserId();

                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> CheckUserPage()), (route) => false,);
                                        } : null,
                                        child: Text("Delete Account",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor().whiteClr
                                          ),)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColor().whiteClr,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: MyColor().primaryClr)
                                          ),
                                          elevation: 0
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor().primaryClr
                                          ),)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                    children: [
                      Icon(Iconsax.trash_copy,size: 18,color: MyColor().redClr,),
                      SizedBox(width: 5,),
                      Text("Delete Account",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: MyColor().redClr
                      ),),
                    ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25,),
              GestureDetector(
                onTap: (){
                  MyModels().alertDialogCustomizeEdit(context, "Are you sure?", Text("You can sign back in anytime. Want to switch accounts?",style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColor().secondaryClr
                  ),), (){
                    Navigator.pop(context);
                  }, ()async{

                    await DBHelper().deleteAllLoginData();
                    await DBHelper().deleteUser();
                    await DBHelper().deleteUserId();

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> CheckUserPage()), (route) => false,);
                  }, "Cancel", "Logout");
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                      borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                    children: [
                      Icon(Iconsax.logout_copy,size: 18,),
                      SizedBox(width: 5,),
                      Text("Log Out",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: MyColor().blackClr
                      ),),
                    ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Center(
            child: Wrap(
              children: [
                customText(text: 'About Us'),
                 Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                customText(text: 'Contact us'),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                customText(text: 'Feedback'),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                customText(text: 'FAQ'),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                customText(text: 'Privacy Policy'),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                customText(text: 'Terms & Conditions'),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Center(child: Text(textAlign: TextAlign.center,"Copyright © 2025 AllCollegeEvent - All Rights Reserved.",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,color: MyColor().borderClr,fontSize: 12
          ),)),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

  // ----------- Custom Widget -------
  Widget customContainer({required String name, required IconData icon,required dynamic borderRadius}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: MyColor().boxInnerClr,
      borderRadius: borderRadius,
      // border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
    ),
    child: Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: MyColor().blackClr
          ),),
          Icon(icon,size: 18,)
        ],
      ),
    ),
  );
}

  // --------- Check Box -------
  Widget customCheckBox({required String name,required dynamic borderRadius, required dynamic value,required ValueChanged onChanged}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: MyColor().boxInnerClr,
      borderRadius: borderRadius,
    ),
    child: Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: MyColor().blackClr
          ),),
          Transform.scale(
              scale: 0.7,
              child: Switch(value: value, onChanged: onChanged,))
        ],
      ),
    ),
  );
}

  // ------- custom text -------
  Widget customText({required String text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(text, style: GoogleFonts.poppins(
        fontSize: 14, color: MyColor().borderClr, fontWeight: FontWeight.w600
    ),),
  );
}

