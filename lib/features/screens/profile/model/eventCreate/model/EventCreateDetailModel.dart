import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/aceCategories/ace_categories_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/eventType/event_type_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/searchableKeyWords/searchable_key_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/SelectTimeZonePage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

class EventCreateDetailModel extends StatefulWidget {
  final Map<String,dynamic> orgDetailList;

  const EventCreateDetailModel({super.key, required this.orgDetailList});

  @override
  State<EventCreateDetailModel> createState() => _EventCreateDetailModelState();
}

class _EventCreateDetailModelState extends State<EventCreateDetailModel> {

  // ------- controller ----
  final titleController = TextEditingController();
  final searchableKeywordsController = TextEditingController();
  final offerController = TextEditingController();
  final aboutController = TextEditingController();

  // --------- dropdown value -----
  String? selectAceCategories;
  String? selectEventType;

  // ------- form global key -------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 1,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Organization Details",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 0.1,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Event Details",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 0.0,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Media & Tickets",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),

          // ----- Event Title ------
          MyModels().customTextFieldWithLimit(label: "Event Title *", hintText: 'Enter Event Title', controller: titleController, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, limit: 50, validator: Validators().validTitle, readOnly: false),

          SizedBox(height: 5,),

          // ---------- Category -----
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,bottom: selectAceCategories != null ? 20 : 0),
              child: BlocBuilder<AceCategoriesBloc, AceCategoriesState>(
                        builder: (context, aceCategoriesState) {
                          if(aceCategoriesState is AceCategoriesLoading){
                            return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                          } else if(aceCategoriesState is AceCategoriesSuccess){
                            return SizedBox(
                              width: 320,
                              child: MyModels().customDropdown(label: "Category *", hint: "Select Event Category", value: selectAceCategories, onChanged: (category){
                                setState(() {
                                  selectAceCategories = category;
                                });
                                context.read<EventTypeBloc>().add(ClickedEventType(identity: selectAceCategories!));
                              }, items: aceCategoriesState.aceCategoriesList.map((e)=> DropdownMenuItem<String>(value: e['identity'],child: Text(e['categoryName']))).toList(), valid: Validators().validOrgCategories),
                            );
                          } else if(aceCategoriesState is AceCategoriesFail){
                            return Center(child: Text(aceCategoriesState.errorMessage),);
                          } return SizedBox.shrink();
                        },
                      ),
            ),
          ),

          // ------ event type -----
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,bottom: 20),
              child: BlocBuilder<EventTypeBloc, EventTypeState>(
                builder: (context, eventTypeState) {
                  if(eventTypeState is EventTypeLoading){
                    return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                  } else if(eventTypeState is EventTypeSuccess){
                    return SizedBox(
                      width: 320,
                      child: MyModels().customDropdown(label: "Event Type *", hint: "Select Type of Event", value: selectEventType, onChanged: (eventType){
                        setState(() {
                          selectEventType = eventType;
                        });
                      }, items: eventTypeState.eventTypeList.map((e)=> DropdownMenuItem<String>(value: e['identity'],child: Text(e['name']))).toList(), valid: Validators().validOrgCategories),
                    );
                  } else if(eventTypeState is EventTypeFail){
                    return Center(child: Text(eventTypeState.errorMessage),);
                  } return SizedBox.shrink();
                },
              ),
            ),
          ),

          // ------ tags ------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Tags *",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Sora",
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))
                          ],
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: MyColor().primaryClr,
                              fontFamily: "Sora"
                          ),
                          controller: searchableKeywordsController,
                          onTapUpOutside: (outSideClick){
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColor().borderClr, width: 0.5)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColor().primaryClr, width: 0.5)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
                            ),
                            hint: Text("#TAGS",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColor().hintTextClr
                            ),),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            if(searchableKeywordsController.text.isNotEmpty){
                              context.read<SearchableKeyBloc>().add(ClickSearchableKey(searchableText: "#${searchableKeywordsController.text}"));
                              searchableKeywordsController.clear();
                            }else{
                              FlutterToast().flutterToast("At least add one searchable keywords", ToastificationType.error, ToastificationStyle.flat);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: MyColor().primaryClr,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Text("Add",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().whiteClr
                              ),)),
                        ))
                  ],
                ),
              ],
            ),
          ),

          // ------ tags list ------
          Center(
            child: BlocBuilder<SearchableKeyBloc, SearchableKeyState>(
              builder: (context, state) {
                if(state is SearchableKeyLoading){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is AddSuccess){
                  return Container(
                    margin: EdgeInsets.only(left: 16, right: 16,top: 20),
                    child: Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List.generate(state.searchableKeyList.length, (index){
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 5,bottom: 5),
                            decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(state.searchableKeyList[index], style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: "Sora"
                                  )),
                                  SizedBox(width: 20,),
                                  GestureDetector(
                                    onTap: (){
                                      context.read<SearchableKeyBloc>().add(RemoveClickSearchableKey(index: index));
                                    },
                                    child: Icon(
                                      Iconsax.close_circle, color: MyColor().redClr,
                                      size: 25,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),

          // ----- Event Title ------
          MyModels().customTextFieldWithLimitWithoutValid(label: "Offers", hintText: 'Enter Offers', controller: offerController, textInputType: TextInputType.none, textCapitalization: TextCapitalization.none, limit: 50, readOnly: false),

          SizedBox(height: 20,),

          // ------ about the event -------
          Center(
            child: Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                child: MyModels().textFormFieldCommentLimited(context: context, label: "About the Event*", hintText: "About the Event", valid: "Please enter about the event", controller: aboutController, keyBoardType: TextInputType.text, textCapitalization: TextCapitalization.sentences, maxLines: 10, limit: 1000)),
          ),

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
                      if(formKey.currentState!.validate()){

                        // -------- call the tags list ---------
                        final tagsState = context.read<SearchableKeyBloc>().state;

                        List<String> tagsList = [];

                        if(tagsState is AddSuccess){
                          tagsList = tagsState.searchableKeyList;
                        }

                      Navigator.push(context, MaterialPageRoute(builder: (_)=> SelectTimeZonePage(orgDetailList: {
                        ... widget.orgDetailList,
                        'tags' : tagsList,
                        'title' : titleController.text,
                        'categoryIdentity' : selectAceCategories,
                        'eventTypeIdentity' : selectEventType,
                        'description' : aboutController.text,
                      },)));
                      }
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
      ),
    );
  }
}
