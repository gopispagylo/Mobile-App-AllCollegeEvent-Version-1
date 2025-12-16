import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventsModel extends StatefulWidget {
  const MyEventsModel({super.key});

  @override
  State<MyEventsModel> createState() => _MyEventsModelState();
}

class _MyEventsModelState extends State<MyEventsModel> {


  // ------ Switch Value --------
  bool checkStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text("My Events",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr
        ),),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 10,left: 16,right: 16),
                width: 380,
                child: TextFormField(
                  onTapOutside: (onChanged){
                    WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                    ),
                    prefixIcon: Icon(Icons.search,size: 24,),
                    hintText: "Search Events",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: MyColor().hintTextClr
                    ),
                  ),
                )),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network("https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=870&auto=format&fit=crop",height: 100,fit: BoxFit.cover,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Event Name",style: GoogleFonts.poppins(
                              fontSize: 18,fontWeight: FontWeight.w500,color: MyColor().blackClr
                          ),)),
                          Transform.scale(
                              scale: 0.7,
                              child: Switch(value: checkStatus, onChanged: (onChanged){
                                setState(() {
                                  checkStatus = onChanged;
                                });
                              })),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width/4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor().whiteClr,
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: MyColor().primaryClr)
                          ),
                          child: Text("Edit",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: MyColor().primaryClr
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

 // ------
