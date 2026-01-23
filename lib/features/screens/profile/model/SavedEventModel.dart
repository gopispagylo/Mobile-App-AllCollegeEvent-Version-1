import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/features/screens/event/ui/EventDetailPage.dart';
import 'package:all_college_event_app/features/screens/global/bloc/saveEvent/removeSaveEventBloc/remove_save_event_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/savedEvent/savedEventListBloc/saved_event_bloc.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toastification/toastification.dart';

class SavedEventModel extends StatefulWidget {
  const SavedEventModel({super.key});

  @override
  State<SavedEventModel> createState() => _SavedEventModelState();
}

class _SavedEventModelState extends State<SavedEventModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      appBar: AppBar(
        backgroundColor: MyColor().whiteClr,
        title: Text(
          "Saved Events",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: MyColor().blackClr,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            SavedEventBloc(apiController: ApiController())
              ..add(FetchSavedEvent()),
          ),
          BlocProvider(
            create: (context) =>
                RemoveSaveEventBloc(apiController: ApiController()),
          ),
        ],
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                width: 380,
                child: TextFormField(
                  onTapOutside: (onChanged) {
                    WidgetsBinding.instance.focusManager.primaryFocus!
                        .unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: MyColor().borderClr,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: MyColor().primaryClr,
                        width: 0.5,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, size: 24),
                    hintText: "Search Events",
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: MyColor().hintTextClr,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SavedEventBloc, SavedEventState>(
                builder: (context, savedEventState) {
                  if (savedEventState is SavedEventLoading) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return eventCardShimmer();
                      },
                    );
                  } else if (savedEventState is SavedEventSuccess) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<SavedEventBloc>().add(FetchSavedEvent());
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                          bottom: 20,
                        ),
                        child: ListView.builder(
                          itemCount: savedEventState.savedEventList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final list = savedEventState.savedEventList[index];

                            // -------- field name ------------
                            final title = list['title'] ?? "No title";

                            final featuredImagePath =
                            (list['bannerImages'] != null &&
                                list['bannerImages'].isNotEmpty)
                                ? list['bannerImages'][0]
                                : '';

                            // ------ date format -------
                            final rawDate = list['eventDate']?.toString() ?? "";

                            // 2. Safe Date Parsing
                            String dateFormat = "Date TBD";

                            if (rawDate.isNotEmpty) {
                              try {
                                // Use MM for months!
                                final parsedDate = DateFormat(
                                  'dd/MM/yyyy',
                                ).parse(rawDate);
                                dateFormat = DateFormat(
                                  'dd MMM yyyy',
                                ).format(parsedDate);
                              } catch (e) {
                                debugPrint("Date parsing error: $e");
                                dateFormat =
                                    rawDate; // Fallback to raw string if parsing fails
                              }
                            }

                            // ---- venue ---
                            final venue = list['venue'] ?? "no venue";

                            // -------- identity ---------
                            final identity = list['slug'];

                            final eventId = list['identity'];

                            // final identity = list['slug'];

                            final paymentLink = list['paymentLink'];

                            return TweenAnimationBuilder(
                              tween: Tween(begin: 50.0, end: 0.0),
                              duration: Duration(milliseconds: 600),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, value),
                                  child: Opacity(
                                    opacity: 1 - (value / 50),
                                    child: child,
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EventDetailPage(
                                            identity: identity,
                                            title: title,
                                            whichScreen: 'view',
                                            paymentLink: paymentLink,
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 0, bottom: 16),
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 5,
                                    bottom: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor().whiteClr,
                                    border: Border.all(
                                      color: MyColor().borderClr.withOpacity(
                                        0.15,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Hero(
                                            tag: 'event_image_$identity',
                                            child: CachedNetworkImage(
                                              imageUrl: featuredImagePath,
                                              fit: BoxFit.cover,
                                              height: 110,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                      color: MyColor()
                                                          .primaryClr,
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context,
                                                  url,
                                                  error,) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      title,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  BlocConsumer<RemoveSaveEventBloc, RemoveSaveEventState>(
                                                    listener: (context, removeEventState) {
                                                      if(removeEventState is RemoveSaveEventSuccess){
                                                        context.read<SavedEventBloc>().add(FetchSavedEvent());
                                                        FlutterToast().flutterToast("${removeEventState.successMessage} 🎉", ToastificationType.success, ToastificationStyle.flat);
                                                      } else if(removeEventState is RemoveSaveEventFail){
                                                        FlutterToast().flutterToast(removeEventState.errorMessage, ToastificationType.error, ToastificationStyle.flat);
                                                      }
                                                    },
                                                    builder: (context, removeEventState) {
                                                      final checkLoading = removeEventState is RemoveSaveEventLoading && removeEventState.eventId == eventId;
                                                      return InkWell(
                                                        onTap: () {
                                                          context.read<RemoveSaveEventBloc>().add(ClickRemoveSaveEvent(eventId: eventId));
                                                        },
                                                        child: checkLoading ? Center(child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: CircularProgressIndicator(color: MyColor().primaryClr,strokeWidth: 2,)),): circleIcon(
                                                          Icons.bookmark,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  chip(
                                                    "Paid",
                                                    MyColor()
                                                        .primaryBackgroundClr
                                                        .withOpacity(0.35),
                                                  ),
                                                  chip(
                                                    "Entertainment",
                                                    MyColor().blueBackgroundClr
                                                        .withOpacity(0.35),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      dateFormat,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      venue,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: MyColor()
                                                          .primaryBackgroundClr
                                                          .withOpacity(0.35),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Ongoing",
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        color: MyColor()
                                                            .blackClr,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (savedEventState is SavedEventFail) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<SavedEventBloc>().add(FetchSavedEvent());
                      },
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 250,
                                child: Image.asset(ImagePath().errorMessageImg),
                              ),
                            ),
                            Center(
                              child: Text(
                                savedEventState.errorMessage,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
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
    child: Icon(icon, size: 18, color: MyColor().primaryClr),
  );
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

// ---------- Skeleton loading ui model -------
Widget eventCardShimmer() {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyColor().borderClr.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        // Image shimmer
        Expanded(
          flex: 2,
          child: Shimmer(
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Content shimmer
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + icons
              Row(
                children: [
                  Expanded(
                    child: Shimmer(
                      child: Container(
                        width: double.infinity,
                        height: 14,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Shimmer(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Shimmer(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Chips
              Row(
                children: [
                  Shimmer(
                    child: Container(
                      width: 50,
                      height: 18,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Shimmer(
                    child: Container(
                      width: 90,
                      height: 18,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Date
              Shimmer(
                child: Container(
                  width: 160,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Location + status
              Row(
                children: [
                  Expanded(
                    child: Shimmer(
                      child: Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          color: MyColor().sliderDotClr,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Shimmer(
                    child: Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: MyColor().sliderDotClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
