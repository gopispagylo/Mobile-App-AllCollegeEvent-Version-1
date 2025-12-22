import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopOrganizerSeeAllModel extends StatefulWidget {
  const TopOrganizerSeeAllModel({super.key});

  @override
  State<TopOrganizerSeeAllModel> createState() => _TopOrganizerSeeAllModelState();
}

class _TopOrganizerSeeAllModelState extends State<TopOrganizerSeeAllModel> {

  // -------- Active index -------
  int selectedIndex = 0;

  List<String> brandLogos = [
    // 2. Google
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/512px-Google_2015_logo.svg.png",

    // 3. Microsoft
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Microsoft_logo_%282012%29.svg/512px-Microsoft_logo_%282012%29.svg.png",

    // 5. Coca-Cola
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Coca-Cola_logo.svg/512px-Coca-Cola_logo.svg.png",

    // 8. Toyota
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Toyota_carlogo.svg/512px-Toyota_carlogo.svg.png",

    // 9. Mercedes-Benz
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/512px-Mercedes-Logo.svg.png",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("Top Organizers",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
        ),),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: MyColor().boxInnerClr,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTabBar(title: 'This Week', index: 0),
                  customTabBar(title: 'All time', index: 1),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: MyColor().primaryBackgroundClr,
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: MyColor().primaryClr,
                        shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.center,"Swaram Club",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                    ),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("1"),
                        Text("1500"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------- Custom Tab Bar --------------
  Widget customTabBar({required String title, required int index}){
    final selectedValue = selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: !selectedValue ? MyColor().boxInnerClr : MyColor().primaryBackgroundClr
          ),
          child: Text(title,style: GoogleFonts.poppins(
              fontSize: 12,fontWeight: FontWeight.w500,color: MyColor().blackClr
          ),),
        ),
      ),
    );
  }
}


