import 'dart:io';

import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/global/bloc/multipleImageController/image_controller_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/accommodation/accommodation_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/certification/certification_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/perks/perks_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/PaymentPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:toastification/toastification.dart';

class MediaAndTicketsModel extends StatefulWidget {
  final Map<String, dynamic> orgDetailList;

  const MediaAndTicketsModel({super.key, required this.orgDetailList});

  @override
  State<MediaAndTicketsModel> createState() => _MediaAndTicketsModelState();
}

class _MediaAndTicketsModelState extends State<MediaAndTicketsModel> {
  // -------- Controllers -------
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final whatsappController = TextEditingController();
  final webSiteController = TextEditingController();
  final eventVideoController = TextEditingController();

  // ------- dropdown value ----
  String? perksValue;
  String? certificationValue;
  String? accommodationValue;

  List<String> perksList = [];
  List<String> accommodationList = [];

  // ------- form global key -------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 10),
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
                              backgroundColor: MyColor().borderClr.withOpacity(
                                0.30,
                              ),
                              valueColor: AlwaysStoppedAnimation(
                                MyColor().primaryClr,
                              ),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Organization Details",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: MyColor().blackClr,
                          ),
                        ),
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
                              value: 1,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(
                                0.30,
                              ),
                              valueColor: AlwaysStoppedAnimation(
                                MyColor().primaryClr,
                              ),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Event Details",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: MyColor().blackClr,
                          ),
                        ),
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
                              backgroundColor: MyColor().borderClr.withOpacity(
                                0.30,
                              ),
                              valueColor: AlwaysStoppedAnimation(
                                MyColor().primaryClr,
                              ),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Media & Tickets",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---- multiple image -----
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
            ),
            child: BlocListener<ImageControllerBloc, ImageControllerState>(
              listener: (context, imageMultipleState) {
                if (imageMultipleState is ImageMultipleFail) {
                  FlutterToast().flutterToast(
                    imageMultipleState.errorMessage,
                    ToastificationType.error,
                    ToastificationStyle.flat,
                  );
                }
              },
              child: BlocBuilder<ImageControllerBloc, ImageControllerState>(
                builder: (context, imageMultipleState) {
                  List<PlatformFile> images = [];

                  if (imageMultipleState is ImageMultipleSuccess) {
                    images = imageMultipleState.getMultipleImages;
                  }

                  return GestureDetector(
                    onTap: () {
                      final bloc = context.read<ImageControllerBloc>();
                      if (bloc.getMultipleImages.length >= 4) {
                        FlutterToast().flutterToast(
                          "You can only select up to 4 images",
                          ToastificationType.error,
                          ToastificationStyle.flat,
                        );
                      } else {
                        context.read<ImageControllerBloc>().add(
                          ChooseImagePickerMultiple(
                            source: ImageSource.gallery,
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            Iconsax.document_cloud,
                            color: MyColor().borderClr,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Choose a file or drag & drop it here.",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: MyColor().blackClr,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            textAlign: TextAlign.center,
                            "JPEG/JPG/PNG must be 1200×480 px or 1:1 ratio, and under 500 kb",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: MyColor().borderClr,
                            ),
                          ),

                          // ------ show a image ---------
                          if (imageMultipleState is ImageMultipleLoading)
                            Center(
                              child: CircularProgressIndicator(
                                color: MyColor().primaryClr,
                              ),
                            ),
                          if (images.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                              itemCount: images.length,
                              itemBuilder: (BuildContext context, int index) {
                                final list = images[index];
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: MyColor().borderClr
                                              .withOpacity(0.15),
                                        ),
                                        borderRadius:
                                            BorderRadiusGeometry.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(8),
                                        child: Image.file(
                                          File(list.path!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ImageControllerBloc>()
                                              .add(
                                                RemoveImageMultiple(
                                                  index: index,
                                                ),
                                              );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Iconsax.close_circle,
                                            color: MyColor().redClr,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // --------- social media --------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MyModels().customSocialMedia(
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagePath().whatsapp, height: 20),
                      ),
                      controller: whatsappController,
                      hintText: 'Enter your whatsapp in url',
                      label: 'Whats App',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MyModels().customSocialMedia(
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagePath().linkedIn, height: 20),
                      ),
                      controller: linkedInController,
                      hintText: 'Enter your linked in url',
                      label: 'LinkedIn',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MyModels().customSocialMedia(
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagePath().instagram, height: 20),
                      ),
                      controller: instagramController,
                      hintText: 'Enter your instagram url',
                      label: 'Instagram',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MyModels().customSocialMedia(
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagePath().website, height: 20),
                      ),
                      controller: webSiteController,
                      hintText: 'Enter your website url',
                      label: 'Website',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MyModels().customSocialMedia(
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagePath().video, height: 20),
                      ),
                      controller: eventVideoController,
                      hintText: 'Enter your event video url',
                      label: 'Event Video',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ------- perks dropdown -----
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<PerksBloc, PerksState>(
                builder: (context, perksState) {
                  if (perksState is PerksLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColor().primaryClr,
                      ),
                    );
                  } else if (perksState is PerksSuccess) {
                    return MyModels().customDropdown(
                      label: "Perks *",
                      hint: "Select Perks Type",
                      value: perksValue,
                      onChanged: (onChanged) {
                        setState(() {
                          perksList.add(onChanged);
                          // perksValue = onChanged;
                        });
                      },
                      items: perksState.perksList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e['identity'],
                              child: Text(e['perkName']),
                            ),
                          )
                          .toList(),
                      valid: Validators().validPerks,
                    );
                  } else if (perksState is PerksFail) {
                    return Text(perksState.errorMessage);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),

          SizedBox(height: 20),

          // --------- Certification -------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<CertificationBloc, CertificationState>(
                builder: (context, certificationState) {
                  if (certificationState is CertificationLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColor().primaryClr,
                      ),
                    );
                  } else if (certificationState is CertificationSuccess) {
                    return MyModels().customDropdown(
                      label: "Certification *",
                      hint: "Select Certification Type",
                      value: certificationValue,
                      onChanged: (onChanged) {
                        setState(() {
                          certificationValue = onChanged;
                        });
                      },
                      items: certificationState.certificationList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e['identity'],
                              child: Text(e['certName']),
                            ),
                          )
                          .toList(),
                      valid: Validators().validPerks,
                    );
                  } else if (certificationState is CertificationFail) {
                    return Text(certificationState.errorMessage);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),

          SizedBox(height: 20),

          // --------- Accommodation -------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<AccommodationBloc, AccommodationState>(
                builder: (context, accommodationState) {
                  if (accommodationState is AccommodationLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColor().primaryClr,
                      ),
                    );
                  } else if (accommodationState is AccommodationSuccess) {
                    return MyModels().customDropdown(
                      label: "Accommodation *",
                      hint: "Select Accommodation Type",
                      value: accommodationValue,
                      onChanged: (onChanged) {
                        setState(() {
                          accommodationList.add(onChanged);
                          // accommodationValue = onChanged;
                        });
                        print(
                          "accommodationListaccommodationListaccommodationListaccommodationList$accommodationList",
                        );
                      },
                      items: accommodationState.accommodationList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e['identity'],
                              child: Text(e['accommodationName']),
                            ),
                          )
                          .toList(),
                      valid: Validators().validPerks,
                    );
                  } else if (accommodationState is AccommodationFail) {
                    return Text(accommodationState.errorMessage);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),

          SizedBox(height: 20),

          // ------- back & Continue -------
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Row(
              children: [
                // ------- Save & Continue -------
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 20, right: 0),
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor().whiteClr,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: MyColor().primaryClr),
                        ),
                        child: Text(
                          "Back",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MyColor().primaryClr,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final images = context.read<ImageControllerBloc>().state;

                      List<PlatformFile> getImages = [];

                      if (images is ImageMultipleSuccess) {
                        getImages = images.getMultipleImages;
                      }

                      print(
                        "dkjfsdhjkdsjhkdfsjhkdsfhjkdsfjhkdsfjhk${getImages}",
                      );

                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentPage(
                              orgDetailList: {
                                ...widget.orgDetailList,

                                if (linkedInController.text.isNotEmpty)
                                  'socialLinks': {
                                    "whatsapp": whatsappController.text,
                                    "instagram": instagramController.text,
                                    "linkedin": linkedInController.text,
                                  },
                                'perkIdentities': perksList,
                                'accommodationIdentities': accommodationList,
                                'certIdentity': certificationValue,
                                'bannerImages': getImages,
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 20, right: 0),
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor().primaryClr,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: MyColor().primaryClr),
                        ),
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
