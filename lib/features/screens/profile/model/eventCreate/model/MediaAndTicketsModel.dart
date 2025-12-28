import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/accommodation/accommodation_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/certification/certification_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/perks/perks_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/PaymentPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MediaAndTicketsModel extends StatefulWidget {
  const MediaAndTicketsModel({super.key});

  @override
  State<MediaAndTicketsModel> createState() => _MediaAndTicketsModelState();
}

class _MediaAndTicketsModelState extends State<MediaAndTicketsModel> {

  // -------- Controllers -------
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final faceBookController = TextEditingController();
  final twitterController = TextEditingController();
  final youtubeController = TextEditingController();
  final telegramController = TextEditingController();

  // ------- dropdown value ----
  String? perksValue;
  String? certificationValue;
  String? accommodationValue;


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.newspaper),
                    Container(
                      child: Text(textAlign: TextAlign.center,"Organization Details"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.newspaper),
                    Container(
                      child: Text(textAlign: TextAlign.center,"Event Details"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.newspaper),
                    Container(
                      child: Text(textAlign: TextAlign.center,"Media & Tickets"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ---- multiple image -----
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColor().boxInnerClr,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Iconsax.document_cloud,color: MyColor().borderClr,),
                SizedBox(height: 5,),
                Text("Choose a file or drag & drop it here.",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                )),
                SizedBox(height: 5,),
                Text(textAlign: TextAlign.center,"JPEG/JPG/PNG must be 1200×480 px or 1:1 ratio, and under 500 kb",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().borderClr
                ),),
              ],
            ),
          ),
        ),
        
        // --------- social media --------
        Center(
          child: Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your linked in url'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your instagram url'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your facebook url'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your twitter url'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your youtube url'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: MyModels().customSocialMedia(prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png",height: 20,),
                  ), controller: linkedInController, hintText: 'Enter your telegram url'),
                ),
              ],
            ),
          ),
        ),

        // ------- perks dropdown -----
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<PerksBloc, PerksState>(
              builder: (context, perksState) {
                if (perksState is PerksLoading) {
                  return Center(child: CircularProgressIndicator(
                    color: MyColor().primaryClr,),);
                }
                else if (perksState is PerksSuccess) {
                  return MyModels().customDropdown(label: "Perks *",
                      hint: "Select Perks Type",
                      value: perksValue,
                      onChanged: (onChanged) {

                      },
                      items: perksState.perksList.map((e) =>
                          DropdownMenuItem<String>(
                              value: e['identity'], child: Text(e['perkName'])))
                          .toList(),
                      valid: Validators().validPerks);
                } else if(perksState is PerksFail){
                  return Text(perksState.errorMessage);
                }
                return SizedBox.shrink();
              }
          ),
        ),

        SizedBox(height: 20,),

        // --------- Certification -------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<CertificationBloc, CertificationState>(
              builder: (context, certificationState) {
                if (certificationState is CertificationLoading) {
                  return Center(child: CircularProgressIndicator(
                    color: MyColor().primaryClr,),);
                }
                else if (certificationState is CertificationSuccess) {
                  return MyModels().customDropdown(label: "Certification *",
                      hint: "Select Certification Type",
                      value: perksValue,
                      onChanged: (onChanged) {

                      },
                      items: certificationState.certificationList.map((e) =>
                          DropdownMenuItem<String>(
                              value: e['identity'], child: Text(e['certName'])))
                          .toList(),
                      valid: Validators().validPerks);
                } else if(certificationState is CertificationFail){
                  return Text(certificationState.errorMessage);
                }
                return SizedBox.shrink();
              }
          ),
        ),

        SizedBox(height: 20,),

        // --------- Accommodation -------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<AccommodationBloc, AccommodationState>(
              builder: (context, accommodationState) {
                if (accommodationState is AccommodationLoading) {
                  return Center(child: CircularProgressIndicator(
                    color: MyColor().primaryClr,),);
                }
                else if (accommodationState is AccommodationSuccess) {
                  return MyModels().customDropdown(label: "Accommodation *",
                      hint: "Select Accommodation Type",
                      value: perksValue,
                      onChanged: (onChanged) {

                      },
                      items: accommodationState.accommodationList.map((e) =>
                          DropdownMenuItem<String>(
                              value: e['identity'], child: Text(e['accommodationName'])))
                          .toList(),
                      valid: Validators().validPerks);
                } else if(accommodationState is AccommodationFail){
                  return Text(accommodationState.errorMessage);
                }
                return SizedBox.shrink();
              }
          ),
        ),

        SizedBox(height: 20,),

        // ------- back & Continue -------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16,bottom: 20),
          child: Row(
            children: [
              // ------- Save & Continue -------
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Container(
                        margin: EdgeInsets.only(top: 20,right: 0),
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor().whiteClr,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: MyColor().primaryClr)
                        ),
                        child: Text("Back",style: GoogleFonts.poppins(
                            fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                        ),)),
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    // if(formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentPage()));
                    // }
                  },
                  child: Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Container(
                        margin: EdgeInsets.only(top: 20,right: 0),
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor().primaryClr,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: MyColor().primaryClr)
                        ),
                        child: Text("Continue",style: GoogleFonts.poppins(
                            fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().whiteClr
                        ),)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
