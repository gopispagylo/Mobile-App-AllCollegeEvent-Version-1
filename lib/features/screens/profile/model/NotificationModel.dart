import 'dart:ui';

import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationModel extends StatefulWidget {
  const NotificationModel({super.key});

  @override
  State<NotificationModel> createState() => _NotificationModelState();
}

class _NotificationModelState extends State<NotificationModel> {
  // ------- Check Box Value ------
  bool whatsAppNotification = false;
  bool checkEmailSetting = false;
  bool eventCreateSms = false;
  bool eventStatus = false;
  bool eventCompleted = false;

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
          "Notification",
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
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor().borderClr.withOpacity(0.15),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: customCheckBox(
                name: "Email Notification",
                value: checkEmailSetting,
                onChanged: (onChanged) {
                  setState(() {
                    checkEmailSetting = onChanged;

                    // -------- when the email notification is off other sub notification include off (eventCreate,eventStatus and eventCompleted) ------
                    if (checkEmailSetting) {
                      eventCompleted = false;
                      eventStatus = false;
                      eventCreateSms = false;
                    }
                  });
                },
              ),
            ),
            if (checkEmailSetting)
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColor().borderClr.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        customCheckBox(
                          name: "Event Created Successfully",
                          value: eventCreateSms,
                          onChanged: (create) {
                            setState(() {
                              eventCreateSms = create;
                            });
                          },
                        ),
                        customCheckBox(
                          name: "Event Status",
                          value: eventStatus,
                          onChanged: (status) {
                            setState(() {
                              eventStatus = status;
                            });
                          },
                        ),
                        customCheckBox(
                          name: "Event Completed",
                          value: eventCompleted,
                          onChanged: (completed) {
                            setState(() {
                              eventCompleted = completed;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor().borderClr.withOpacity(0.15),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: customCheckBox(
                name: "Whatsapp Notification",
                value: whatsAppNotification,
                onChanged: (onChanged) {
                  setState(() {
                    whatsAppNotification = onChanged;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------- Check Box -------
  Widget customCheckBox({
    required String name,
    required dynamic value,
    required ValueChanged onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: MyColor().blackClr,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
