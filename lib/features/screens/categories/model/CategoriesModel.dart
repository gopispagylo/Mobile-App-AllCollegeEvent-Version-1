import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class CategoriesModel extends StatefulWidget {
  const CategoriesModel({super.key});

  @override
  State<CategoriesModel> createState() => _CategoriesModelState();
}

class _CategoriesModelState extends State<CategoriesModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Center(
        child: Text("THIS IS A CATEGORIES PAGE",style: TextStyle(),),
      ),
    );
  }
}
