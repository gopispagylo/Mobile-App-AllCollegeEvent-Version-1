import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class FeedBackModel extends StatefulWidget {
  const FeedBackModel({super.key});

  @override
  State<FeedBackModel> createState() => _FeedBackModelState();
}

class _FeedBackModelState extends State<FeedBackModel> {

  // ----------- controller --------
  final commentController = TextEditingController();

  // ------- choose a emoji --------
  String? selectFeedBack;

  // ------------- emoji list --------------
  final List<Map<String,dynamic>> emojiList = [
    {
      'image' : "assets/image/sad.png",
      'title' : "Average",
    },
    {
      'image' : "assets/image/happy.png",
      'title' : "Good",
    },
    {
      'image' : "assets/image/excellent.png",
      'title' : "Excellent",
    },
  ];

  // ----------- global key -----------
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(emojiList.length, (index){
                final checkClick = emojiList[index]['title'] == selectFeedBack;
                return Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectFeedBack = emojiList[index]['title'];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: !checkClick ? MyColor().whiteClr : MyColor().primaryBackgroundClr.withOpacity(0.20),
                          border: Border.all(color: !checkClick ? MyColor().whiteClr : MyColor().primaryClr),
                          borderRadius: BorderRadiusGeometry.circular(8)
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColor().yellowClr,
                                    offset: Offset(1, 0),
                                    blurRadius: 25,
                                    spreadRadius: 1
                                  ),
                                ]
                              ),
                              child: Image.asset(emojiList[index]['image'],height: 40,)),

                          Container(
                            margin: EdgeInsets.only(bottom: 10,top: 10),
                            child: Text(emojiList[index]['title'],style: GoogleFonts.poppins(
                                fontSize: 12,color: MyColor().blackClr,fontWeight: FontWeight.w500
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 40),
                child: MyModels().textFormFieldCommentLimited(context: context, label: "How is your overall experience?", hintText: "What worked well? What could we improve?", valid: "Please enter your comment", controller: commentController, keyBoardType: TextInputType.text, textCapitalization: TextCapitalization.words, maxLines: 10, limit: 1000)),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 30),
                child: MyModels().customButton(onPressed: commentController.text.isNotEmpty ? (){
                  if(selectFeedBack!.isNotEmpty && selectFeedBack != null){
                    if(formKey.currentState!.validate()){
                    }
                  }else{
                    FlutterToast().flutterToast("Please select your feed back emoji", ToastificationType.error, ToastificationStyle.flat);
                  }
                } : null, title: "Submit")),
          ),
        ],
      ),
    );
  }
}
