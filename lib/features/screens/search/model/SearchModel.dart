import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';

class SearchModel extends StatefulWidget {
  const SearchModel({super.key});

  @override
  State<SearchModel> createState() => _SearchModelState();
}

class _SearchModelState extends State<SearchModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: Center(
        child: Text("THIS IS A SEARCH PAGE",style: TextStyle(),),
      ),
    );
  }
}
