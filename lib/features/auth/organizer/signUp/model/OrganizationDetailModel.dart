import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/organizer/signUp/ui/AccountCreationPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationDetailModel extends StatefulWidget {
  final String categories;
  final String type;

  const OrganizationDetailModel({super.key, required this.categories,required this.type});

  @override
  State<OrganizationDetailModel> createState() => _OrganizationDetailModelState();
}

class _OrganizationDetailModelState extends State<OrganizationDetailModel> {

  // ------ Controller ------
  final nameController = TextEditingController();

  // Global Key
  final formKey = GlobalKey<FormState>();


  // ------- Dropdown select value -----
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(
            ImagePath().backgroundImg, fit: BoxFit.cover)),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20,left: 16,right: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.menu,color: MyColor().blackClr,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nCategory",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().primaryBackgroundClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().primaryClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person,size: 18,color: MyColor().primaryClr,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nDetails",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.check_circle_outline,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Account\nCreation",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Image.asset(ImagePath().orgSignUpImg),
                ),
                
                Text(
                  textAlign: TextAlign.center,
                  "Organization Details",
                  style: TextStyle(
                    fontFamily: "blMelody",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                // ------ Country dropdown --------
                BlocBuilder<CountryBloc, CountryState>(
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
                              width: 320,
                              child: DropdownButtonFormField<String>(
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

                // ------- state dropdown --------
                BlocBuilder<ChooseStateBloc, ChooseStateState>(
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
                                width: 320,
                                child: DropdownButtonFormField<String>(
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
                                    context.read<CityBloc>().add(FetchCity(
                                        stateCode: selectedState!,
                                        countryCode: selectedCountry!));
                                  },
                                  items: chooseState.stateList.map((e) =>
                                      DropdownMenuItem<String>(value: e['name'],
                                          child: Text(e['name'].toString())))
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


                // ------- city dropdown --------
                BlocBuilder<CityBloc, CityState>(
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
                                width: 320,
                                child: DropdownButtonFormField<String>(
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
                                          value: e, child: Text(e.toString())))
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
                
                // ------ Organization Name --------
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: MyModels().customTextField(
                    label: "Organization Name",
                    controller: nameController,
                    hintText: "Enter Organization Name",
                    validator: Validators().validName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false,
                  ),
                ),


                SizedBox(height: 30),

                // -------- Button ----------
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 48),
                      elevation: 0,
                      backgroundColor: MyColor().primaryClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(50),
                      ),
                    ),
                    onPressed: () {
                      // if(formKey.currentState!.validate()){
                      //   context.read<SignUpBloc>().add(ClickedSignUp(name: nameController.text, email: emailController.text, password: passwordController.text, type: widget.whichScreen));
                      // }
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> AccountCreationPage(country: selectedCountry ?? "", city: selectedCity ?? "", state: selectedState ?? "", orgName: nameController.text, categories: widget.categories, type: widget.type,)));
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyColor().whiteClr,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account!?", style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Sign In", style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: MyColor().primaryClr,
                          fontWeight: FontWeight.w600
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
