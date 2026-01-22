import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/orgCategories/org_categories_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/userProfileBloc/user_profile_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/OrganizationCreateDetailModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationCreateDetailPage extends StatefulWidget {
  const OrganizationCreateDetailPage({super.key});

  @override
  State<OrganizationCreateDetailPage> createState() =>
      _OrganizationCreateDetailPageState();
}

class _OrganizationCreateDetailPageState
    extends State<OrganizationCreateDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          "Event Creation Form",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      backgroundColor: MyColor().whiteClr,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrgCategoriesBloc(apiController: ApiController())..add(FetchOrgCategories()),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(apiController: ApiController())..add(ClickedUserProfile(whichUser: 'Organizer')),
          ),
        ],
        child: OrganizationCreateDetailModel(),
      ),
    );
  }
}
