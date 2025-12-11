import 'package:all_college_event_app/features/auth/organizer/signUp/ui/OrganizationDetailPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrgCategoriesModel extends StatefulWidget {
  const OrgCategoriesModel({super.key});

  @override
  State<OrgCategoriesModel> createState() => _OrgCategoriesModelState();
}

class _OrgCategoriesModelState extends State<OrgCategoriesModel> {

  List<Map<String, dynamic>> categories = [
    {
      "title": "College / University",
      "icon": Icons.school,
    },
    {
      "title": "Training & Coaching Institute",
      "icon": Icons.menu_book,
    },
    {
      "title": "Individual / Freelancer",
      "icon": Icons.person,
    },
    {
      "title": "Tech / Professional",
      "icon": Icons.computer,
    },
    {
      "title": "Event Management",
      "icon": Icons.event,
    },
    {
      "title": "Sports / Fitness",
      "icon": Icons.fitness_center,
    },
    {
      "title": "Corporate / Company",
      "icon": Icons.apartment,
    },
    {
      "title": "Government Organization",
      "icon": Icons.account_balance,
    },
    {
      "title": "NGO / Non-profit Organization",
      "icon": Icons.volunteer_activism,
    },
  ];

  // ---------- Select the categories values ----------
  String? selectCategories;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(
            ImagePath().backgroundImg, fit: BoxFit.contain)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // -------- TabBar --------
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60,left: 16,right: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().primaryBackgroundClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().primaryClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.menu,color: MyColor().primaryClr,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nCategory",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Organization\nDetails",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                        // -------- Horizontal Line ---------
                        Expanded(child: Divider(color: MyColor().borderClr,thickness: 2,)),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.check_circle_outline,size: 18,),
                                )),
                            SizedBox(height: 5,),
                            Text(textAlign: TextAlign.center,"Account\nCreation",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: MyColor().blackClr
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text("Organization Category",style: TextStyle(
                      fontSize: 24,
                      color: MyColor().blackClr,
                      fontWeight: FontWeight.w500,
                      fontFamily: "blMelody"
                  ),),
                ),
                // -------- Categories --------
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 16,right: 16),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context,index){
                          final title = categories[index]['title'];
                          final isSelected = selectCategories == title;
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                selectCategories = title;
                              });
                              print("selectCategoriesselectCategoriesselectCategoriesselectCategories$selectCategories");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:isSelected ? MyColor().primaryClr : MyColor().boxInnerClr,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: isSelected ? MyColor().primaryClr.withOpacity(0.15) : MyColor().borderClr.withOpacity(0.15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(categories[index]['icon'],color:isSelected ? MyColor().whiteClr : MyColor().blackClr,),
                                    SizedBox(height: 5,),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      categories[index]['title'],style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:isSelected ? MyColor().whiteClr : MyColor().blackClr
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10)),
                  ),
                ),
              ],
            ),
            // -------- Button --------
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 48),
                      elevation: 0,
                      backgroundColor: MyColor().primaryClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(50),
                      ),
                    ),
                    onPressed: () {
                      if(selectCategories != null){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> OrganizationDetailPage()));
                      }else{
                        print("Please choose a categories");
                      }
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyColor().whiteClr,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // -------- Already have an account --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account!?", style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Sign In", style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: MyColor().primaryClr,
                          fontWeight: FontWeight.w600
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 50),
              ],
            )
          ],
        ),
      ],
    );
  }
}
