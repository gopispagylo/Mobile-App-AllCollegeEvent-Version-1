import 'package:all_college_event_app/features/screens/notification/model/NotificationModelClass.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationModel extends StatefulWidget {
  const NotificationModel({super.key});

  @override
  State<NotificationModel> createState() => _NotificationModelState();
}

class _NotificationModelState extends State<NotificationModel> {
  final List<NotificationItem> notificationItem = [
    NotificationItem(
      title: "Announcement!",
      message: 'New event announcement from organizer "Vikkalsh".',
      time: "7 min",
      isUnread: true,
      unreadCount: 16,
    ),
    NotificationItem(
      title: "Swathi Updated Event!",
      message: '"Great Kirikalan Magic Show" Event has been rescheduled...',
      time: "17 min",
      isUnread: false,
      unreadCount: 0,
    ),
    NotificationItem(
      title: "Your Certificate is Ready!",
      message: "Your certificate for the event is now available for download.",
      time: "25 min",
      isUnread: true,
      unreadCount: 5,
    ),
    NotificationItem(
      title: "Event Completed!",
      message: "Thank you for attending the event. Please share your feedback.",
      time: "12 hrs",
      isUnread: false,
      unreadCount: 0,
    ),
    NotificationItem(
      title: "Get Ready!",
      message: '"Next-Gen Webinar on Big Data" event starts Today.',
      time: "18 hrs",
      isUnread: false,
      unreadCount: 0,
    ),
    NotificationItem(
      title: "Event Closes Soon!",
      message: "Registration for your liked event is closing soon.",
      time: "17 hrs",
      isUnread: false,
      unreadCount: 0,
    ),
    NotificationItem(
      title: "WELCOME KRISH!",
      message: "Welcome to AllCollegeEvent! Your account has been created.",
      time: "22 hrs",
      isUnread: false,
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: notificationItem.length,
        itemBuilder: (context, index) {
          final list = notificationItem[index];
          return Card(
            margin: EdgeInsets.only(top: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
              side: BorderSide(
                color: !list.isUnread
                    ? MyColor().borderClr.withValues(alpha: 0.1)
                    : MyColor().primaryClr.withValues(alpha: 0.1),
              ),
            ),
            color: !list.isUnread
                ? MyColor().boxInnerClr
                : MyColor().primaryClr.withValues(alpha: 0.1),
            elevation: 0,
            child: Container(
              margin: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: !list.isUnread
                                ? MyColor().primaryClr.withValues(alpha: 0.1)
                                : MyColor().redClr.withValues(alpha: 0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Iconsax.notification_copy,
                              color: !list.isUnread
                                  ? MyColor().primaryClr
                                  : MyColor().redClr,
                              size: 15,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list.title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MyColor().blackClr,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2, right: 10),
                                child: Text(
                                  // textAlign: TextAlign.justify,
                                  list.message,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        list.time,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      if (list.unreadCount != 0 && list.unreadCount != null)
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyColor().primaryClr,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              textAlign: TextAlign.center,
                              list.unreadCount.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: MyColor().whiteClr,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
