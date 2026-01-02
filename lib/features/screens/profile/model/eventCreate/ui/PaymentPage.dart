import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateBloc/event_create_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/model/PaymentModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final Map<String,dynamic> orgDetailList;

  const PaymentPage({super.key, required this.orgDetailList});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
      body: BlocProvider(
        create: (context) => EventCreateBloc(apiController: ApiController()),
        child: PaymentModel(orgDetailList: widget.orgDetailList,),
      ),
    );
  }
}
