import 'package:all_college_event_app/features/screens/profile/model/EditProfileModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/SavedEventModel.dart';
import 'package:all_college_event_app/features/screens/profile/model/SocialLinksModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileModel extends StatefulWidget {
  const ProfileModel({super.key});

  @override
  State<ProfileModel> createState() => _ProfileModelState();
}

class _ProfileModelState extends State<ProfileModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Profile",style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MyColor().blackClr
            ),),
          ),
          SizedBox(height: 10,),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> EditProfileModel()));
              },
              child: customContainer(name: "Edit Profile", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)))),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> SocialLinksModel()));
              },
              child: customContainer(name: "Social Links", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)))),
          SizedBox(height: 24,),
          Container(
            child: Text("My Activities",style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MyColor().blackClr
            ),),
          ),
          SizedBox(height: 10,),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> SavedEventModel()));
              },
              child: customContainer(name: "My Saved List", icon: Icons.arrow_forward_ios, borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)))),
          SizedBox(height: 24,),
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