import 'dart:io';

import 'package:all_college_event_app/features/screens/global/bloc/popularCityCountry/popular_city_country_bloc.dart';
import 'package:all_college_event_app/features/screens/home/model/LocationModel.dart';
import 'package:all_college_event_app/features/screens/home/model/PopularCityCountryDetail.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesAndCitiesModel extends StatefulWidget {
  final bool isLogin;

  const CountriesAndCitiesModel({super.key, required this.isLogin});

  @override
  State<CountriesAndCitiesModel> createState() =>
      _CountriesAndCitiesModelState();
}

class _CountriesAndCitiesModelState extends State<CountriesAndCitiesModel>
    with SingleTickerProviderStateMixin {
  // Tab Controller
  late TabController tabController;

  List<Map<String, String>> countries = [
    {
      "name": "United States",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "India",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "China",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "United Kingdom",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Germany",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Japan",
      "flag":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
  ];

  List<Map<String, String>> topCities = [
    {
      "name": "New York",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Tokyo",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "London",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Paris",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Dubai",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
    {
      "name": "Singapore",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",
    },
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 16, right: 6),
            child: Text(
              "Explore Places Around the World",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: "blMelody",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: TabBar(
              dividerHeight: 0,
              indicatorColor: MyColor().primaryClr,
              labelColor: MyColor().blackClr,
              labelStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: MyColor().blackClr,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(child: Text("Popular Countries")),
                Tab(child: Text("Popular Cities")),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 400,
              child: BlocBuilder<PopularCityCountryBloc, PopularCityCountryState>(
                builder: (context, popularCityState) {
                  if (popularCityState is LoadingPopularCityCountry) {
                    return Center(
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              color: MyColor().primaryClr,
                            )
                          : CupertinoActivityIndicator(
                              color: MyColor().primaryClr,
                            ),
                    );
                  } else if (popularCityState is SuccessPopularCityCountry) {
                    final listCountry =
                        popularCityState.cityCountryList['countries'];
                    final listCity = popularCityState.cityCountryList['cities'];

                    return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // First Tab Bar View
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom: 30,
                                  ),
                                  itemCount: listCountry.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 32,
                                        mainAxisSpacing: 16,
                                      ),
                                  itemBuilder: (context, index) {
                                    final list = listCountry[index];
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                PopularCityCountryDetail(
                                                  isLogin: widget.isLogin,
                                                  country: 'country',
                                                  countryCode:
                                                      list['countryIdentity'],
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColor().boxInnerClr,
                                          border: Border.all(
                                            color: MyColor().borderClr
                                                .withOpacity(0.15),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: MyColor().primaryClr,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    height: 50,
                                                    width: 50,
                                                    fadeInDuration:
                                                        Duration.zero,
                                                    imageUrl:
                                                        listCountry[index]['flagImageUrl'],
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) {
                                                      return Text(
                                                        listCountry[index]['countryName'][0],
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18,
                                                              color: MyColor()
                                                                  .whiteClr,
                                                            ),
                                                      );
                                                    },
                                                    placeholder: (context, url) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color: MyColor()
                                                                  .primaryClr,
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: Text(
                                                  listCountry[index]['countryName'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${listCountry[index]['count']} Events",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LocationModel(),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 48,
                                      width: 130,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: MyColor().boxInnerClr,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Text(
                                        "View All",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Second Tab Bar View
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom: 30,
                                  ),
                                  itemCount: listCity.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 32,
                                        mainAxisSpacing: 16,
                                      ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: MyColor().boxInnerClr,
                                        border: Border.all(
                                          color: MyColor().borderClr
                                              .withOpacity(0.15),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: MyColor().primaryClr,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                listCity[index]['cityName'][0],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: MyColor().whiteClr,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              listCity[index]['cityName'],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${listCity[index]['count']} Events",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LocationModel(),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 48,
                                      width: 130,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: MyColor().boxInnerClr,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Text(
                                        "View All",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (popularCityState is FailPopularCityCountry) {
                    return Center(
                      child: Text(
                        popularCityState.errorMessage,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
