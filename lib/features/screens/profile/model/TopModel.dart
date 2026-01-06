import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class TopModel extends StatefulWidget {
  final String whichScreen;

  const TopModel({super.key, required this.whichScreen});

  @override
  State<TopModel> createState() => _ProfileModelState();
}

class _ProfileModelState extends State<TopModel> {
  @override
  Widget build(BuildContext context) {

    // ---------- access the value of whichScreen ---------
    final checkUser = widget.whichScreen == 'User';

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, userProfileState) {
        if(userProfileState is UserProfileLoading){
          return profileHeaderShimmer();
        } else if(userProfileState is UserProfileSuccess){
          final list = userProfileState.userProfileList[0];
          return Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [

                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: list['profileImage'] ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Iconsax.profile_circle,
                        color: MyColor().borderClr,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  textAlign: TextAlign.center,
                  list['name'] ?? list['organizationName'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: "blMelody",
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  textAlign: TextAlign.center,
                  checkUser ? "User" : "Organizer",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: MyColor().borderClr,
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ---------- only show for organizer ----------
                    if (!checkUser)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColor().boxInnerClr,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: MyColor().borderClr.withOpacity(0.15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "2K",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: MyColor().primaryClr,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!checkUser) SizedBox(width: 3),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "1K",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: MyColor().primaryClr,
                              ),
                            ),
                            Text(
                              "Following",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!checkUser) SizedBox(width: 3),
                    // ---------- only show for organizer ----------
                    if (!checkUser)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColor().boxInnerClr,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: MyColor().borderClr.withOpacity(0.15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "2nd",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: MyColor().primaryClr,
                                ),
                              ),
                              Text(
                                "Rank",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!checkUser) SizedBox(width: 3),
                    // ---------- only show for organizer ----------
                    if (!checkUser)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColor().boxInnerClr,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: MyColor().borderClr.withOpacity(0.15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "546",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: MyColor().primaryClr,
                                ),
                              ),
                              Text(
                                "Reviews",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        } else if(userProfileState is UserProfileFail){
          return Center(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
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
                    userProfileState.errorMessage,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: MyColor().blackClr,
                    ),
                  ),
                ),
              ],
            ),
          );
        } return SizedBox.shrink();
      },
    );
  }
}

  // ---------- Skeleton loading ui model -------
  Widget profileHeaderShimmer() {
  return Column(
    children: [
      // Profile Image
      Shimmer(child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: MyColor().sliderDotClr,
          shape: BoxShape.circle),),),

      const SizedBox(height: 8),

      // Name
      Shimmer(child: Container(width: 160,
        height: 22,
        decoration: BoxDecoration(color: MyColor().sliderDotClr,borderRadius: BorderRadius.circular(4),),),),

      const SizedBox(height: 6),

      // Role (User / Organizer)
      Shimmer(child: Container(
        height: 18,
        width: 90,
        decoration: BoxDecoration(color: MyColor().sliderDotClr,borderRadius: BorderRadius.circular(4),),),),

      const SizedBox(height: 20),
    ],
  );
}
