import 'dart:io';
import 'dart:ui';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/global/bloc/multipleImageController/image_controller_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userUpdateBloc/user_update_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class SocialLinksModel extends StatefulWidget {
  final String whichScreen;

  const SocialLinksModel({super.key, required this.whichScreen});

  @override
  State<SocialLinksModel> createState() => _SocialLinksModelState();
}

class _SocialLinksModelState extends State<SocialLinksModel> {
  // -------- Controllers -------
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final faceBookController = TextEditingController();
  final twitterController = TextEditingController();
  final youtubeController = TextEditingController();
  final telegramController = TextEditingController();

  @override
  void dispose() {
    linkedInController.dispose();
    instagramController.dispose();
    faceBookController.dispose();
    twitterController.dispose();
    youtubeController.dispose();
    telegramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "Manage Page",
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ImageControllerBloc()),
          BlocProvider(
            create: (context) => UserUpdateBloc(apiController: ApiController()),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(apiController: ApiController())
              ..add(ClickedUserProfile(whichUser: widget.whichScreen, id: '')),
          ),
        ],
        child: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, getOrgDetailState) {
            if (getOrgDetailState is UserProfileSuccess) {
              final socialLink =
                  getOrgDetailState.userProfileList[0]['socialLinks'];

              linkedInController.text = socialLink['linkedin'];
              instagramController.text = socialLink['instagram'];
              faceBookController.text = socialLink['facebook'];
              twitterController.text = socialLink['x'];
              youtubeController.text = socialLink['youtube'];
              telegramController.text = socialLink['telegram'];
            }
          },
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, getOrgDetailState) {
              if (getOrgDetailState is UserProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (getOrgDetailState is UserProfileSuccess) {
                final socialLink =
                    getOrgDetailState.userProfileList[0]['socialLinks'];
                return Center(
                  child: ListView(
                    children: [
                      // ---- multiple image -----
                      Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
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
                                  final bloc = context
                                      .read<ImageControllerBloc>();
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
                                      if (imageMultipleState
                                          is ImageMultipleLoading)
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
                                                        BorderRadiusGeometry.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          8,
                                                        ),
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
                                                          .read<
                                                            ImageControllerBloc
                                                          >()
                                                          .add(
                                                            RemoveImageMultiple(
                                                              index: index,
                                                            ),
                                                          );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
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

                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: MyModels().customSocialMedia(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImagePath().linkedIn,
                              height: 20,
                            ),
                          ),
                          controller: linkedInController,
                          hintText: 'Enter your linked in url',
                          label: 'Linkedin',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: MyModels().customSocialMedia(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImagePath().instagram,
                              height: 20,
                            ),
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
                            child: Image.asset(
                              ImagePath().facebook,
                              height: 20,
                            ),
                          ),
                          controller: faceBookController,
                          hintText: 'Enter your facebook url',
                          label: 'Facebook',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: MyModels().customSocialMedia(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(ImagePath().twitter, height: 20),
                          ),
                          controller: twitterController,
                          hintText: 'Enter your twitter url',
                          label: 'Twitter',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: MyModels().customSocialMedia(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(ImagePath().youtube, height: 20),
                          ),
                          controller: youtubeController,
                          hintText: 'Enter your youtube url',
                          label: 'Youtube',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: MyModels().customSocialMedia(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImagePath().telegram,
                              height: 20,
                            ),
                          ),
                          controller: telegramController,
                          hintText: 'Enter your telegram url',
                          label: 'Telegram',
                        ),
                      ),
                      SizedBox(height: 30),

                      BlocConsumer<UserUpdateBloc, UserUpdateState>(
                        listener: (context, userUpdateState) {
                          if (userUpdateState is SocialLinkOrganizerSuccess) {
                            // ---- Success toast -----
                            FlutterToast().flutterToast(
                              "Successfully Updated 🚀",
                              ToastificationType.success,
                              ToastificationStyle.flat,
                            );

                            // ---- after showing completed the dialog then back to profile page ----
                            Navigator.pop(context);
                          } else if (userUpdateState
                              is SocialLinkOrganizerFail) {
                            FlutterToast().flutterToast(
                              userUpdateState.errorMessage,
                              ToastificationType.error,
                              ToastificationStyle.flat,
                            );
                          }
                        },
                        builder: (context, userUpdateState) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(320, 48),
                                  backgroundColor: MyColor().primaryClr,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  // -------- social link -------
                                  context.read<UserUpdateBloc>().add(
                                    SocialLinkOrganizer(
                                      socialLink: {
                                        if (socialLink['instagram'] !=
                                                instagramController.text &&
                                            instagramController.text.isNotEmpty)
                                          "instagram": instagramController.text,
                                        if (socialLink['youtube'] !=
                                                youtubeController.text &&
                                            youtubeController.text.isNotEmpty)
                                          "youtube": youtubeController.text,
                                        if (socialLink['x'] !=
                                                twitterController.text &&
                                            twitterController.text.isNotEmpty)
                                          "x": twitterController.text,
                                        if (socialLink['facebook'] !=
                                                faceBookController.text &&
                                            faceBookController.text.isNotEmpty)
                                          'facebook': faceBookController.text,
                                        if (socialLink['telegram'] !=
                                                telegramController.text &&
                                            telegramController.text.isNotEmpty)
                                          'telegram': telegramController.text,
                                        if (socialLink['linkedin'] !=
                                                linkedInController.text &&
                                            linkedInController.text.isNotEmpty)
                                          'linkedin': linkedInController.text,
                                      },
                                      whichUser: 'org',
                                    ),
                                  );
                                },
                                child:
                                    userUpdateState
                                        is SocialLinkOrganizerLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: MyColor().whiteClr,
                                        ),
                                      )
                                    : Text(
                                        "Update",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColor().whiteClr,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (getOrgDetailState is UserProfileFail) {
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
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
