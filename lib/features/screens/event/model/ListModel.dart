import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListModel extends StatefulWidget {
  const ListModel({super.key});

  @override
  State<ListModel> createState() => _ListModelState();
}

class _ListModelState extends State<ListModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0,right: 16,top: 20,bottom: 20),
     child: ListView.builder(
         itemCount: 20,
         itemBuilder: (context,index){
       return Stack(
         children: [
           Container(
             margin: EdgeInsets.only(left: 50,bottom: 16),
             padding: EdgeInsets.all(10),
             decoration: BoxDecoration(
                 color: MyColor().whiteClr,
                 border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                 borderRadius: BorderRadiusGeometry.circular(10)
             ),
             child: Container(
               margin: EdgeInsets.only(left: 80),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("TATA Job Fair", style: GoogleFonts.poppins(
                             fontSize: 16,
                             fontWeight: FontWeight.w600
                         ),),
                         SizedBox(height: 10,),
                         Row(
                           children: [
                             Container(
                               margin: EdgeInsets.only(bottom: 10,right: 10),
                               padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                               decoration: BoxDecoration(
                                   color: MyColor().primaryBackgroundClr,
                                   borderRadius: BorderRadiusGeometry.circular(40)
                               ),
                               child: Text("Paid",style: GoogleFonts.poppins(
                                   fontWeight: FontWeight.w400,
                                   fontSize: 12
                               )),
                             ),
                             Container(
                               margin: EdgeInsets.only(bottom: 10,right: 10),
                               padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                               decoration: BoxDecoration(
                                   color: MyColor().blueBackgroundClr,
                                   // border: Border.all(color: MyColor().blueBackgroundClr),
                                   borderRadius: BorderRadiusGeometry.circular(40)
                               ),
                               child: Text("Networking",style: GoogleFonts.poppins(
                                   fontWeight: FontWeight.w400,
                                   fontSize: 12
                               )),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Icon(Icons.calendar_month),
                             SizedBox(width: 5,),
                             Text("24 Jan 2025, Friday",style: GoogleFonts.poppins(
                                 fontSize: 12,
                                 fontWeight: FontWeight.w600
                             ),),
                           ],
                         ),
                         SizedBox(height: 10,),
                         Row(
                           children: [
                             Icon(Icons.location_on_outlined),
                             SizedBox(width: 5,),
                             Text("Coimbatore",style: GoogleFonts.poppins(
                                 fontSize: 12,
                                 fontWeight: FontWeight.w600
                             ),),
                           ],
                         ),
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 120,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Container(
                               padding: EdgeInsets.all(12),
                               decoration: BoxDecoration(
                                   color: MyColor().boxInnerClr,
                                   shape: BoxShape.circle),
                               child: Icon(Icons.favorite_border),
                             ),
                             SizedBox(width: 10),
                             Container(
                               padding: EdgeInsets.all(12),
                               decoration: BoxDecoration(
                                   color: MyColor().boxInnerClr,
                                   shape: BoxShape.circle),
                               child: Icon(Icons.bookmark_outline),
                             ),
                           ],
                         ),

                         Container(
                           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                           decoration: BoxDecoration(
                             color: MyColor().primaryClr,
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Text(
                             "Ongoing",
                             style: GoogleFonts.poppins(
                               fontSize: 12,
                               fontWeight: FontWeight.w500,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
           Positioned(
             left: 0,
             top: 17,
             child: Container(
               margin: EdgeInsets.only(left: 16,right: 0),
               height: 110,
               width: 115,
               decoration: BoxDecoration(
                 borderRadius: BorderRadiusGeometry.circular(10),
                 boxShadow: [
                   BoxShadow(color: MyColor().primaryBackgroundClr,
                     blurRadius: 5,
                     spreadRadius: 2
                   )
                 ]
               ),
               clipBehavior: Clip.antiAlias,
               child: Banner(
                 message: "offer",
                 location: BannerLocation.topStart,
                 color: MyColor().yellowClr,
                 textStyle: GoogleFonts.poppins(
                   fontWeight: FontWeight.w500,
                   fontSize: 14,
                   color: MyColor().blackClr
                 ),
                 child: Image.network(
                   "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                   fit: BoxFit.cover,),),
             ),
           ),
         ],
       );
     }),
    );
  }
}
