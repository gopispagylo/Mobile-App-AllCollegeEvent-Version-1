import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LocationModel extends StatefulWidget {
  const LocationModel({super.key});

  @override
  State<LocationModel> createState() => _LocationModelState();
}

class _LocationModelState extends State<LocationModel> {
  List<Map<String, dynamic>> cityList = [
    {
      "id": 1,
      "name": "Delhi",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
    {
      "id": 2,
      "name": "Mumbai",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
    {
      "id": 3,
      "name": "Hyderabad",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
    {
      "id": 4,
      "name": "Chennai",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
    {
      "id": 5,
      "name": "Bangalore",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
    {
      "id": 6,
      "name": "Kolkata",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/32/Chennai_Central.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          "Location",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            "Choose Your Location to Discover Events",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: MyColor().blackClr,
            ),
          ),
          SizedBox(height: 30),

          // ----------- search bar ----------
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
              width: 380,
              child: TextFormField(
                onTapOutside: (onChanged) {
                  WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: MyColor().borderClr,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: MyColor().primaryClr,
                      width: 0.5,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search, size: 24),
                  hintText: "Search Your Location",
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: MyColor().hintTextClr,
                  ),
                ),
              ),
            ),
          ),

          // -------- Popular Cities --------
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Popular Cities",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: MyColor().primaryClr,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cityList.length,
              itemBuilder: (context, index) {
                final list = cityList[index];
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, MyColor().blackClr],
                      stops: const [0.8, 1],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Image.network(list['image'], fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          list['name'] ?? "Delhi",
                          style: GoogleFonts.poppins(
                            color: MyColor().whiteClr,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
            ),
          ),

          // ---------- Popular Countries ------
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                "Popular Countries",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: MyColor().primaryClr,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Wrap(
                children: List.generate(cityList.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Iconsax.flag),
                        Text(cityList[index]['name']),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
