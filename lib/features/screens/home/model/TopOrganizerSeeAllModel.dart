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
      body: Container(
        margin: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [

            // -------- 1st and 2nd and 3rd board ui -----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: MyColor().primaryClr,
                              shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(textAlign: TextAlign.center,"Swaram Club",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                        ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('4.7',style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,fontSize: 8
                            ),),
                            Row(
                              children: List.generate(4, (index){
                                return  Icon(Icons.star,size: 13,color: MyColor().yellowClr,);
                              }),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("1",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                )),
                                Text("Events",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                            SizedBox(width: 16,),
                            Column(
                              children: [
                                Text("1500",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                )),
                                Text("Views",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('4.7',style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,fontSize: 10
                            ),),
                            Row(
                              children: List.generate(4, (index){
                                return  Icon(Icons.star,size: 13,color: MyColor().yellowClr,);
                              }),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("1",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                                )),
                                Text("Events",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                            SizedBox(width: 16,),
                            Column(
                              children: [
                                Text("1500",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                                )),
                                Text("Views",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 12,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: MyColor().primaryClr,
                              shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(textAlign: TextAlign.center,"Swaram Club",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                        ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('4.7',style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,fontSize: 8
                            ),),
                            Row(
                              children: List.generate(4, (index){
                                return  Icon(Icons.star,size: 13,color: MyColor().yellowClr,);
                              }),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("1",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                )),
                                Text("Events",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                            SizedBox(width: 16,),
                            Column(
                              children: [
                                Text("1500",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                )),
                                Text("Views",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,fontSize: 10,color: MyColor().blackClr
                                ),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),

            // ---------- list of leaders ----------------
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: MyColor().blueClr
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Rank",style: GoogleFonts.poppins(
                      fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                    ),),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text("Organizer",style: GoogleFonts.poppins(
                      fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                    ),),
                  ),
                  Text("Events",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                  ),),
                  SizedBox(width: 20,),
                  Text("Views",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                  ),),
                ],
              ),
            ),

            // ------ builder ui -------------
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context,index){
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MyColor().boxInnerClr,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text("Rank",style: GoogleFonts.poppins(
                            fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                        ),),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text("Organizer",style: GoogleFonts.poppins(
                            fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                        ),),
                      ),
                      Text("Events",style: GoogleFonts.poppins(
                          fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                      ),),
                      SizedBox(width: 20,),
                      Text("Views",style: GoogleFonts.poppins(
                          fontSize: 14,fontWeight: FontWeight.w500,color: MyColor().blackClr
                      ),),
                    ],
                  ),
                );
              }),
            )

          ],
        ),
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


