import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/MediaAndTicketsPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SelectTimeZoneModel extends StatefulWidget {
  const SelectTimeZoneModel({super.key});

  @override
  State<SelectTimeZoneModel> createState() => _SelectTimeZoneModelState();
}

class _SelectTimeZoneModelState extends State<SelectTimeZoneModel> {

  // ------- time zone --------
  final List<String> timeZoneList = [
    '(UTC-12:00)',
    '(UTC-24:00)',
  ];

  // ------ dropdown value -------
  String? selectTimeZone;


  // ------ store date time dynamic ------
  final List<DateTimeBlock> dateTimeBlock = [
    DateTimeBlock(),
  ];


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

        SizedBox(height: 20,),
        
        // ------ time zone ---------
        Center(
          child: Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            child: MyModels().customDropdown(label: "Time Zone *", hint: "select your time zone", value: selectTimeZone, onChanged: (onChanged){

            }, items: timeZoneList.map((e)=> DropdownMenuItem<String>(value: e,child: Text(e))).toList(), valid: Validators().validTimeZone),
          ),
        ),

        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dateTimeBlock.length,
            itemBuilder: (context, index) {
              final bloc = dateTimeBlock[index];

              // ------ find last index -------
              final bool isLast = index == dateTimeBlock.length - 1;
              return Container(
                margin: EdgeInsets.only(top: 16,
                    right: 16,
                    left: 16,
                    bottom: index == dateTimeBlock.length - 1 ? 20 : 0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: MyColor().whiteClr,
                    border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15)),
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
                        }
                      }, label: "End Date & Time *"),
                    ),

                    // --- add & date button ------
                    if(isLast) Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
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
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> MediaAndTicketsPage()));
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
