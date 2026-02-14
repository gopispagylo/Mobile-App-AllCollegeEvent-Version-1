import 'dart:io';
import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/auth/forgotPassword/forgotPassword/ui/ForgotPasswordPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/singleImageController/single_image_controller_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userUpdateBloc/user_update_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  // ------- Dropdown select value -----
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String selectedPinCode = "641001";
  String? profileImage;

  // ------ global key -------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ---------- access the value of whichScreen ---------
    final checkUser = widget.whichScreen == 'User';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileBloc(apiController: ApiController())
            ..add(ClickedUserProfile(whichUser: widget.whichScreen, id: '')),
        ),

        BlocProvider(
          create: (context) => UserUpdateBloc(apiController: ApiController()),
        ),

        BlocProvider(create: (context) => SingleImageControllerBloc()),
        // ----- country bloc -----
        BlocProvider(
          create: (context) =>
              CountryBloc(apiController: ApiController())..add(FetchCountry()),
        ),
        // ----- state bloc -----
        BlocProvider(
          create: (context) => ChooseStateBloc(apiController: ApiController()),
        ),
        // ----- city bloc -----
        BlocProvider(
          create: (context) => CityBloc(apiController: ApiController()),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColor().whiteClr,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor().whiteClr.withOpacity(0.05),
                ),
              ),
            ),
          ),
        ),
        body: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, userProfileState) {
            if (userProfileState is UserProfileSuccess) {
              final list = userProfileState.userProfileList[0];

              selectedCity = list['city'];
              selectedState = list['state'];
              selectedCountry = list['country'];

              domainMailController.text = checkUser
                  ? list['email']
                  : list['domainEmail'];
              nameController.text = checkUser
                  ? list['name']
                  : list['organizationName'];

              profileImage = list['profileImage'];

              // -------------- after enter a profile page then fetch a state and city values --------------
              context.read<ChooseStateBloc>().add(
                FetchChooseState(countryCode: selectedCountry!),
              );
              context.read<CityBloc>().add(
                FetchCity(stateCode: selectedState!),
              );
            }
          },
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, userProfileState) {
              if (userProfileState is UserProfileLoading) {
                return profileFormShimmer();
              } else if (userProfileState is UserProfileSuccess) {
                return RefreshIndicator(
                  edgeOffset: 20,
                  backgroundColor: MyColor().whiteClr,
                  color: MyColor().primaryClr,
                  onRefresh: () async {
                    context.read<UserProfileBloc>().add(
                      ClickedUserProfile(whichUser: widget.whichScreen, id: ''),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          // ------ profile image --------
                          Center(
                            child:
                                BlocBuilder<
                                  SingleImageControllerBloc,
                                  SingleImageControllerState
                                >(
                                  builder: (context, profileImageState) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: AlignmentGeometry.center,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: MyColor().boxInnerClr,
                                                border: Border.all(
                                                  color: MyColor().borderClr
                                                      .withOpacity(0.15),
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              clipBehavior: Clip
                                                  .antiAlias, // ensures child respects circle
                                              child:
                                                  profileImageState
                                                          is SingleImageSuccess &&
                                                      profileImageState
                                                              .imagePath
                                                              .path !=
                                                          null
                                                  ? ClipOval(
                                                      child: Image.file(
                                                        File(
                                                          profileImageState
                                                              .imagePath
                                                              .path!,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : (profileImage != null &&
                                                        profileImage!
                                                            .isNotEmpty)
                                                  ? ClipOval(
                                                      child: CachedNetworkImage(
                                                        // memCacheHeight: 300,
                                                        fadeInDuration:
                                                            Duration.zero,
                                                        imageUrl: profileImage!,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => Center(
                                                              child: CircularProgressIndicator(
                                                                color: MyColor()
                                                                    .primaryClr,
                                                              ),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => Icon(
                                                              Iconsax
                                                                  .profile_circle,
                                                              color: MyColor()
                                                                  .borderClr,
                                                              size: 30,
                                                            ),
                                                      ),
                                                    )
                                                  : Icon(
                                                      Iconsax.profile_circle,
                                                      size: 30,
                                                      color:
                                                          MyColor().borderClr,
                                                    ),
                                            ),

                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<
                                                        SingleImageControllerBloc
                                                      >()
                                                      .add(
                                                        ChooseImagePickerSingle(
                                                          source: ImageSource
                                                              .gallery,
                                                        ),
                                                      );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColor().boxInnerClr,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: MyColor().borderClr
                                                          .withOpacity(0.15),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          7.0,
                                                        ),
                                                    child: Icon(
                                                      Iconsax.camera,
                                                      size: 20,
                                                      color:
                                                          MyColor().borderClr,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (profileImageState
                                            is SingleImageSuccess)
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<
                                                    SingleImageControllerBloc
                                                  >()
                                                  .add(RemoveSingleImage());
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      8,
                                                    ),
                                              ),
                                              child: Text(
                                                "Remove",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: MyColor().redClr,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                          ),

                          // --------- basic details ---------
                          Center(
                            child: Container(
                              width: 320,
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
                          ),

                          // --------- email -------------
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

                          // ------ phone number ---------
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

                          // ------ full name ---------
                          MyModels().customTextField(
                            label: "Full Name",
                            controller: nameController,
                            hintText: "Enter your full name",
                            validator: Validators().validName,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            readOnly: widget.whichScreen == 'User'
                                ? false
                                : true,
                          ),

                          // ------ location details ---------
                          Center(
                            child: Container(
                              width: 320,
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
                          ),

                          // ------ ready only for county, state and city  ---------
                          if (widget.whichScreen == 'Organizer')
                            Column(
                              children: [
                                // ----- country read only field ------
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: MyModels().readyOnlyTextField(
                                    value: selectedCountry!,
                                    label: 'Country',
                                  ),
                                ),

                                // ----- state read only field ------
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: MyModels().readyOnlyTextField(
                                    value: selectedState!,
                                    label: 'State',
                                  ),
                                ),

                                // ----- city read only field ------
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: MyModels().readyOnlyTextField(
                                    value: selectedCity!,
                                    label: 'City',
                                  ),
                                ),

                                // ----- pin code -------
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: MyModels().readyOnlyTextField(
                                    value: selectedPinCode,
                                    label: 'Pincode',
                                  ),
                                ),
                              ],
                            ),

                          // ------ drop down for county, state and city ---------
                          if (widget.whichScreen == 'User')
                            Column(
                              children: [
                                // ------ Country dropdown --------
                                BlocBuilder<CountryBloc, CountryState>(
                                  builder: (context, countryState) {
                                    if (countryState is CountryLoading) {
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: CircularProgressIndicator(
                                            color: MyColor().primaryClr,
                                          ),
                                        ),
                                      );
                                    } else if (countryState is CountrySuccess) {
                                      return Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: 12,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "Country",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 320,
                                              child: DropdownButtonFormField<String>(
                                                iconEnabledColor:
                                                    MyColor().primaryClr,
                                                hint: Text(
                                                  "Select your Country",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color:
                                                        MyColor().hintTextClr,
                                                  ),
                                                ),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: MyColor().primaryClr,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                disabledHint: Text("lalalalal"),
                                                iconDisabledColor:
                                                    MyColor().blackClr,
                                                value: selectedCountry,
                                                decoration: InputDecoration(
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          right: 12,
                                                        ),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                    ),
                                                  ),
                                                  // iconColor: MyColor().primaryClr,
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: MyColor()
                                                              .borderClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: MyColor()
                                                              .primaryClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: MyColor().redClr,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              MyColor().redClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                ),
                                                onChanged: (onChanged) {
                                                  // ---- get a state ------
                                                  context
                                                      .read<ChooseStateBloc>()
                                                      .add(
                                                        FetchChooseState(
                                                          countryCode:
                                                              selectedCountry!,
                                                        ),
                                                      );
                                                },
                                                items: countryState.countryList
                                                    .map(
                                                      (e) =>
                                                          DropdownMenuItem<
                                                            String
                                                          >(
                                                            value:
                                                                e['identity'],
                                                            child: Text(
                                                              e['name']
                                                                  .toString(),
                                                            ),
                                                          ),
                                                    )
                                                    .toList(),
                                                validator:
                                                    Validators().validCountry,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (countryState is CountryFail) {
                                      return Text(countryState.errorMessage);
                                    }
                                    return SizedBox.shrink();
                                  },
                                ),

                                // ------- state dropdown --------
                                BlocBuilder<ChooseStateBloc, ChooseStateState>(
                                  builder: (context, chooseState) {
                                    if (chooseState is ChooseStateLoading) {
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: CircularProgressIndicator(
                                            color: MyColor().primaryClr,
                                          ),
                                        ),
                                      );
                                    } else if (chooseState
                                        is ChooseStateSuccess) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 12,
                                                ),
                                                child: Text(
                                                  "State",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 320,
                                                child: DropdownButtonFormField<String>(
                                                  iconEnabledColor:
                                                      MyColor().primaryClr,
                                                  hint: Text(
                                                    "Select your State",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color:
                                                          MyColor().hintTextClr,
                                                    ),
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: MyColor().primaryClr,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  iconDisabledColor:
                                                      MyColor().blackClr,
                                                  value: selectedState,
                                                  decoration: InputDecoration(
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 12,
                                                          ),
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                      ),
                                                    ),
                                                    // iconColor: MyColor().primaryClr,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .borderClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .primaryClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: MyColor().redClr,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .redClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                  ),
                                                  onChanged: (onChanged) {
                                                    setState(() {
                                                      selectedState = onChanged;
                                                    });

                                                    // ----- get city -----
                                                    context
                                                        .read<CityBloc>()
                                                        .add(
                                                          FetchCity(
                                                            stateCode:
                                                                selectedState!,
                                                          ),
                                                        );
                                                  },
                                                  items: chooseState.stateList
                                                      .map(
                                                        (e) =>
                                                            DropdownMenuItem<
                                                              String
                                                            >(
                                                              value:
                                                                  e['identity'],
                                                              child: Text(
                                                                e['name']
                                                                    .toString(),
                                                              ),
                                                            ),
                                                      )
                                                      .toList(),
                                                  validator:
                                                      Validators().validState,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (chooseState is ChooseStateFail) {
                                      return Center(
                                        child: Text(chooseState.errorMessage),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  },
                                ),

                                // ------- city dropdown --------
                                BlocBuilder<CityBloc, CityState>(
                                  builder: (context, cityState) {
                                    if (cityState is CityLoading) {
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: CircularProgressIndicator(
                                            color: MyColor().primaryClr,
                                          ),
                                        ),
                                      );
                                    } else if (cityState is CitySuccess) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 12,
                                                ),
                                                child: Text(
                                                  "City",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 320,
                                                child: DropdownButtonFormField<String>(
                                                  iconEnabledColor:
                                                      MyColor().primaryClr,
                                                  hint: Text(
                                                    "Select your city",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color:
                                                          MyColor().hintTextClr,
                                                    ),
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: MyColor().primaryClr,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  iconDisabledColor:
                                                      MyColor().blackClr,
                                                  value: selectedCity,
                                                  decoration: InputDecoration(
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 12,
                                                          ),
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                      ),
                                                    ),
                                                    // iconColor: MyColor().primaryClr,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .borderClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .primaryClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: MyColor().redClr,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: MyColor()
                                                                    .redClr,
                                                                width: 0.5,
                                                              ),
                                                        ),
                                                  ),
                                                  onChanged: (onChanged) {
                                                    selectedCity = onChanged;
                                                  },
                                                  items: cityState.cityList
                                                      .map(
                                                        (e) =>
                                                            DropdownMenuItem<
                                                              String
                                                            >(
                                                              value: e,
                                                              child: Text(
                                                                e.toString(),
                                                              ),
                                                            ),
                                                      )
                                                      .toList(),
                                                  validator:
                                                      Validators().validState,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (cityState is CityFail) {
                                      return Center(
                                        child: Text(cityState.errorMessage),
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              ],
                            ),

                          // ------- forgot password --------
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgotPasswordPage(
                                    whichScreen: widget.whichScreen == "User"
                                        ? 'user'
                                        : 'organizerLogin',
                                  ),
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 320,
                                margin: EdgeInsets.only(top: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Iconsax.lock,
                                      size: 18,
                                      color: MyColor().primaryClr,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "Change Password?",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: MyColor().primaryClr,
                                      ),
                                    ),
                                  ],
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
                                      final state = context
                                          .read<SingleImageControllerBloc>()
                                          .state;

                                      PlatformFile? image;

                                      if (state is SingleImageSuccess) {
                                        image = state.imagePath;
                                      }

                                      // if (formKey.currentState!.validate()) {
                                      context.read<UserUpdateBloc>().add(
                                        ClickUserUpdate(
                                          userState: selectedState ?? '',
                                          city: selectedCity ?? '',
                                          country: selectedCountry ?? '',
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          whichUser:
                                              widget.whichScreen == 'Organizer'
                                              ? 'org'
                                              : 'user',
                                          profileImage: image,
                                        ),
                                      );
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
                  edgeOffset: 20,
                  backgroundColor: MyColor().whiteClr,
                  color: MyColor().primaryClr,
                  onRefresh: () async {
                    context.read<UserProfileBloc>().add(
                      ClickedUserProfile(whichUser: widget.whichScreen, id: ''),
                    );
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
