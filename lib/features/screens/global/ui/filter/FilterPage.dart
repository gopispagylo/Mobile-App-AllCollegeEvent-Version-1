import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  // ----------- Status --------
  List<Map<String, dynamic>> statusList = [
    {'title': 'All', 'value': false},
    {'title': 'Trending', 'value': false},
    {'title': 'Ongoing', 'value': false},
    {'title': 'Upcoming', 'value': false},
  ];

  // -------- Mode list ----------
  List<Map<String, dynamic>> modeList = [
    {'title': 'Offline'},
    {'title': 'Online'},
    {'title': 'Hybrid'},
  ];

  String? selectedMode;

  // ----------- Certification ----------
  List<Map<String, dynamic>> certificationList = [
    {'title': 'All Participants', 'value': false},
    {'title': 'No Price', 'value': false},
    {'title': 'Not Provided', 'value': false},
  ];

  // ------------- Perks ---------------
  List<Map<String, dynamic>> perksList = [
    {'title': 'Certificates', 'value': false},
    {'title': 'Medal', 'value': false},
    {'title': 'Awards', 'value': false},
  ];


  // ---------- Types of Categories ----------
  List<Map<String, dynamic>> categoryList = [
    {'title': 'Entertainment', 'value': false},
    {'title': 'Networking', 'value': false},
    {'title': 'Education', 'value': false},
    {'title': 'Sports', 'value': false},
    {'title': 'Others', 'value': false},
  ];

  // -------- dropdown values -------
  String? selectedTypeOfCategories;
  String? selectedTypeOfCategoriesDropdownValue;
  String? selectedDepartmentValue;
  String? selectedCountryValue;
  String? selectedStateValue;
  String? selectedCityValue;


  // ---------- EducationalEvents -----
  List<Map<String, dynamic>> educational = [
    {'title': 'Hackathon', 'value': false},
    {'title': 'Guest Lectures', 'value': false},
    {'title': 'Webinars', 'value': false},
    {'title': 'Startup Events', 'value': false},
    {'title': 'Bootcamps', 'value': false},
    {'title': 'Seminars', 'value': false},
    {'title': 'Technical Events', 'value': false},
    {'title': 'Workshops', 'value': false},
  ];


  // --------- entertainmentEvents -----
  List<Map<String, dynamic>> entertainment = [
    {'title': 'Concerts', 'value': false},
    {'title': 'Magic Shows', 'value': false},
    {'title': 'Comedy Shows', 'value': false},
    {'title': 'Fashion Show', 'value': false},
    {'title': 'Dance Shows', 'value': false},
    {'title': 'Stage Plays', 'value': false},
    {'title': 'Culturals', 'value': false},
    {'title': 'Music Festivals', 'value': false},
    {'title': 'Food Festivals', 'value': false},
    {'title': 'Civic Festivals', 'value': false},
    {'title': 'Painting', 'value': false},
  ];

  // ----------- sportsEvents -------------
  List<Map<String, dynamic>> sports = [
    {'title': 'Athletics', 'value': false},
    {'title': 'Tournaments', 'value': false},
    {'title': 'Marathon', 'value': false},
    {'title': 'Fitness Challenges', 'value': false},
    {'title': 'Video Games', 'value': false},
  ];

  // ------------- networkingEvents ---------
  List<Map<String, dynamic>> networking = [
    {'title': 'Conferences', 'value': false},
    {'title': 'Alumni Meets', 'value': false},
    {'title': 'Meetups', 'value': false},
    {'title': 'Job Fairs', 'value': false},
    {'title': 'Book Expo & Tradeshows', 'value': false},
    {'title': 'Symposiums', 'value': false},
    {'title': 'Art Gallery', 'value': false},
  ];

  // --------------- otherEvents --------------
  List<Map<String, dynamic>> other = [
    {'title': 'Prayer Meetings', 'value': false},
    {'title': 'Mental Wellness', 'value': false},
    {'title': 'Blood Donation Camps', 'value': false},
    {'title': 'Awareness Programs', 'value': false},
  ];



  // --------- dynamic dropdown for type of categories ---------
  late final Map<String, List<Map<String, dynamic>>> categoryDynamic = {
    'Entertainment': entertainment,
    'Networking': networking,
    'Sports': sports,
    'Education': educational,
    'Others': other,
  };

  // -------- common dropdown list --------------
  List<DropdownMenuItem<String>> dropdownItems = [];

  // ------- departments --------
  List<String> departments = [
    'Computer Science',
    'Mechanical Engineering',
    'Electrical Engineering',
    'Civil Engineering',
    'Information Technology',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        centerTitle: true,
        title: Text("Filter",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: MyColor().blackClr,
        ),),
      ),
      body: MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => CityBloc(apiController: ApiController()),
    ),
    BlocProvider(
      create: (context) => CountryBloc(apiController: ApiController())..add(FetchCountry()),
    ), BlocProvider(
      create: (context) => ChooseStateBloc(apiController: ApiController()),
    ),
  ],
  child: Container(
        child: ListView(
          children: [

            // --------- status ---------
            Container(
                margin: EdgeInsets.only(left: 16,bottom: 5),
                child: Text("Status",style: GoogleFonts.poppins(
                  fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(statusList.length, (index){
                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 16 : 0,right: index == statusList.length - 1 ? 16 : 0),
                    child: Row(
                      children: [
                        Checkbox(
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            value: statusList[index]['value'],
                            onChanged: (onChanged) {
                              setState(() {
                                statusList[index]['value'] = onChanged;
                              });
                            }),
                        Text(statusList[index]['title']),
                        SizedBox(width: 20,)
                      ],
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 20,),

            // ----- mode --------
            Container(
                margin: EdgeInsets.only(left: 16,bottom: 5),
                child: Text("Mode",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(modeList.length, (index){
                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 16 : 0,right: index == modeList.length -1 ? 16 : 0),
                    child: Row(
                      children: [
                        Radio(
                          visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          groupValue: selectedMode,value: modeList[index]['title'],onChanged: (onChanged){
                          setState(() {
                            selectedMode = onChanged;
                          });
                        },),
                        Text(modeList[index]['title']),
                        SizedBox(width: 20,)
                      ],
                    ),
                  );
                }),
              ),
            ),


            SizedBox(height: 20,),

            // ------ Certification -------
            Container(
                margin: EdgeInsets.only(left: 16,bottom: 5),
                child: Text("Certification",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(certificationList.length, (index){
                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 16 : 0,right: index == certificationList.length - 1 ? 16 : 0),
                    child: Row(
                      children: [
                        Checkbox(
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            value: certificationList[index]['value'],
                            onChanged: (onChanged) {
                              setState(() {
                                certificationList[index]['value'] = onChanged;
                              });
                            }),
                        Text(certificationList[index]['title']),
                        SizedBox(width: 20,)
                      ],
                    ),
                  );
                }),
              ),
            ),


            SizedBox(height: 20,),

            // ------ Perks -------
            Container(
                margin: EdgeInsets.only(left: 16,bottom: 5),
                child: Text("Perks",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                ),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(perksList.length, (index){
                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 16 : 0,right: index == perksList.length - 1 ? 16 : 0),
                    child: Row(
                      children: [
                        Checkbox(
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            value: perksList[index]['value'],
                            onChanged: (onChanged) {
                              setState(() {
                                perksList[index]['value'] = onChanged;
                              });
                            }),
                        Text(perksList[index]['title']),
                        SizedBox(width: 20,)
                      ],
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 20,),

            // ------ Types of Categories -------
           Container(
             margin: EdgeInsets.all(16),
             padding: EdgeInsets.all(16),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                     margin: EdgeInsets.only(bottom: 16),
                     child: Text("Types of Categories",style: GoogleFonts.poppins(
                         fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                     ),)),
                 Wrap(
                   runSpacing: 16,
                   spacing: - 20,
                   alignment: WrapAlignment.start,
                   children: List.generate(categoryList.length, (index){
                     return Container(
                       padding: EdgeInsets.all(6),
                       decoration: BoxDecoration(
                           color: MyColor().boxInnerClr,
                           borderRadius: BorderRadius.circular(30),
                           border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                       ),
                       margin: EdgeInsets.only(left: 16,right: 16),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Radio(
                             visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                             groupValue: selectedTypeOfCategories,value: categoryList[index]['title'],onChanged: (onChanged){
                             setState(() {
                               selectedTypeOfCategories = onChanged;
                               final list = categoryDynamic[onChanged] ?? [];
                               dropdownItems = list
                                   .map((e) => DropdownMenuItem<String>(
                                 value: e['title'],
                                 child: Text(e['title']),
                               ))
                                   .toList();
                             });

                           },),
                           Text(categoryList[index]['title']),
                           SizedBox(width: 5,)
                         ],
                       ),
                     );
                   }),
                 ),
               ],
             ),
           ),
           if(dropdownItems.isNotEmpty) Center(
             child: Container(
                 margin: EdgeInsets.only(left: 16,right: 16),
                 child: MyModels().customDropdown(label: "Types of Events", hint: "Select Types of Events", value: selectedTypeOfCategoriesDropdownValue, onChanged: (onChanged){}, items: dropdownItems, valid: Validators().validTypeOfEvents)),
           ),


            if(dropdownItems.isNotEmpty) SizedBox(height: 20,),

            // --------- Department ---------
            Center(
              child: Container(
                  margin: EdgeInsets.only(left: 16,right: 16),
                  child: MyModels().customDropdown(label: "Departments", hint: "Select Departments", value: selectedDepartmentValue, onChanged: (onChanged){}, items: departments.map((e)=> DropdownMenuItem<String>(value: e,child: Text(e))).toList(), valid: Validators().validTypeOfEvents)),
            ),

            SizedBox(height: 20,),

            // --------- Country ---------
            Center(
              child: Container(
                  margin: EdgeInsets.only(left: 16,right: 16),
                  child: MyModels().customDropdown(label: "Country", hint: "Select Your Country", value: selectedTypeOfCategoriesDropdownValue, onChanged: (onChanged){}, items: dropdownItems, valid: Validators().validTypeOfEvents)),
            ),

            // ------ Country dropdown --------
            BlocBuilder<CountryBloc, CountryState>(
              builder: (context, countryState) {
                if(countryState is CountryLoading){
                  return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                }
                else if(countryState is CountrySuccess){
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12,top: 20),
                          child: Text("Country",style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        SizedBox(
                          width: 320,
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: MyColor().primaryClr,
                            hint: Text("Select your country",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColor().hintTextClr
                            ),),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: MyColor().primaryClr,
                              fontWeight: FontWeight.w600,
                            ),
                            iconDisabledColor: MyColor().blackClr,
                            value: selectedCountryValue,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down,),
                              ),
                              // iconColor: MyColor().primaryClr,
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
                            ),
                            onChanged: (onChanged){
                              setState(() {
                                selectedCountryValue = onChanged;
                              });

                              // ---- get a state ------
                              context.read<ChooseStateBloc>().add(FetchChooseState(countryCode: selectedCountryValue!));
                            },
                            items: countryState.countryList.map((e)=> DropdownMenuItem<String>(value: e['name'],child: Text(e['name'].toString()))).toList(),
                            validator: Validators().validCountry,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if(countryState is CountryFail){
                  return Text(countryState.errorMessage);
                } return SizedBox.shrink();
              },
            ),

            SizedBox(height: 20,),
            // ------- state dropdown --------
            BlocBuilder<ChooseStateBloc, ChooseStateState>(
              builder: (context, chooseState) {
                if(chooseState is ChooseStateLoading){
                  return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                } else if(chooseState is ChooseStateSuccess){
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text("State",style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        SizedBox(
                          width: 320,
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: MyColor().primaryClr,
                            hint: Text("Select your state",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColor().hintTextClr
                            ),),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: MyColor().primaryClr,
                              fontWeight: FontWeight.w600,
                            ),
                            iconDisabledColor: MyColor().blackClr,
                            value: selectedStateValue,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down,),
                              ),
                              // iconColor: MyColor().primaryClr,
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
                            ),
                            onChanged: (onChanged){
                              setState(() {
                                selectedStateValue = onChanged;
                              });

                              // ----- get city -----
                              context.read<CityBloc>().add(FetchCity(stateCode: selectedStateValue!, countryCode: selectedCountryValue!));
                            },
                            items: chooseState.stateList.map((e)=> DropdownMenuItem<String>(value: e['name'],child: Text(e['name'].toString()))).toList(),
                            validator: Validators().validState,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if(chooseState is ChooseStateFail){
                  return Center(child: Text(chooseState.errorMessage),);
                } return SizedBox.shrink();
              },
            ),

            SizedBox(height: 20,),

            // ------- city dropdown --------
            BlocBuilder<CityBloc, CityState>(
              builder: (context, cityState) {
                if(cityState is CityLoading){
                  return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                } else if(cityState is CitySuccess){
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text("City",style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        SizedBox(
                          width: 320,
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: MyColor().primaryClr,
                            hint: Text("Select your city",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColor().hintTextClr
                            ),),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: MyColor().primaryClr,
                              fontWeight: FontWeight.w600,
                            ),
                            iconDisabledColor: MyColor().blackClr,
                            value: selectedCityValue,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down,),
                              ),
                              // iconColor: MyColor().primaryClr,
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
                            ),
                            onChanged: (onChanged){
                              selectedCityValue = onChanged;
                            },
                            items: cityState.cityList.map((e)=> DropdownMenuItem<String>(value: e,child: Text(e.toString()))).toList(),
                            validator: Validators().validState,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if(cityState is CityFail){
                  return Center(child: Text(cityState.errorMessage),);
                }return SizedBox();
              },
            ),

            Container(
              alignment: AlignmentGeometry.center,
                margin: EdgeInsets.only(bottom: 30,top: 30),
                child: MyModels().customButton(onPressed: (){}, title: "Show Results")),


          ],
        ),
      ),
),
    );
  }
}
