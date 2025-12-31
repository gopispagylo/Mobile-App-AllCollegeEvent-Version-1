import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/auth/organizer/signUp/model/OrganizationDetailModel.dart';
import 'package:all_college_event_app/features/screens/global/bloc/chooseStateBloc/choose_state_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/cityBloc/city_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/countryBloc/country_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationDetailPage extends StatefulWidget {
  final String categories;
  final String type;

  const OrganizationDetailPage(
      {super.key, required this.categories, required this.type});

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
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
        child: OrganizationDetailModel(
          categories: widget.categories, type: widget.type,),
      ),
    );
  }
}
