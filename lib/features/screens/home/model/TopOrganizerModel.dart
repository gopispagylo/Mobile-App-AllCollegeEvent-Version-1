import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopOrganizerModel extends StatefulWidget {
  const TopOrganizerModel({super.key});

  @override
  State<TopOrganizerModel> createState() => _TopOrganizerModelState();
}

class _TopOrganizerModelState extends State<TopOrganizerModel> {

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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30,left: 16,right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Top Organizers",style: TextStyle(
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(brandLogos.length, (index){
              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 16 : 0,right: 16),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: MyColor().whiteClr,
                  shape: BoxShape.circle,
                  border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(brandLogos[index]),
              );
            }),
          ),
        )
      ],
    );
  }
}
