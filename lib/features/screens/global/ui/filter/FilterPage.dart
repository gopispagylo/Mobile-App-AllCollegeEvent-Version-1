import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/accommodation/accommodation_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/certification/certification_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/eligibleDepartment/eligible_department_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/eventType/event_type_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/perks/perks_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
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
    {'title': 'Trending', 'value': 'trending'},
    {'title': 'Featured', 'value': 'featured'},
  ];

  // -------- Mode list ----------
  List<Map<String, dynamic>> modeList = [
    {'title': 'Offline',"value" : "OFFLINE"},
    {'title': 'Online',"value" : "ONLINE"},
    {'title': 'Hybrid',"value" : "HYBRID"},
  ];

  // ---------- eligible department stored values ----------
  List<String> eligibleDepartmentValues = [];
  List<String> parksValues = [];
  List<String> accommodationValues = [];
  List<String> eventStatus = [];

  // -------- dropdown values -------------
  String? selectedCertification;
  String? selectedMode;
  String? selectedEventType;

  // -------- country, state and city dropdown value ----------
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;


  // --------- title base expand the details ---------
  int selectedIndex = 0;

  List<String> titles = [
    "Status",//0
    "Mode",//1
    "Certification",//2
    "Perks",//3
    "Events",//4
    "Eligible Department",//5
    "Location",//6
    "Accommodation",//7
    "Date",//8
  ];

  // -------- controller ---------
  final dateTimeController = TextEditingController();

  final Map<String,dynamic> finalValue = {};

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        centerTitle: true,
        title: Text(
          "Filter",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CityBloc(apiController: ApiController()),
          ),
          BlocProvider(
            create: (context) =>
                CountryBloc(apiController: ApiController())
                  ..add(FetchCountry()),
          ),
          BlocProvider(
            create: (context) =>
                ChooseStateBloc(apiController: ApiController()),
          ),BlocProvider(
            create: (context) =>
                CertificationBloc(apiController: ApiController())..add(FetchCertification()),
          ),
          BlocProvider(create: (context) => PerksBloc(apiController: ApiController())..add((FetchPerks()))),
          BlocProvider(create: (context) => EventTypeBloc(apiController: ApiController())..add((ClickedEventType(identity: '')))),
          BlocProvider(create: (context) => EligibleDepartmentBloc(apiController: ApiController())..add((FetchEligibleDepartment()))),
          BlocProvider(create: (context) => AccommodationBloc(apiController: ApiController())..add((FetchAccommodation()))),
        ],
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: MyColor().borderClr.withOpacity(0.16),
              ),
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  final title = titles[index];

                  // ----------- find a index is active -------------
                  final findIndex = index == selectedIndex;

                  return InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.only(bottom: 15,top: 15,left: 10,right: 10),
                        alignment: Alignment.center,
                        color: findIndex ? MyColor().whiteClr : Colors.transparent,
                        child: Text(textAlign: TextAlign.center,title,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().blackClr
                        ),)),
                  );
                },
              ),
                // selectedIndex == 0 ? statusUI() : selectedIndex == 1 ? modeUI() : selectedIndex == 2 ? certificationUI() : selectedIndex == 3 ? perksUI() : Container()
            ),
            Expanded(child:switchTheUI())
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 48),
                  backgroundColor: MyColor().primaryClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: (){

                  // --------- helper function of != null -----------
                  void addIfNotNull(String key, dynamic value) {
                    if (value != null) {
                      finalValue[key] = value;
                    }
                  }

                  // --------- helper function of isNotEmpty -----------
                  void addIfListNotEmpty(String key, List? list) {
                    if (list != null && list.isNotEmpty) {
                      finalValue[key] = list;
                    }
                  }

                  addIfListNotEmpty("eventTypes", eventStatus);
                  if(eventStatus.contains('trending')) addIfNotNull("trendingThreshold", 50);
                  if(selectedMode != null) addIfNotNull("modes", [selectedMode]);
                  addIfListNotEmpty("eligibleDeptIdentities", eligibleDepartmentValues);

                  addIfNotNull("certIdentity", selectedCertification);
                  addIfNotNull("eventTypeIdentity", selectedEventType);

                  addIfListNotEmpty("perkIdentities", parksValues);
                  addIfListNotEmpty("accommodationIdentities", accommodationValues);

                  addIfNotNull("country", selectedCountry);
                  addIfNotNull("state", selectedState);
                  addIfNotNull("city", selectedCity);

                  // Date range
                  if (dateTimeController.text.isNotEmpty) {
                    finalValue["dateRange"] = {
                      "startDate": dateTimeController.text,
                    };
                  }

                  print("finalValuefinalValuefinalValuefinalValuefinalValuefinalValue$finalValue");
// // Price range
//                   if (minPrice != null && maxPrice != null) {
//                     finalValue["priceRange"] = {
//                       "min": minPrice,
//                       "max": maxPrice,
//                     };
//                   }

                  // ------ call back the values -------
                Navigator.pop(context,finalValue);
                },
                child: Text(
                  "Apply",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColor().whiteClr,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  // --------- switch case ----------
  Widget switchTheUI(){
    switch(selectedIndex){
      case 0:
        return statusUI();
      case 1:
        return modeUI();
      case 2:
        return certificationUI();
      case 3:
        return perksUI();
      case 4:
        return eventTypeUI();
      case 5:
        return eligibleDepartmentUI();
      case 6:
        return locationUI();
      case 7:
        return accommodationUI();
      case 8:
          return dateUi();
      default:
       return const SizedBox();
    }
  }

  // ---------- status UI ----------
  Widget statusUI() {
    return ListView.builder(itemCount: statusList.length,itemBuilder: (context,index){
      return CheckboxListTile(value: eventStatus.contains(statusList[index]['value']), onChanged: (onChanged){
        setState(() {
          if(onChanged == true){
            eventStatus.add(statusList[index]['value']);
          }else{
            eventStatus.remove(statusList[index]['value']);
          }
          print('jhdfshjfdfsjhdsfjhdfshjkdfshjk$eventStatus');
        });
      },title: Text(statusList[index]['title'],style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr)));
    });
  }

  // ------------ mode UI ----------
  Widget modeUI() {
    return ListView.builder(itemCount: modeList.length,itemBuilder: (context,index){
      return RadioListTile(
        title: Text(modeList[index]['title'],style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 14,color: MyColor().blackClr)),
        value: modeList[index]['value'],
        groupValue: selectedMode,
        onChanged: ( value) {
          setState(() {
            selectedMode = value;
          });
        },
      );
    });
  }

  // ------------ certification dropdown --------------
  Widget certificationUI() {
    return BlocBuilder<CertificationBloc, CertificationState>(
      builder: (context, certificationState) {
        if(certificationState is CertificationLoading){
          return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
        }
        else if (certificationState is CertificationSuccess) {
          return ListView.builder(
              itemCount: certificationState.certificationList.length,
              itemBuilder: (context, index) {
                final list = certificationState.certificationList[index];
                print("listlistlistlistlistlistlistlistlist$list");
                return RadioListTile(
                  title: Text(list['certName'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr)),
                  value: list['identity'],
                  groupValue: selectedCertification,
                  onChanged: (value) {
                    setState(() {
                      selectedCertification = value;
                    });
                  },
                );
              });
        }
        else if (certificationState is CertificationFail) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CertificationBloc>().add((FetchCertification()));
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(ImagePath().errorMessageImg),
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      certificationState.errorMessage,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  // --------- perks -----------
  Widget perksUI() {
    return BlocBuilder<PerksBloc, PerksState>(
      builder: (context, perkState) {
        if(perkState is PerksLoading){
          return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
        }
        else if (perkState is PerksSuccess) {
          return ListView.builder(
              itemCount: perkState.perksList.length,
              itemBuilder: (context, index) {
                final list = perkState.perksList[index];
                print("listlistlistlistlistlistlistlistlist$list");
                return CheckboxListTile(
                  title: Text(list['perkName'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr)),
                  value: parksValues.contains(list['identity']),
                  onChanged: (value) {
                    setState(() {
                      if(value == true){
                        parksValues.add(list['identity']);
                      } else{
                        parksValues.remove(list['identity']);
                      }
                    });
                  },
                );
              });
        }
        else if (perkState is PerksFail) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CertificationBloc>().add((FetchCertification()));
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(ImagePath().errorMessageImg),
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      perkState.errorMessage,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  // ---------- event type ----------
  Widget eventTypeUI() {
    return BlocBuilder<EventTypeBloc, EventTypeState>(
      builder: (context, eventTypeState) {
        if(eventTypeState is EventTypeLoading){
          return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
        }
        else if (eventTypeState is EventTypeSuccess) {
          return ListView.builder(
              itemCount: eventTypeState.eventTypeList.length,
              itemBuilder: (context, index) {
                final list = eventTypeState.eventTypeList[index];
                print("listlistlistlistlistlistlistlistlist$list");
                return RadioListTile(
                  title: Text(list['name'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr)),
                  value: list['identity'],
                  groupValue: selectedEventType,
                  onChanged: (value) {
                    setState(() {
                      selectedEventType = value;
                    });
                  },
                );
              });
        }
        else if (eventTypeState is EventTypeFail) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CertificationBloc>().add((FetchCertification()));
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(ImagePath().errorMessageImg),
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      eventTypeState.errorMessage,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  // ---------- eligible department ----------
  Widget eligibleDepartmentUI(){
    return BlocBuilder<EligibleDepartmentBloc, EligibleDepartmentState>(
      builder: (context, eligibleDepartmentState) {
        if(eligibleDepartmentState is EligibleDepartmentLoading){
          return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
        }
        else if (eligibleDepartmentState is EligibleDepartmentSuccess) {
          return ListView.builder(
              itemCount: eligibleDepartmentState.eligibleDepartmentList.length,
              itemBuilder: (context, index) {
                final list = eligibleDepartmentState.eligibleDepartmentList[index];
                return CheckboxListTile(
                  value: eligibleDepartmentValues.contains(list['identity']),
                  onChanged: (onChanged) {
                    setState(() {
                      if (onChanged == true) {
                        // --------- when the check box is click then add the identity --------------
                        eligibleDepartmentValues.add(list['identity']);
                      } else {
                        // --------- when the check box is click then remove the identity -----------
                        eligibleDepartmentValues.remove(list['identity']);
                      }
                    });
                  },
                  title: Text(list['name'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr)),
                );
              });
        }
        else if (eligibleDepartmentState is EligibleDepartmentFail) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CertificationBloc>().add((FetchCertification()));
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(ImagePath().errorMessageImg),
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      eligibleDepartmentState.errorMessage,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  // -------------- country,state and city ----------
  Widget locationUI(){
    return Column(
      children: [

        // ------ Country dropdown --------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<CountryBloc, CountryState>(
            builder: (context, countryState) {
              if(countryState is CountryLoading){
                return Center(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(color: MyColor().primaryClr,)),);
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
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          iconEnabledColor: MyColor().primaryClr,
                          hint: Text("Select your Country",style: GoogleFonts.poppins(
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
                          value: selectedCountry,
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
                              selectedCountry = onChanged;
                            });

                            // ---- get a state ------
                            context.read<ChooseStateBloc>().add(FetchChooseState(countryCode: selectedCountry!));
                          },
                          items: countryState.countryList.map((e)=> DropdownMenuItem<String>(value: e['identity'],child: Text(e['name'].toString(),overflow: TextOverflow.ellipsis,))).toList(),
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
        ),

        // ------- state dropdown --------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<ChooseStateBloc, ChooseStateState>(
            builder: (context, chooseState) {
              if (chooseState is ChooseStateLoading) {
                return Center(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(color: MyColor().primaryClr,)),);
              } else if (chooseState is ChooseStateSuccess) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text("State", style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        SizedBox(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            iconEnabledColor: MyColor().primaryClr,
                            hint: Text("Select your State",
                              style: GoogleFonts.poppins(
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
                            value: selectedState,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down,),
                              ),
                              // iconColor: MyColor().primaryClr,
                              contentPadding: EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().borderClr,
                                      width: 0.5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().primaryClr,
                                      width: 0.5)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().redClr, width: 0.5)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().redClr, width: 0.5)
                              ),
                            ),
                            onChanged: (onChanged) {
                              setState(() {
                                selectedState = onChanged;
                              });
                              // ----- get city -----
                              context.read<CityBloc>().add(FetchCity(stateCode: selectedState!));

                            },
                            items: chooseState.stateList.map((e) =>
                                DropdownMenuItem<String>(value: e['identity'],
                                    child: Text(e['name'].toString(),overflow: TextOverflow.ellipsis,)))
                                .toList(),
                            validator: Validators().validState,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (chooseState is ChooseStateFail) {
                return Center(child: Text(chooseState.errorMessage),);
              }
              return SizedBox.shrink();
            },
          ),
        ),

        // ------- city dropdown --------
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: BlocBuilder<CityBloc, CityState>(
            builder: (context, cityState) {
              if (cityState is CityLoading) {
                return Center(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(color: MyColor().primaryClr,)),);
              } else if (cityState is CitySuccess) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text("City", style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        SizedBox(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            iconEnabledColor: MyColor().primaryClr,
                            hint: Text("Select your city",
                              style: GoogleFonts.poppins(
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
                            value: selectedCity,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down,),
                              ),
                              // iconColor: MyColor().primaryClr,
                              contentPadding: EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().borderClr,
                                      width: 0.5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().primaryClr,
                                      width: 0.5)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().redClr, width: 0.5)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: MyColor().redClr, width: 0.5)
                              ),
                            ),
                            onChanged: (onChanged) {
                              selectedCity = onChanged;
                            },
                            items: cityState.cityList.map((e) =>
                                DropdownMenuItem<String>(
                                    value: e['identity'], child: Text(e['name'],overflow: TextOverflow.ellipsis,)))
                                .toList(),
                            validator: Validators().validState,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (cityState is CityFail) {
                return Center(child: Text(cityState.errorMessage),);
              }
              return SizedBox();
            },
          ),
        ),

      ],
    );
  }

  // ------- accommodation --------
  Widget accommodationUI(){
    return BlocBuilder<AccommodationBloc, AccommodationState>(
      builder: (context, accommodationState) {
        if(accommodationState is AccommodationLoading){
          return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
        }
        else if (accommodationState is AccommodationSuccess) {
          return ListView.builder(
              itemCount: accommodationState.accommodationList.length,
              itemBuilder: (context, index) {
                final list = accommodationState.accommodationList[index];
                return CheckboxListTile(
                  value: accommodationValues.contains(list['identity']),
                  onChanged: (onChanged) {
                    setState(() {
                      if (onChanged == true) {
                        // --------- when the check box is click then add the identity --------------
                        accommodationValues.add(list['identity']);
                      } else {
                        // --------- when the check box is click then remove the identity -----------
                        accommodationValues.remove(list['identity']);
                      }
                    });
                  },
                  title: Text(list['accommodationName'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyColor().blackClr)),
                );
              });
        }
        else if (accommodationState is AccommodationFail) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CertificationBloc>().add((FetchCertification()));
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(ImagePath().errorMessageImg),
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      accommodationState.errorMessage,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().blackClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  // --------- date ----------
  Widget dateUi(){
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: MyModels().customDateAndTimeUi(controller: dateTimeController, onTap: () async{
        final result = await DateAndTimeController().selectedDateAndTimePicker(context);
        if(result != null){
          dateTimeController.text = result;
        }
      }, label: 'Select Date & Time'),
    );
  }

}
