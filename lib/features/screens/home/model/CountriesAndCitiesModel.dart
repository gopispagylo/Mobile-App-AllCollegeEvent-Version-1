import 'package:all_college_event_app/features/screens/home/model/LocationModel.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesAndCitiesModel extends StatefulWidget {
  const CountriesAndCitiesModel({super.key});

  @override
  State<CountriesAndCitiesModel> createState() => _CountriesAndCitiesModelState();
}

class _CountriesAndCitiesModelState extends State<CountriesAndCitiesModel> with SingleTickerProviderStateMixin {

  // Tab Controller
  late TabController tabController;

  List<Map<String, String>> countries = [
    {
      "name": "United States",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "India",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "China",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "United Kingdom",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Germany",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Japan",
      "flag": "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
  ];


  List<Map<String, String>> topCities = [
    {
      "name": "New York",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Tokyo",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "London",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Paris",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Dubai",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
    },
    {
      "name": "Singapore",
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg"
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
            margin: EdgeInsets.only(top: 30,left: 16,right: 6),
            child: Text("Explore Places Around the World",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: "blMelody"
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 15),
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
              Tab(child: Text("Popular Countries"),),
              Tab(child: Text("Popular Cities"),),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: SizedBox(
              height: 470,
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [

                    // First Tab Bar View
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                          itemCount: countries.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(countries[index]['flag']!,fit: BoxFit.cover,),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 110,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,countries[index]['name']!,style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                ),
                              ],
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> LocationModel()));
                          },
                          child: Center(
                            child: Container(
                              height: 48,
                                width: 130,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: MyColor().boxInnerClr,
                                  borderRadius: BorderRadius.circular(60)
                                ),
                                child: Text("View All",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: MyColor().blackClr
                                ),)),
                          ),
                        ),
                      ],
                    ),

                    // Second Tab Bar View
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                          itemCount: topCities.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(topCities[index]['image']!,fit: BoxFit.cover),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 110,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,topCities[index]['name']!,style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                ),
                              ],
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                        ),
                        Center(
                          child: Container(
                              height: 48,
                              width: 130,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColor().boxInnerClr,
                                  borderRadius: BorderRadius.circular(60)
                              ),
                              child: Text("View All",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: MyColor().blackClr
                              ),)),
                        )
                      ],
                    )

                  ]),
            ),
          )
        ],
      ),
    );
  }
}
