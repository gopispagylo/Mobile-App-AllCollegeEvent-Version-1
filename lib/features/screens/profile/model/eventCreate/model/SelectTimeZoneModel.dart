import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/MediaAndTicketsPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SelectTimeZoneModel extends StatefulWidget {
  final Map<String,dynamic> orgDetailList;

  const SelectTimeZoneModel({super.key, required this.orgDetailList});

  @override
  State<SelectTimeZoneModel> createState() => _SelectTimeZoneModelState();
}

class _SelectTimeZoneModelState extends State<SelectTimeZoneModel> {

  // ------- time zone --------
  final List<String> timeZoneList = [
    'India',
    'USA',
  ];

  // -------- switch --------
  bool checkMultipleDates = false;

  // ------------- event mode ----------
  final List<Map<String, String>> eventMode = [
    {'Offline' : "OFFLINE"},
    {'Online' : "ONLINE"},
    {'Hybrid' : "HYBRID"},
  ];

  // ------ dropdown value -------
  String? selectTimeZone;
  String? selectEventMode;


  // ------ store date time dynamic ------
  final List<DateTimeBlock> dateTimeBlock = [
    DateTimeBlock(),
  ];

  // ------- form global key -------
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final block in dateTimeBlock) {
      block.startController.dispose();
      block.endController.dispose();
    }
    super.dispose();
  }

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
                              value: 0.5,
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


          // ------ time zone ---------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              child: MyModels().customDropdown(label: "Time Zone *", hint: "select your time zone", value: selectTimeZone, onChanged: (onChanged){
                setState(() {
                  selectTimeZone = onChanged;
                });
              }, items: timeZoneList.map((e)=> DropdownMenuItem<String>(value: e,child: Text(e))).toList(), valid: Validators().validTimeZone),
            ),
          ),


          // -------  Add multiple dates switch -----

          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 320,
              child: Row(
                children: [
                  Text('Add Multiple Dates',style: GoogleFonts.poppins(
                      fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                  ),),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(value: checkMultipleDates, onChanged: (onChanged){
                      setState(() {
                        checkMultipleDates = onChanged;
                      });
                    }),
                  )
                ],
              ),
            ),
          ),


          // --------- date & time builder ui ------
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dateTimeBlock.length,
              itemBuilder: (context, index) {
                final bloc = dateTimeBlock[index];

                // ------ find last index -------
                final bool isLast = index == dateTimeBlock.length - 1;
                return Container(
                  margin: EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: index == dateTimeBlock.length - 1 ? 20 : 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: MyColor().whiteClr,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [

                      // SizedBox(height: 20,),

                      Center(
                        child: MyModels().customDateAndTimeUi(
                            controller: bloc.startController, onTap: () async {
                          final result = await DateAndTimeController()
                              .selectedDateAndTimePicker(context);
                          if (result != null) {
                            bloc.startController.text = result;
                            final splitResultStart = result.split(',');
                            bloc.startDateController.text = splitResultStart[0];
                            bloc.startTimeController.text = splitResultStart[1];
                          }
                        }, label: "Start Date & Time *"),
                      ),

                      SizedBox(height: 20,),

                      Center(
                        child: MyModels().customDateAndTimeUi(
                            controller: bloc.endController, onTap: () async {
                          final result = await DateAndTimeController()
                              .selectedDateAndTimePicker(context);

                          if (result != null) {
                            bloc.endController.text = result;
                            final splitResultEnd = result.split(',');
                            bloc.endDateController.text = splitResultEnd[0];
                            bloc.endTimeController.text = splitResultEnd[1];
                          }

                        }, label: "End Date & Time *"),
                      ),

                      // --- add & date button ------
                      if(isLast) Container(
                        width: 320,
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                           if(checkMultipleDates) Container(
                             child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    dateTimeBlock.add(DateTimeBlock());
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: MyColor().boxInnerClr,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: MyColor().borderClr.withOpacity(
                                              0.15))
                                  ),
                                  child: Icon(Iconsax.add_circle_copy,
                                    color: MyColor().greenClr,),
                                ),
                              ),
                           ),
                            if(dateTimeBlock.length > 1) SizedBox(width: 10,),
                            if(dateTimeBlock.length > 1) GestureDetector(
                              onTap: () {
                                setState(() {
                                  bloc.startController.dispose();
                                  bloc.endController.dispose();
                                  dateTimeBlock.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: MyColor().borderClr.withOpacity(
                                            0.15))
                                ),
                                child: Icon(
                                  Iconsax.trash_copy, color: MyColor().redClr,),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              }),


          // ----- event mode -------
          Column(
            children: [
              MyModels().customDropdown(label: "Event Mode",
                  hint: "Select the event mode",
                  value: selectEventMode,
                  onChanged: (eventMode) {
                    setState(() {
                      selectEventMode = eventMode;
                    });
                  },
                  items: eventMode.map((e) => DropdownMenuItem<String>(
                      value: e.values.first, child: Text(e.keys.first)))
                      .toList(),
                  valid: Validators().validEventMode)
            ],
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

                      if (formKey.currentState!.validate()) {
                        for (var block in dateTimeBlock) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) =>
                                  MediaAndTicketsPage(orgDetailList: {
                                    ...widget.orgDetailList,
                                    'calendars' : [
                                      {
                                        'timeZone' : selectTimeZone,
                                        'startDate' : block.startDateController.text,
                                        'endDate' : block.endDateController.text,
                                        'startTime' : block.startTimeController.text,
                                        'endTime' : block.endTimeController.text,
                                      }
                                    ],
                                    'mode' : selectEventMode
                                  },)));
                        }
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
