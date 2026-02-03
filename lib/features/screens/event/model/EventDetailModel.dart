import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventCountUpdateBloc/event_count_update_bloc.dart';
import 'package:all_college_event_app/features/screens/event/bloc/eventDetailBloc/event_detail_bloc.dart';
import 'package:all_college_event_app/features/screens/global/bloc/like/eventLike/event_like_bloc.dart';
import 'package:all_college_event_app/features/screens/report/ui/ReportPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/imagePath/ImagePath.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailModel extends StatefulWidget {
  final String identity;
  final String title;
  final String whichScreen;
  final String paymentLink;

  const EventDetailModel({
    super.key,
    required this.identity,
    required this.title,
    required this.whichScreen,
    required this.paymentLink,
  });

  @override
  State<EventDetailModel> createState() => _EventDetailModelState();
}

class _EventDetailModelState extends State<EventDetailModel>
    with WidgetsBindingObserver {
  // ------- hide bottom navigation bar --------
  late ScrollController scrollController;

  // ------- Controller ----------
  final commentController = TextEditingController();
  final contactAdminController = TextEditingController();

  int currentPage = 0;

  // ------- Star index --------
  int starIndex = 0;
  int selectedIndex = 0;

  bool readMore = false;

  // ----- payment loading -------
  bool checkPaymentLink = false;

  // -------- form key ------
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // --------- after payment page then comes loading off condition ---------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        setState(() {
          checkPaymentLink = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkEdit = widget.whichScreen == 'edit';
    return Scaffold(
      backgroundColor: MyColor().whiteClr,
      body: BlocConsumer<EventCountUpdateBloc, EventCountUpdateState>(
        listener: (context, eventCountState) {
          if (eventCountState is EventCountUpdateFail) {
            FlutterToast().flutterToast(
              eventCountState.errorMessage,
              ToastificationType.error,
              ToastificationStyle.flat,
            );
          }
        },
        builder: (context, eventCountState) {
          return BlocBuilder<EventDetailBloc, EventDetailState>(
            builder: (context, eventDetailState) {
              if (eventDetailState is EventDetailLoading) {
                return eventDetailShimmer();
              } else if (eventDetailState is EventDetailSuccess) {
                final list = eventDetailState.eventDetailList[0];
                final checkPaid = list['tickets'][0]['isPaid'];

                // ------ condition of word first name is caps ---------
                String toTitleCase(String text) {
                  return text
                      .toLowerCase()
                      .split(' ')
                      .map(
                        (e) => e.isNotEmpty
                            ? '${e[0].toUpperCase()}${e.substring(1)}'
                            : '',
                      )
                      .join(' ');
                }

                // ----- format date and time --------
                final dateFormat = DateFormat("dd MMM yy");

                String location =
                    "${toTitleCase(list['location']['venue'] ?? '')}, ${list['location']['city'] ?? ''}";

                String startAndEndEvent =
                    "${dateFormat.format(DateTime.parse(list['calendars'][0]['startDate']))} to ${dateFormat.format(DateTime.parse(list['calendars'][0]['endDate']))}";

                return ListView(
                  controller: scrollController,
                  children: [
                    // --------- Carousel Slider ------
                    if (list['bannerImages'] != null &&
                        list['bannerImages'].isNotEmpty)
                      CarouselSlider.builder(
                        itemCount: list['bannerImages'].length,
                        itemBuilder: (BuildContext context, index, realIndex) {
                          final sliderList = list['bannerImages'][index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: MyColor().borderClr.withOpacity(0.15),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Hero(
                                tag: 'event_image_${widget.identity}',
                                child: CachedNetworkImage(
                                  imageUrl: sliderList,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor().primaryClr,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          enlargeCenterPage: true,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          viewportFraction: 1,
                          aspectRatio: 1.7,
                          clipBehavior: Clip.antiAlias,
                          pageSnapping: true,
                          padEnds: true,
                          animateToClosest: true,
                        ),
                      ),

                    if (list['bannerImages'] != null &&
                        list['bannerImages'].isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: currentPage,
                            count: list['bannerImages'].length,
                            effect: WormEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: MyColor().primaryClr,
                              dotColor: MyColor().sliderDotClr,
                              spacing: 8,
                            ),
                          ),
                        ),
                      ),

                    // ---------- edit ---------
                    if (checkEdit)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            color: MyColor().primaryClr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.only(right: 16, bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: MyColor().whiteClr,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                    // ------- Title & Share & Add to cart -----------
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              list['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 20,
                                color: MyColor().borderClr,
                              ),
                              SizedBox(width: 2),
                              Text(
                                list['viewCount'].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // --------- Paid & Online -------
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              colorLabel(
                                text: list['categoryName'] ?? "No Categories",
                                color: MyColor().yellowClr,
                                borderColor: MyColor().yellowClr,
                              ),
                              SizedBox(width: 10),
                              colorLabel(
                                text: checkPaid ? 'Online' : 'Offline',
                                color: MyColor().blueClr,
                                borderColor: MyColor().blueClr,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              BlocConsumer<EventLikeBloc, EventLikeState>(
                                listener: (context, eventState) {
                                  if (eventState is EventLikeFail &&
                                      eventState.id == list['identity']) {
                                    FlutterToast().flutterToast(
                                      eventState.errorMessage,
                                      ToastificationType.error,
                                      ToastificationStyle.flat,
                                    );
                                  } else if (eventState is EventLikeSuccess &&
                                      eventState.id == list['identity']) {
                                    list['isLiked'] = eventState.checkFav;
                                  }
                                },
                                builder: (context, eventState) {
                                  final bloc = context.watch<EventLikeBloc>();
                                  final checkFav =
                                      bloc.favStatus[widget.identity
                                          .toString()] ??
                                      list['isLiked'];
                                  // final checkFav = false;
                                  return InkWell(
                                    onTap: () {
                                      context.read<EventLikeBloc>().add(
                                        ClickEventLike(
                                          eventId: list['identity'].toString(),
                                          initialFav: list['isLiked'] ?? false,
                                          initialCount:
                                              int.tryParse(
                                                list['likeCount']?.toString() ??
                                                    '0',
                                              ) ??
                                              0,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: MyColor().borderClr
                                              .withOpacity(0.15),
                                        ),
                                        color: MyColor().boxInnerClr,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        checkFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: checkFav
                                            ? MyColor().redClr
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              circleIcon(Icons.share),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ---------- edit ---------
                    if (checkEdit)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            MyModels().alertDialogContentCustom(
                              context: context,
                              content: Form(
                                key: formKey,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Text(
                                      "This Field Is Locked",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: MyColor().primaryClr,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "This information cannot be edited directly.",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: MyColor().blackClr,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "If you need to make changes, please contact the admin for assistance.",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: MyColor().blackClr,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 20,
                                        bottom: 30,
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: 12,
                                              ),
                                              child: Text(
                                                "Describe Your Request",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 320,
                                              child: TextFormField(
                                                maxLines: 5,
                                                controller:
                                                    contactAdminController,
                                                validator: Validators()
                                                    .validContactAdmin,
                                                onTapOutside: (outSideTab) {
                                                  WidgetsBinding
                                                      .instance
                                                      .focusManager
                                                      .primaryFocus
                                                      ?.unfocus();
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: MyColor()
                                                              .borderClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: MyColor()
                                                              .primaryClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: MyColor().redClr,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              MyColor().redClr,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  hintText:
                                                      "Enter describe your request",
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: MyColor()
                                                            .hintTextClr,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {}
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: MyColor().primaryClr,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Submit',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: MyColor().whiteClr,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              color: MyColor().primaryClr,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.only(
                              right: 16,
                              bottom: 10,
                              top: 10,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Edit',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: MyColor().whiteClr,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // ------ Event Details ------
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: MyColor().boxInnerClr,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: MyColor().borderClr.withOpacity(0.15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: customTabBar(
                                title: 'Events Details',
                                index: 0,
                              ),
                            ),
                            Expanded(
                              child: customTabBar(
                                title: 'Host Details',
                                index: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    selectedIndex == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ------- venue ------
                              if (list['location']['mapLink'] != null)
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.inner,
                                        color: Colors.black.withOpacity(0.13),
                                        offset: Offset(-3, -3),
                                        blurRadius: 10,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.8),
                                        offset: Offset(3, 3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Venue & Date",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Iconsax.location_copy,
                                                size: 20,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  location,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColor().blackClr,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Iconsax.calendar_copy,
                                                size: 20,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                startAndEndEvent,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: MyColor().blackClr,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () async {
                                            final url = Uri.parse(
                                              list['location']['mapLink'],
                                            );
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 16),
                                            padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor().boxInnerClr,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: MyColor().borderClr
                                                    .withOpacity(0.15),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Iconsax.map),
                                                SizedBox(width: 10),
                                                Text(
                                                  'View Map Location',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              // ------ Description ------
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 20,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.justify,
                                      list['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: MyColor().blackClr,
                                      ),
                                      maxLines: readMore ? null : 2,
                                    ),
                                    Align(
                                      alignment: AlignmentGeometry.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            readMore = !readMore;
                                          });
                                        },
                                        child: Text(
                                          readMore ? "Read less" : "Read more",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: MyColor().blueClr,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ---------- edit ---------
                              if (checkEdit)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: MyColor().primaryClr,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 16,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: MyColor().whiteClr,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              // ------ Event video & website ---------
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (list['videoLink'] != null)
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url = Uri.parse(
                                              list['videoLink'],
                                            );
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: MyColor().boxInnerClr,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: MyColor().borderClr
                                                    .withOpacity(0.15),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Iconsax.youtube),
                                                Text('Youtube'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (list['eventLink'] != null)
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url = Uri.parse(
                                              list['eventLink'],
                                            );
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: MyColor().boxInnerClr,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: MyColor().borderClr
                                                    .withOpacity(0.15),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Iconsax.kyber_network_knc),
                                                Text('Website'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    // if (list['location']['mapLink'] != null)
                                  ],
                                ),
                              ),

                              // ------ Ticket Details ---------
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // ------- Title -------
                                      Text(
                                        "Ticket Details",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: MyColor().blackClr,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // ---------- Grid view --------
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: list['tickets'].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 1,
                                            ),
                                        itemBuilder: (context, index) {
                                          final ticket = list['tickets'][index];

                                          final formatter = DateFormat(
                                            'dd-MM-yyyy',
                                          );

                                          DateTime now = DateTime.now();

                                          final ticketStartDate =
                                              DateTime.parse(
                                                ticket['sellingFrom'],
                                              );
                                          final ticketEndDate = DateTime.parse(
                                            ticket['sellingTo'],
                                          );

                                          String checkTicketStatus;

                                          // ------------ find a ticket status -----------
                                          if (now.isBefore(ticketStartDate)) {
                                            checkTicketStatus = "Yet to start";
                                          } else if (now.isAfter(
                                            ticketEndDate,
                                          )) {
                                            checkTicketStatus =
                                                "Ticket Expired";
                                          } else {
                                            checkTicketStatus =
                                                "Ticket is live";
                                          }

                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurStyle: BlurStyle.inner,
                                                  color: Colors.black
                                                      .withOpacity(0.13),
                                                  offset: Offset(-3, -3),
                                                  blurRadius: 10,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  offset: Offset(5, 5),
                                                  blurRadius: 10,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),

                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                    color:
                                                        checkTicketStatus ==
                                                            "Yet to start"
                                                        ? MyColor().yellowClr
                                                              .withOpacity(0.10)
                                                        : checkTicketStatus ==
                                                              "Ticket Expired"
                                                        ? MyColor().redClr
                                                              .withOpacity(0.15)
                                                        : MyColor().greenClr
                                                              .withOpacity(
                                                                0.15,
                                                              ),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: Text(
                                                    checkTicketStatus,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11,
                                                      color:
                                                          checkTicketStatus ==
                                                              "Yet to start"
                                                          ? MyColor().blackClr
                                                          : checkTicketStatus ==
                                                                "Ticket Expired"
                                                          ? MyColor().redClr
                                                          : MyColor().greenClr,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 6),

                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            top: 4,
                                                          ),
                                                      padding: EdgeInsets.all(
                                                        3,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: MyColor()
                                                            .boxInnerClr,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Iconsax.tag,
                                                        size: 10,
                                                        color: MyColor()
                                                            .primaryClr,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Expanded(
                                                      child: Text(
                                                        ticket['name'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: MyColor()
                                                                  .blackClr,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                bulletText(
                                                  ticket['price'] != 0 &&
                                                          ticket['price'] !=
                                                              null
                                                      ? ticket['price']
                                                            .toString()
                                                      : 'Free Cost',
                                                  Iconsax.tag,
                                                ),
                                                bulletText(
                                                  checkTicketStatus ==
                                                          "Yet to start"
                                                      ? "Ticket start at ${DateFormat('dd/MM').format(DateTime.parse(ticket['sellingTo']))}"
                                                      : "Ticket ends at ${DateFormat('dd/MM').format(DateTime.parse(ticket['sellingFrom']))}",
                                                  Iconsax.calendar,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // --------- Discounts & Offers -------
                              if (list['offers'] != null)
                                Container(
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  child: Text(
                                    "Discounts & Offers",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: MyColor().blackClr,
                                    ),
                                  ),
                                ),
                              if (list['offers'] != null)
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    border: Border.all(
                                      color: MyColor().borderClr.withOpacity(
                                        0.15,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Icon(Iconsax.discount_circle),
                                        SizedBox(width: 5),
                                        Text(
                                          list['offers'] ?? "",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: MyColor().blackClr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              // ---------- edit ---------
                              if (checkEdit)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: MyColor().primaryClr,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 16,
                                      bottom: 10,
                                      top: 0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: MyColor().whiteClr,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              // -------- Other Details ---------
                              Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                  "Other Details",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(right: 16, left: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 0,
                                          top: 10,
                                          bottom: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor().boxInnerClr,
                                          border: Border.all(
                                            color: MyColor().borderClr
                                                .withOpacity(0.15),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (list['eventPerks'].isNotEmpty)
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Perks",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: MyColor()
                                                                  .blackClr,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Column(
                                                        children: List.generate(
                                                          list['eventPerks']
                                                              .length,
                                                          (index) {
                                                            return Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  size: 16,
                                                                  color: MyColor()
                                                                      .greenClr,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    list['eventPerks'][index]['perk']['perkName'] ??
                                                                        '',
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          12,
                                                                      color: MyColor()
                                                                          .borderClr,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              if (list['cert']['certName']
                                                  .isNotEmpty)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Certifications",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color: MyColor()
                                                                .blackClr,
                                                          ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.check_rounded,
                                                          size: 16,
                                                          color: MyColor()
                                                              .greenClr,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            list['cert']['certName'] ??
                                                                '',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color: MyColor()
                                                                  .borderClr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
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
                                    if (list['eventAccommodations'].isNotEmpty)
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 16,
                                            right: 0,
                                            top: 10,
                                            bottom: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: MyColor().boxInnerClr,
                                            border: Border.all(
                                              color: MyColor().borderClr
                                                  .withOpacity(0.15),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Accommodations",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color: MyColor()
                                                                .blackClr,
                                                          ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Column(
                                                      children: List.generate(
                                                        list['eventAccommodations']
                                                            .length,
                                                        (index) {
                                                          return Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                size: 16,
                                                                color: MyColor()
                                                                    .greenClr,
                                                              ),
                                                              SizedBox(
                                                                width: 6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  list['eventAccommodations'][index]['accommodation']['accommodationName'] ??
                                                                      '',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color: MyColor()
                                                                        .borderClr,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
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
                              ),

                              // --------- Tags ---------
                              Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                  "Tags",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 10,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColor().boxInnerClr,
                                  border: Border.all(
                                    color: MyColor().borderClr.withOpacity(
                                      0.15,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(16),
                                  child: Wrap(
                                    children: List.generate(
                                      list['tags'].length,
                                      (index) {
                                        return Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: MyColor().boxInnerClr,
                                            border: Border.all(
                                              color: MyColor().borderClr
                                                  .withOpacity(0.15),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "#${list['tags'][index] ?? ''}",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),

                              // -------- Event Host Details -------
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "Event Host Details",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: MyColor().blackClr,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 0,
                                      ),
                                      alignment: Alignment.center,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: MyColor().primaryClr,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Text(
                                        "+ Follow",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: MyColor().whiteClr,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: List.generate(list['Collaborator'].length, (
                                    index,
                                  ) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: _infoCard(
                                              title: "Organization",
                                              items: [
                                                _infoRow(
                                                  Iconsax.building,
                                                  list['Collaborator'][index]['member']['organizationName'],
                                                ),
                                                _infoRow(
                                                  Iconsax.location,
                                                  list['Collaborator'][index]['member']['location'],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: _infoCard(
                                              title: "Organizer",
                                              items: [
                                                _infoRow(
                                                  Iconsax.profile_circle,
                                                  list['Collaborator'][index]['member']['organizerName'],
                                                ),
                                                _infoRow(
                                                  Iconsax.call,
                                                  list['Collaborator'][index]['member']['organizerNumber'],
                                                ),
                                                if (list['Collaborator'][index]['member']['orgDept'] !=
                                                        null &&
                                                    list['Collaborator'][index]['member']['orgDept']
                                                        .isNotEmpty)
                                                  _infoRow(
                                                    Iconsax.book,
                                                    list['Collaborator'][index]['member']['orgDept'],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              // ------- Follow us on ------
                              if (list['socialLinks']['linkedin'] != null ||
                                  list['socialLinks']['linkedin'].isNotEmpty ||
                                  list['socialLinks']['instagram'] != null ||
                                  list['socialLinks']['instagram'].isNotEmpty ||
                                  list['socialLinks']['whatsapp'] != null ||
                                  list['socialLinks']['whatsapp'].isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor().boxInnerClr,
                                    border: Border.all(
                                      color: MyColor().borderClr.withOpacity(
                                        0.15,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Follow us on",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: MyColor().blackClr,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (list['socialLinks']['whatsapp'] !=
                                                        null &&
                                                    list['socialLinks']['whatsapp']
                                                        .isNotEmpty)
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final whatsApp = Uri.parse(
                                                        list['socialLinks']['whatsapp'],
                                                      );
                                                      await launchUrl(
                                                        whatsApp,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        5,
                                                      ),
                                                      child: Image.asset(
                                                        ImagePath().whatsapp,
                                                        height: 40,
                                                      ),
                                                    ),
                                                  ),

                                                if (list['socialLinks']['instagram'] !=
                                                        null &&
                                                    list['socialLinks']['instagram']
                                                        .isNotEmpty)
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final whatsApp = Uri.parse(
                                                        list['socialLinks']['instagram'],
                                                      );
                                                      await launchUrl(
                                                        whatsApp,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        5,
                                                      ),
                                                      child: Image.asset(
                                                        ImagePath().instagram,
                                                        height: 37,
                                                      ),
                                                    ),
                                                  ),

                                                if (list['socialLinks']['linkedin'] !=
                                                        null &&
                                                    list['socialLinks']['linkedin']
                                                        .isNotEmpty)
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final whatsApp = Uri.parse(
                                                        list['socialLinks']['linkedin'],
                                                      );
                                                      await launchUrl(
                                                        whatsApp,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        5,
                                                      ),
                                                      child: Image.asset(
                                                        ImagePath().linkedIn,
                                                        height: 35,
                                                      ),
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

                              // --------- Rate for Organizers Field -----
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 10,
                                ),
                                child: Text(
                                  "Rate for Organizers",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: MyColor().blackClr,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  final isFilled = index < starIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (starIndex == index + 1) {
                                          starIndex--;
                                        } else {
                                          starIndex = index + 1;
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        isFilled
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: isFilled
                                            ? MyColor().yellowClr
                                            : MyColor().borderClr,
                                        size: 30,
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              Container(
                                margin: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColor().borderClr.withOpacity(
                                      0.15,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 320,
                                        child: TextFormField(
                                          maxLines: 4,
                                          controller: commentController,
                                          validator: Validators().validComment,
                                          onTapOutside: (outSideTab) {
                                            WidgetsBinding
                                                .instance
                                                .focusManager
                                                .primaryFocus
                                                ?.unfocus();
                                          },
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: MyColor().whiteClr,
                                                width: 0.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: MyColor().whiteClr,
                                                width: 0.5,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: MyColor().whiteClr,
                                                width: 0.5,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                    color: MyColor().whiteClr,
                                                    width: 0.5,
                                                  ),
                                                ),
                                            hintText: "Share Your Thoughts",
                                            hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: MyColor().hintTextClr,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ------- Send Button -----
                                      Align(
                                        alignment: AlignmentGeometry.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {}
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              bottom: 16,
                                            ),
                                            alignment: Alignment.center,
                                            height: 40,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width /
                                                3,
                                            decoration: BoxDecoration(
                                              color: MyColor().primaryClr,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Text(
                                              "Send",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: MyColor().whiteClr,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ----- Report -----
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ReportPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                      ),
                                      alignment: Alignment.center,
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: BoxDecoration(
                                        color: MyColor().primaryBackgroundClr,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Iconsax.warning_2,
                                            color: MyColor().redClr,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Report Event",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: MyColor().blackClr,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                );
              } else if (eventDetailState is EventDetailFail) {
                return RefreshIndicator(
                  onRefresh: () async {
                    // context.read<EventListBloc>().add(FetchEventList());
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
                            "No Results Found",
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
              return SizedBox.shrink();
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: MyColor().whiteClr,
            boxShadow: [
              BoxShadow(
                color: MyColor().borderClr.withOpacity(0.30),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColor().boxInnerClr,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColor().borderClr.withOpacity(0.15),
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.bookmark_outline),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (checkPaymentLink) return;

                      final paymentUrl = Uri.parse(widget.paymentLink);

                      setState(() {
                        checkPaymentLink = true;
                      });

                      final canLaunch = await canLaunchUrl(paymentUrl);

                      if (!canLaunch) {
                        setState(() {
                          checkPaymentLink = false;
                        });
                        return;
                      }

                      await launchUrl(
                        paymentUrl,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        color: MyColor().primaryClr,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: checkPaymentLink
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyColor().whiteClr,
                              ),
                            )
                          : Text(
                              "Register",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: MyColor().whiteClr,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------- Custom Tab Bar --------------
  Widget customTabBar({required String title, required int index}) {
    final selectedValue = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: !selectedValue
              ? MyColor().boxInnerClr
              : MyColor().blueClr.withOpacity(0.15),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: MyColor().blackClr,
          ),
        ),
      ),
    );
  }

  Widget bulletText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 10, color: MyColor().primaryClr),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              // overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: MyColor().blackClr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required List<Widget> items}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.inner,
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(-5, -5),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 10,
            offset: Offset(3, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          ...items,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: MyColor().primaryClr.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 10, color: MyColor().primaryClr),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
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
    child: Icon(icon, size: 20),
  );
}

// -------- Custom Color Label ----------
Widget colorLabel({
  required String text,
  required Color color,
  required Color borderColor,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(44),
      // border: Border.all(color: borderColor),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: MyColor().blackClr,
      ),
    ),
  );
}

// ---------- Custom Ticket name -------
Widget tickerName({
  required String title,
  required IconData icon,
  required Color backClr,
}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
          decoration: BoxDecoration(
            color: backClr.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    ],
  );
}

// -------- skeleton loader ---------
Widget eventDetailShimmer() {
  return ListView(
    children: [
      // -------- Carousel --------
      Shimmer(
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyColor().sliderDotClr,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // -------- Indicator --------
      Shimmer(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: MyColor().sliderDotClr,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // -------- Title + Icons --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: MyColor().sliderDotClr,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),

      // -------- Labels --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 70,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),

      // -------- Register Button --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),

      // -------- Description --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 12,
                  width: 70,
                  decoration: BoxDecoration(
                    color: MyColor().sliderDotClr,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 20),

      // -------- Venue --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Host --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Discount --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Tags --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              6,
              (_) => Container(
                height: 32,
                width: 80,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
      ),

      // -------- Buttons --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: MyColor().sliderDotClr,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 20),

      // -------- Rating --------
      Shimmer(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: MyColor().sliderDotClr,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // -------- Comment Box --------
      Shimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: MyColor().sliderDotClr,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // -------- Send Button --------
      Shimmer(
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 30),
            child: Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                color: MyColor().sliderDotClr,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
