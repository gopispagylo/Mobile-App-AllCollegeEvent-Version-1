import 'dart:ui';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TopOrganizerSeeAllModel extends StatefulWidget {
  final List<dynamic> topOrganizerList;

  const TopOrganizerSeeAllModel({super.key, required this.topOrganizerList});

  @override
  State<TopOrganizerSeeAllModel> createState() =>
      _TopOrganizerSeeAllModelState();
}

class _TopOrganizerSeeAllModelState extends State<TopOrganizerSeeAllModel> {
  // -------- Active index -------
  int selectedIndex = 0;

  // ----- list of rank metals --------
  final List<String> metalsList = [
    ImagePath().rank_2,
    ImagePath().rank_1,
    ImagePath().rank_3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "Top Organizers",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              decoration: BoxDecoration(
                color: MyColor().whiteClr.withOpacity(0.05),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            // -------- 1st and 2nd and 3rd board ui -----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              // memCacheHeight: 300,
                              fadeInDuration: Duration.zero,
                              width: 40,
                              height: 40,
                              imageUrl:
                                  widget.topOrganizerList[1]['profileImage'] ??
                                  "",
                              errorWidget: (context, url, error) {
                                return Center(child: Icon(Iconsax.image));
                              },
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor().primaryClr,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            widget.topOrganizerList[1]['organizationName'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: MyColor().blackClr,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.7',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                ),
                              ),
                              Row(
                                children: List.generate(4, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 13,
                                    color: MyColor().yellowClr,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.topOrganizerList[1]['eventCount']
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Events",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    "1500",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Views",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              // memCacheHeight: 300,
                              fadeInDuration: Duration.zero,
                              width: 50,
                              height: 50,
                              imageUrl:
                                  widget.topOrganizerList[0]['profileImage'] ??
                                  "",
                              errorWidget: (context, url, error) {
                                return Center(child: Icon(Iconsax.image));
                              },
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor().primaryClr,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            widget.topOrganizerList[0]['organizationName'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: MyColor().blackClr,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.7',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                              Row(
                                children: List.generate(4, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 13,
                                    color: MyColor().yellowClr,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.topOrganizerList[1]['eventCount']
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Events",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    "1500",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Views",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                      color: MyColor().yellowClr.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              // memCacheHeight: 300,
                              fadeInDuration: Duration.zero,
                              width: 40,
                              height: 40,
                              imageUrl:
                                  widget.topOrganizerList[1]['profileImage'] ??
                                  "",
                              errorWidget: (context, url, error) {
                                return Center(child: Icon(Iconsax.image));
                              },
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor().primaryClr,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            widget.topOrganizerList[2]['organizationName'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: MyColor().blackClr,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.7',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                ),
                              ),
                              Row(
                                children: List.generate(4, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 13,
                                    color: MyColor().yellowClr,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.topOrganizerList[2]['eventCount']
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Events",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    "1500",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                  Text(
                                    "Views",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // ---------- table list of leaders ----------------
            Table(
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: MyColor().blueClr.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Rank",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Organizer",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Events",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Views",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Table(
                children: List.generate(widget.topOrganizerList.length, (
                  index,
                ) {
                  final list = widget.topOrganizerList[index];
                  final orgName = list['organizationName'];
                  final orgRank = list['rank'];
                  final orgEventCounts = list['eventCount'];
                  final orgEventViews = 100;
                  return TableRow(
                    decoration: BoxDecoration(
                      color: MyColor().borderClr.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          textAlign: TextAlign.center,
                          orgRank.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          orgName,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          textAlign: TextAlign.center,
                          orgEventCounts.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Views",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColor().blackClr,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
