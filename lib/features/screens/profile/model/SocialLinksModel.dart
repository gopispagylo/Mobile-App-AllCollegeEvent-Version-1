import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLinksModel extends StatefulWidget {
  const SocialLinksModel({super.key});

  @override
  State<SocialLinksModel> createState() => _SocialLinksModelState();
}

class _SocialLinksModelState extends State<SocialLinksModel> {

  // -------- Controllers -------
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final faceBookController = TextEditingController();
  final twitterController = TextEditingController();
  final youtubeController = TextEditingController();
  final telegramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Social Links",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Center(
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
              SizedBox(height: 30,),
              MyModels().customButton(onPressed: (){

                // ---- Success Dialog -----
                MyModels().alertDialogContentCustom(context: context, content: Container(
                  color: MyColor().boxInnerClr,
                  child: Text(textAlign: TextAlign.center,"Successfully Updated !!",style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: MyColor().blackClr
                  ),),
                ));

                // ---- after showing completed the dialog then back to profile page ----
                Future.delayed(Duration(milliseconds: 1000),(){
                  Navigator.pop(context);
                  Navigator.pop(context);
                });

              }, title: 'Update')
            ],
          ),
        ),
      ),
    );
  }
}
