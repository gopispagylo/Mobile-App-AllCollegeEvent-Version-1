import 'dart:math' as math;

import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/global/bloc/singleImageController/single_image_controller_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

class FaqModel extends StatefulWidget {
  const FaqModel({super.key});

  @override
  State<FaqModel> createState() => _FaqModelState();
}

class _FaqModelState extends State<FaqModel> with SingleTickerProviderStateMixin {

  // --------- Controller -----------
  late TabController tabController;
  final yourCommentController = TextEditingController();


  // ------------ faqs qes & ans --------
  final List<Map<String, String>> faqList = [
    {
      "q": "What types of events does this website cover?",
      "a": "We cover academic, cultural, technical, sports, and corporate events."
    },
    {
      "q": "How can I register for an event?",
      "a": "You can register directly through the event page."
    },
    {
      "q": "Is the platform free to use?",
      "a": "Yes, browsing and registration are free."
    },
    {
      "q": "Can I host my own event?",
      "a": "Yes, organizers can publish events after verification."
    },
    {
      "q": "Do you support online events?",
      "a": "Yes, both online and offline events are supported."
    },

  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    yourCommentController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: ListView(
        children: [
          // Search Bar
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30, bottom: 16,right: 16,left: 16),
              width: 380,
              child: TextFormField(
                onTapOutside: (onChanged) {
                  WidgetsBinding.instance.focusManager.primaryFocus!
                      .unfocus();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: MyColor().borderClr,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: MyColor().primaryClr,
                      width: 0.5,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search, size: 18),
                  hintText: "Search",
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: MyColor().hintTextClr,
                  ),
                ),
              ),
            ),
          ),

          // --------- title ------
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("Do you have questions? We’re here to help.",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,fontSize: 12,color: MyColor().blackClr
              ),),
            ),
          ),

          // ----------- tab bar -----------
          Container(
            margin: EdgeInsets.only(top: 30),
            child: TabBar(
                dividerHeight: 0,
                controller: tabController,
                indicatorAnimation: TabIndicatorAnimation.linear,
                indicatorPadding: EdgeInsetsGeometry.only(left: 15,right: 15),
                indicatorColor: MyColor().primaryClr,
                labelColor: MyColor().primaryClr,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: MyColor().blackClr,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(child: Text('All'),),
                  Tab(child: Text('Tickets'),),
                  Tab(child: Text('Event'),),
                  Tab(child: Text('Price'),),
                ]),
          ),

          // ---------- tab bar views ----------
          SizedBox(
            height: 250,
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                // ----- all -------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(faqList.length, (index){
                      final list = faqList[index];
                      return ExpansionTile(
                        shape: Border(),
                        tilePadding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        collapsedShape: Border(),
                        title: Text(list['q']!,style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                        ),),
                        enableFeedback: true,
                        children: [
                          Text(list['a']!,style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                          ),)
                        ],);
                    }),
                  ),
                ),

                // ---------- tickets ---------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(faqList.length, (index){
                      final list = faqList[index];
                      return ExpansionTile(
                        shape: Border(),
                        tilePadding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        collapsedShape: Border(),
                        title: Text(list['q']!,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                        ),),
                        enableFeedback: true,
                        children: [
                          Text(list['a']!,style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                          ),)
                        ],);
                    }),
                  ),
                ),

                // -------- event ----------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(faqList.length, (index){
                      final list = faqList[index];
                      return ExpansionTile(
                        shape: Border(),
                        tilePadding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        collapsedShape: Border(),
                        title: Text(list['q']!,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                        ),),
                        enableFeedback: true,
                        children: [
                          Text(list['a']!,style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                          ),)
                        ],);
                    }),
                  ),
                ),

                // -------- price ---------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(faqList.length, (index){
                      final list = faqList[index];
                      return ExpansionTile(

                        shape: Border(),
                        tilePadding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        collapsedShape: Border(),
                        title: Text(list['q']!,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                        ),),
                        enableFeedback: true,
                        children: [
                          Text(list['a']!,style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                          ),)
                        ],);
                    }),
                  ),
                ),

              ]),
            ),
          ),

          // ----------- Make your Questions ---------
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("Make your Questions",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,fontSize: 18,color: MyColor().blackClr
              ),),
            ),
          ),

          // ------------ field --------
          Center(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColor().boxInnerClr
              ),
              child: Container(
                child: Column(
                  children: [
                    // ------- description --------
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                            ),
                            controller: yourCommentController,
                            maxLines: 5,
                            validator: Validators().validComment,
                            onTapOutside: (outSideTab){
                              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            },
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: MyColor().whiteClr,
                              filled: true,
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
                                  borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
                              ),
                              hintText: "Your Message",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: MyColor().hintTextClr
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ----------- attachment -----------
                    BlocBuilder<SingleImageControllerBloc, SingleImageControllerState>(
                      builder: (context, singleImageState) {
                        return GestureDetector(
                          onTap: (){
                            context.read<SingleImageControllerBloc>().add(ChooseImagePickerSingle(source: ImageSource.gallery));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 48,
                            width: 320,
                            decoration: BoxDecoration(
                                color: MyColor().whiteClr,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: MyColor().borderClr.withOpacity(0.15))
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(overflow: TextOverflow.ellipsis, singleImageState is SingleImageSuccess ? singleImageState.imagePath.name.toString() : "Attachments", style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: MyColor().hintTextClr
                                    ),),
                                  ),
                                  singleImageState is SingleImageSuccess ? IconButton(onPressed: (){
                                    context.read<SingleImageControllerBloc>().add(RemoveSingleImage());
                                  }, icon: Icon(Iconsax.close_circle,color: MyColor().redClr,)) : Transform.rotate(angle: 140 * math.pi / 180,
                                      child: Icon(Icons.attachment,
                                        color: MyColor().hintTextClr,))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),

          // ----------- button ----------
          Center(child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: MyModels().customButton(onPressed: (){}, title: "Submit")))

        ],
      ),
    );
  }
}
