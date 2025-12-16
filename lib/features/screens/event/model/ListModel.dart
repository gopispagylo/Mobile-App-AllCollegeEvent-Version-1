import 'package:all_college_event_app/features/screens/event/model/EventDetailModel.dart';
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
      margin: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
     child: ListView.builder(
         itemCount: 10,
         itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (_)=> EventDetailModel()));
             },
             child: Container(
               margin: EdgeInsets.only(left: 0, bottom: 16),
               padding: EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: MyColor().whiteClr,
                 border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Expanded(
                     flex: 2,
                     child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10)
                         ),
                         clipBehavior: Clip.antiAlias,
                         child: Image.network("https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop",height: 100,fit: BoxFit.cover,)),
                   ),
                   Expanded(
                     flex: 4,
                     child: Container(
                       margin: EdgeInsets.only(left: 10),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Expanded(child: Text('Infinite Legen',overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                                 fontSize: 14,
                                 fontWeight: FontWeight.w600,
                               ),)),
                               SizedBox(width: 5,),
                               Row(
                                 children: [
                                   circleIcon(Icons.favorite_border),
                                   SizedBox(width: 5,),
                                   circleIcon(Icons.bookmark_outline),
                                 ],
                               ),
                             ],
                           ),
                           SizedBox(height: 5,),
                           Row(children: [
                            chip("Paid", MyColor().primaryBackgroundClr.withOpacity(0.35)),
                            chip("Entertainment", MyColor().blueBackgroundClr.withOpacity(0.35)),
                          ],),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Icon(Icons.calendar_month, size: 14),
                               SizedBox(width: 5),
                               Expanded(
                                 child: Text(
                                   "24 Jan 2025, Friday",
                                   overflow: TextOverflow.ellipsis,
                                   style: GoogleFonts.poppins(
                                     fontSize: 12,
                                     fontWeight: FontWeight.w400,
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           SizedBox(height: 5,),
                           Row(
                             children: [
                               Icon(Icons.location_on_outlined, size: 14),
                               SizedBox(width: 5),
                               Expanded(
                                 child: Text(
                                   "Coimbatore, India",
                                   overflow: TextOverflow.ellipsis,
                                   style: GoogleFonts.poppins(
                                     fontSize: 12,
                                     fontWeight: FontWeight.w400,
                                   ),
                                 ),
                               ),
                               Container(
                                   padding: EdgeInsets.symmetric(
                                     vertical: 3,
                                     horizontal: 8,
                                   ),
                                   decoration: BoxDecoration(
                                     color: MyColor().primaryBackgroundClr.withOpacity(
                                       0.35,
                                     ),
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                   child: Text(
                                     "Ongoing",
                                     style: GoogleFonts.poppins(
                                       fontSize: 12,
                                       fontWeight: FontWeight.w400,
                                       color: MyColor().blackClr,
                                     ),
                                   )
                               )
                             ],
                           ),
                        ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
         }),
    );
  }
}


// --------- Dummy Button ---------
Widget chip(String text, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
    ),
  );
}


// --------- Fav & Add to cart Icon ---------
Widget circleIcon(IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
      color: MyColor().boxInnerClr,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 15),
  );
}
