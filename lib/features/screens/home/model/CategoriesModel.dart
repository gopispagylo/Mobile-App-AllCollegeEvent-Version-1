import 'package:all_college_event_app/features/screens/global/bloc/categories/categories_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeCategoriesModel extends StatefulWidget {
  const HomeCategoriesModel({super.key});

  @override
  State<HomeCategoriesModel> createState() => _HomeCategoriesModelState();
}

class _HomeCategoriesModelState extends State<HomeCategoriesModel> {

  List<Map<String, dynamic>> categoriesList = [
    {
      "title": "Hackathon",
      "image": "assets/images/hackathon.png",
      "bgColor": 0xFFE7F7FF,
    },
    {
      "title": "Conference",
      "image": "assets/images/conference.png",
      "bgColor": 0xFFFDF1DC,
    },
    {
      "title": "Athletics",
      "image": "assets/images/athletics.png",
      "bgColor": 0xFFFFE8E8,
    },
    {
      "title": "Competition",
      "image": "assets/images/competition.png",
      "bgColor": 0xFFF4EAFF,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, categoriesState) {
        if(categoriesState is CategoriesLoading){
          return categoryShimmer();
        } else if(categoriesState is CategoriesSuccess){
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,left: 16,right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pick Your Vibe!",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "blMelody"
                    ),),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("See all",style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 0.0),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: Opacity(opacity: 1 - (value / 50), child: child,),);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categoriesList.length, (index) {
                      final list = categoriesState.categoriesList[index];
                      return Container(
                        margin: EdgeInsets.only(left: 16,
                            right: index == categoriesList.length - 1 ? 16 : 0,
                            top: 15),
                        height: 104,
                        width: 104,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(categoriesList[index]['bgColor'])
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.note),
                              Text(list['categoryName'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),),
                            ],
                          ),
                        ),
                      );
                    },),
                  ),
                ),
              ),
            ],
          );
        } else if(categoriesState is CategoriesFail){
          return Center(child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(categoriesState.errorMessage)),);
        } return SizedBox.shrink();
      },
    );
  }


  // ------- skeleton loading ------
  Widget categoryShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Container(
            margin: EdgeInsets.only(top: 20,left: 16,right: index == 6 - 1 ? 16 : 0),
            height: 104,
            width: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon placeholder
                  Shimmer(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Text placeholder
                  Shimmer(
                    child: Container(
                      height: 10,
                      width: 60,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

}
