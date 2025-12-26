import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userUpdateBloc/user_update_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/ResetPasswordModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class EditProfileModel extends StatefulWidget {
  final String whichScreen;

  const EditProfileModel({super.key, required this.whichScreen});

  @override
  State<EditProfileModel> createState() => _EditProfileModelState();
}

class _EditProfileModelState extends State<EditProfileModel> {
  // -------- Controller ---------
  final nameController = TextEditingController();
  final domainMailController = TextEditingController();
  final phoneController = TextEditingController();

  // ----- Country -------
  List<Map<String, String>> countryList = [
    {"country": "India", "code": "IN"},
    {"country": "United States", "code": "US"},
    {"country": "Japan", "code": "JP"},
    {"country": "Germany", "code": "DE"},
    {"country": "Australia", "code": "AU"},
  ];

  // -------- City -------
  List<Map<String, String>> cityList = [
    {"city": "Mumbai", "code": "MB"},
    {"city": "New York", "code": "NY"},
    {"city": "Tokyo", "code": "TK"},
    {"city": "Sydney", "code": "SY"},
    {"city": "Paris", "code": "PR"},
  ];

  // --------- State ---------
  List<Map<String, String>> stateList = [
    {"state": "Maharashtra", "code": "MH"},
    {"state": "California", "code": "CA"},
    {"state": "New South Wales", "code": "NSW"},
    {"state": "Karnataka", "code": "KA"},
    {"state": "Bavaria", "code": "BY"},
  ];

  // ------- Dropdown select value -----
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  // ------ global key -------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ---------- access the value of whichScreen ---------
    final checkUser = widget.whichScreen == 'User';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserProfileBloc(apiController: ApiController())
                ..add(ClickedUserProfile()),
        ),
        BlocProvider(
          create: (context) => UserUpdateBloc(apiController: ApiController()),
        ),
      ],
      child: Scaffold(
        backgroundColor: MyColor().whiteClr,
        appBar: AppBar(
          backgroundColor: MyColor().whiteClr,
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
        ),
        body: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, userProfileState) {
            if (userProfileState is UserProfileSuccess) {
              final list = userProfileState.userProfileList[0];

              setState(() {
                selectedCity = list['city'];
                selectedState = list['state'];
                selectedCountry = list['country'];

                domainMailController.text = checkUser
                    ? list['email']
                    : list['domainEmail'];
                nameController.text = checkUser
                    ? list['name']
                    : list['organizationName'];
              });
            }
          },
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, userProfileState) {
              if (userProfileState is UserProfileLoading) {
                return profileFormShimmer();
              } else if (userProfileState is UserProfileSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<UserProfileBloc>().add(ClickedUserProfile());
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyColor().boxInnerClr,
                              border: Border.all(
                                color: MyColor().borderClr.withOpacity(0.15),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              "Basic Details",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ),
                          MyModels().customTextField(
                            label: checkUser ? "Email ID" : "Domain Email ID",
                            controller: domainMailController,
                            hintText: checkUser
                                ? "Enter your mail id"
                                : "Enter your domain mail id",
                            validator: checkUser
                                ? Validators().validEmail
                                : Validators().validDomainMail,
                            textInputType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            readOnly: true,
                          ),
                          SizedBox(height: 20),
                          MyModels().customTextField(
                            label: "Phone number",
                            controller: phoneController,
                            hintText: "Enter your phone number",
                            validator: Validators().validName,
                            textInputType: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            readOnly: false,
                          ),
                          SizedBox(height: 20),
                          MyModels().customTextField(
                            label: "Full Name",
                            controller: nameController,
                            hintText: "Enter your full name",
                            validator: Validators().validName,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            readOnly: false,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              "Location details",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ),

                          // ------ Country --------
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: MyModels().customDropdown(
                              label: "Country",
                              hint: "Select your Country",
                              value: selectedCountry,
                              onChanged: (onChanged) {
                                setState(() {
                                  selectedCountry = onChanged;
                                });
                                print(
                                  "selectedCountryselectedCountryselectedCountryselectedCountryselectedCountry$selectedCountry",
                                );
                              },
                              items: countryList
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e['country'],
                                      child: Text(e['country'].toString()),
                                    ),
                                  )
                                  .toList(),
                              valid: Validators().validCountry,
                            ),
                          ),

                          // ------ State --------
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: MyModels().customDropdown(
                              label: "State",
                              hint: "Select your State",
                              value: selectedState,
                              onChanged: (onChanged) {
                                setState(() {
                                  selectedState = onChanged;
                                });
                                print(
                                  "selectedStateselectedStateselectedStateselectedStateselectedState$selectedState",
                                );
                              },
                              items: stateList
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e['state'],
                                      child: Text(e['state'].toString()),
                                    ),
                                  )
                                  .toList(),
                              valid: Validators().validState,
                            ),
                          ),

                          // ------ City --------
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: MyModels().customDropdown(
                              label: "City",
                              hint: "Select your City",
                              value: selectedCity,
                              onChanged: (onChanged) {
                                setState(() {
                                  selectedCity = onChanged;
                                });
                                print(
                                  "selectedCityselectedCityselectedCityselectedCityselectedCity$selectedCity",
                                );
                              },
                              items: cityList
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e['city'],
                                      child: Text(e['city'].toString()),
                                    ),
                                  )
                                  .toList(),
                              valid: Validators().validCity,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ResetPasswordModel(),
                                ),
                              );
                            },
                            child: Container(
                              width: 320,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: MyColor().primaryClr,
                                ),
                              ),
                            ),
                          ),

                          BlocListener<UserUpdateBloc, UserUpdateState>(
                            listener: (context, userUpdateState) {
                              if (userUpdateState is UserUpdateSuccess) {
                                FlutterToast().flutterToast(
                                  "Successfully Updated",
                                  ToastificationType.success,
                                  ToastificationStyle.flat,
                                );
                                Navigator.pop(context);
                              } else if (userUpdateState is UserUpdateFail) {
                                FlutterToast().flutterToast(
                                  userUpdateState.errorMessage,
                                  ToastificationType.error,
                                  ToastificationStyle.flat,
                                );
                              }
                            },
                            child: BlocBuilder<UserUpdateBloc, UserUpdateState>(
                              builder: (context, userUpdateState) {
                                return Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(320, 48),
                                      backgroundColor: MyColor().primaryClr,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      // if (formKey.currentState!.validate()) {
                                        context.read<UserUpdateBloc>().add(
                                            ClickUserUpdate(
                                                state: selectedState ?? '',
                                                city: selectedCity ?? '',
                                                country: selectedCountry ?? '',
                                                phone: phoneController.text,
                                                name: nameController.text));
                                      // }
                                    },
                                    child: userUpdateState is UserUpdateLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: MyColor().whiteClr,
                                            ),
                                          )
                                        : Text(
                                            "Save Changes",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor().whiteClr,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (userProfileState is UserProfileFail) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<UserProfileBloc>().add(ClickedUserProfile());
                  },
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 250,
                            child: Image.asset(ImagePath().errorMessageImg),
                          ),
                        ),
                        Center(
                          child: Text(
                            "No Results Found",
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
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

// -------- loading skeleton loader --------
Widget profileFormShimmer() {
  return Container(
    margin: const EdgeInsets.all(16),
    child: ListView(
      children: [
        // ---------- Profile Image ----------
        Center(
          child: Shimmer(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ---------- Section Title ----------
        Shimmer(
          child: Container(
            height: 18,
            width: 140,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ---------- Email Field ----------
        _shimmerTextField(),

        const SizedBox(height: 20),

        // ---------- Phone Field ----------
        _shimmerTextField(),

        const SizedBox(height: 20),

        // ---------- Full Name Field ----------
        _shimmerTextField(),

        const SizedBox(height: 30),

        // ---------- Location Title ----------
        Shimmer(
          child: Container(
            height: 18,
            width: 160,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ---------- Country Dropdown ----------
        _shimmerDropdown(),

        const SizedBox(height: 20),

        // ---------- State Dropdown ----------
        _shimmerDropdown(),

        const SizedBox(height: 20),

        // ---------- City Dropdown ----------
        _shimmerDropdown(),

        const SizedBox(height: 20),

        // ---------- Forgot Password ----------
        Align(
          alignment: Alignment.centerRight,
          child: Shimmer(
            child: Container(
              height: 14,
              width: 120,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // ---------- Save Button ----------
        Shimmer(
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _shimmerTextField() {
  return Shimmer(
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        color: MyColor().sliderDotClr,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

Widget _shimmerDropdown() {
  return Shimmer(
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        color: MyColor().sliderDotClr,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
