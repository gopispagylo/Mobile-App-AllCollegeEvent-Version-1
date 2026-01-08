import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/toast/AceToast.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateBloc/event_create_bloc.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class PaymentModel extends StatefulWidget {

  final Map<String,dynamic> orgDetailList;

  const PaymentModel({super.key, required this.orgDetailList});

  @override
  State<PaymentModel> createState() => _PaymentModelState();
}

class _PaymentModelState extends State<PaymentModel> {

  // ------- controller ------
  final paymentController = TextEditingController();
  final ticketNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sellingFromController = TextEditingController();
  final sellingUpToController = TextEditingController();
  final amountController = TextEditingController();

  // ----- count list -----
  final List<int> countList = [
    100,200,300,500,1000,2000
  ];

  // --- dropdown value ----
  int? countValue;
  bool freeOrPaid = false;

  // ------ local stored ticket ------
 final List<Map<String,dynamic>> ticketList = [];

 // -------- editing index --------
 int? editingIndex;

  // ------- form global key -------
  final formKey = GlobalKey<FormState>();


  // ------- backend send date&time format change --------
  String toIsoDate(String dateText) {
    final inputFormat = DateFormat("dd MMM yyyy, hh:mm a");
    final dateTime = inputFormat.parse(dateText);

    return dateTime.toUtc().toIso8601String();
  }

  @override
  void initState() {
    super.initState();
    print("lalallalalalaalalalaalalalal${widget.orgDetailList}");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 1,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Organization Details",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 1,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Event Details",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: MyColor().primaryClr,
                              value: 0.5,
                              strokeWidth: 5,
                              backgroundColor: MyColor().borderClr.withOpacity(0.30),
                              valueColor: AlwaysStoppedAnimation(MyColor().primaryClr),
                            ),
                          ),
                          Icon(Icons.newspaper),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(textAlign: TextAlign.center,"Media & Tickets",style: GoogleFonts.poppins(
                            fontSize: 13,fontWeight: FontWeight.w600,color: MyColor().blackClr
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),

          // ---------- payment ------
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text("Payment Link *",style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),),
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    controller: paymentController,
                    validator: Validators().validPayment,
                    onTapOutside: (outSideTab){
                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Iconsax.link),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColor().borderClr,width: 0.5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColor().primaryClr,width: 0.5)
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColor().redClr,width: 0.5)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColor().redClr, width: 0.5)
                      ),
                      hintText: "Enter the link for payment",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: MyColor().hintTextClr
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 20,),

          // ------- ticket -------
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tickets *",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),),
                // ------- ticket button -------
                if(ticketList.isNotEmpty)  GestureDetector(
                  onTap: ticketDialog,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      height: 48,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColor().primaryClr,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("Add",style: GoogleFonts.poppins(
                          fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().whiteClr
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),

          // ------- ticket button -------
          if(ticketList.isEmpty) GestureDetector(
            onTap: ticketDialog,
            child: Center(
              child: Container(
                height: 48,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor().primaryClr,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Add",style: GoogleFonts.poppins(
                  fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().whiteClr
                ),),
              ),
            ),
          ),
          if(ticketList.isEmpty) SizedBox(height: 10,),
          if(ticketList.isEmpty) Center(
            child: Text('Ticket is empty!  Click to create ticket',style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,fontSize: 14,color: MyColor().primaryClr
            ),),
          ),
          if(ticketList.isNotEmpty) Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColor().boxInnerClr,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  // --------- title --------
                  columns: [
                    DataColumn(label: Text("Ticket Name")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Total")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                  ], rows: List.generate(ticketList.length, (index){
                final ticket = ticketList[index];
                    return DataRow(cells: [
                      DataCell(Text(ticket['name'] ?? "-")),
                      DataCell(Text(ticket['price']?.toString() ?? "free")),
                      DataCell(Text(ticket['totalQuantity']?.toString() ?? "-")),
                      DataCell(GestureDetector(
                          onTap: () {
                            editTicket(index);
                          },
                          child: Icon(Iconsax.edit_copy,))),
                      DataCell(GestureDetector(
                          onTap: (){
                            setState(() {
                              ticketList.removeAt(index);
                            });
                          },
                          child: Icon(Iconsax.trash_copy,color: MyColor().redClr,))),
                    ]);
              })),
            )
          ),

          // -------- back and preview and submit ---------
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 30),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor().whiteClr,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: MyColor().primaryClr)
                          ),
                          child: Text("Back",style: GoogleFonts.poppins(
                              fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                          ),)),
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: BlocConsumer<EventCreateBloc, EventCreateState>(
                    listener: (context, eventCreateState) {
                      if (eventCreateState is EventCreateSuccess) {
                        FlutterToast().flutterToast("Event created successfully 🎉", ToastificationType.success, ToastificationStyle.flat);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BottomNavigationBarPage(pageIndex: 4,)));
                      }
                    },
                    builder: (context, eventCreateState) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(0, 48),
                          backgroundColor: MyColor().primaryClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: ticketList.isNotEmpty ?  () {
                          MyModels().alertDialogCustomizeEdit(context, 'Event Submitted Successfully', Text(textAlign: TextAlign.center,ConfigMessage().confirmMessageForEventCreate,style: GoogleFonts.poppins(
                            fontSize: 14,color: MyColor().blackClr,fontWeight: FontWeight.w500,
                          ),), (){
                            Navigator.pop(context);
                          }, (){ if(formKey.currentState!.validate()){

                            final orgDetail = widget.orgDetailList;

                            context.read<EventCreateBloc>().add(ClickEventCreate(
                                title: orgDetail['title'],
                                description: orgDetail['description'],
                                mode: orgDetail['mode'],
                                categoryIdentity: orgDetail['categoryIdentity'],
                                eventTypeIdentity: orgDetail['eventTypeIdentity'],
                                perkIdentities: orgDetail['perkIdentities'],
                                accommodationIdentities: orgDetail['accommodationIdentities'],
                                certIdentity: orgDetail['certIdentity'],
                                eligibleDeptIdentities: orgDetail['eligibleDeptIdentities'],
                                tags: orgDetail['tags'],
                                collaborators: List<Map<String, dynamic>>.from(
                                  orgDetail['orgDetailList'].map((item) => {
                                    'hostIdentity': item['hostIdentity'],
                                    'organizationName': item['organizationName'],
                                    'organizerNumber': item['organizerNumber'],
                                    'orgDept': item['orgDept'],
                                    'organizerName': item['organizerName'],
                                    'location': item['location'],
                                  }),
                                ),
                                calendars: orgDetail['calendars'],
                                tickets: ticketList.map((ticket){
                                  return {
                                    ...ticket,
                                    'sellingFrom': toIsoDate(ticket['sellingFrom']),
                                    'sellingTo': toIsoDate(ticket['sellingTo']),
                                  };
                                }).toList(),
                                paymentLink: paymentController.text,
                                socialLinks: {},
                                bannerImages: orgDetail['bannerImages'], eventLink: orgDetail['eventLink'] ?? '', location: orgDetail['location'] != null && orgDetail['location'].isNotEmpty ? {
                              "country": orgDetail['location']['country'],
                              "state": orgDetail['location']['state'],
                              "city": orgDetail['location']['city'],
                              "mapLink": orgDetail['location']['mapLink'],
                              "venue": orgDetail['location']['venue'],
                            } : {}
                            ));
                          }}, "Cancel", "Confirm");
                        } : null,
                        child: eventCreateState is EventCreateLoading
                            ? Center(
                          child: CircularProgressIndicator(color: MyColor().whiteClr,),)
                            : Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MyColor().whiteClr,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }

  // ---------- ticket dialog ------
  void ticketDialog() async{
    MyModels().alertDialogContentCustom(
        context: context,
        content: StatefulBuilder(
        builder: (context,setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                MyModels().customTextField(label: "Ticket Name *", controller: ticketNameController, hintText: "Enter Ticket Name", validator: Validators().validTicketName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false),
                SizedBox(height: 20,),
                MyModels().customTextField(label: "Description *", controller: descriptionController, hintText: "Describe about the Event", validator: Validators().validDescription, textInputType: TextInputType.text, textCapitalization: TextCapitalization.sentences, readOnly: false),
                SizedBox(height: 20,),
                MyModels().customDateAndTimeUi(controller: sellingFromController, onTap: () async{
                  final result = await DateAndTimeController().selectedDateAndTimePicker(context);
                  if(result != null){
                    sellingFromController.text = result;
                  }
                }, label: "Selling From *"),
                SizedBox(height: 20,),
                MyModels().customDateAndTimeUi(controller: sellingUpToController, onTap: () async{
                  final result = await DateAndTimeController().selectedDateAndTimePicker(context);
                  if(result != null){
                    sellingUpToController.text = result;
                  }
                }, label: "Selling From *"),
                SizedBox(height: 20,),
            MyModels().customDropdown<int>(
              label: "Total Count *",
              hint: "Select Total Count",
              value: countValue,
              onChanged: (value) {
                setState(() {
                  countValue = value;
                });
              },
              items: countList.map((e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text(e.toString()),
                ),
              ).toList(),
              valid: (value) {
                if (value == null) {
                  return 'Please select total count';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
                Row(
                  children: [
                    Text( freeOrPaid ? "Paid" : "Free",style: GoogleFonts.poppins(
                        fontSize: 14,fontWeight: FontWeight.w500,color: freeOrPaid ? MyColor().primaryClr : MyColor().blackClr
                    ),),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(value: freeOrPaid, onChanged: (onChanged){
                        setState(() {
                          freeOrPaid = onChanged;
                        });
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                if(freeOrPaid) MyModels().customTextField(label: "Amount *", controller: amountController, hintText: "Enter amount", validator: Validators().validAmount, textInputType: TextInputType.number, textCapitalization: TextCapitalization.none, readOnly: false),
                if(freeOrPaid) SizedBox(height: 20,),
                MyModels().customButton(onPressed: (){
                  addTicket();
                }, title: editingIndex == null ? "Add Ticket" : "update Ticket")
              ],
            ),
          );
        }
    ));
  }

  // -----add ticket -------
  void addTicket() {

      final ticketData = {
        'name': ticketNameController.text,
        'description': descriptionController.text,
        'sellingFrom': sellingFromController.text,
        'sellingTo': sellingUpToController.text,
        'totalQuantity': countValue,
        'isPaid': freeOrPaid,
        if (amountController.text.isNotEmpty)'price': amountController.text,
      };


      setState(() {
        if(editingIndex == null){
          ticketList.add(ticketData);
        } else{
          ticketList[editingIndex!] = ticketData;
        }
      });

      print("bdhsdjhdhjdfjhdf$ticketList");
    // clear form
    ticketNameController.clear();
    descriptionController.clear();
    sellingFromController.clear();
    sellingUpToController.clear();
    amountController.clear();
    countValue = null;
    freeOrPaid = false;
    editingIndex = null;

    Navigator.pop(context);
  }

  // --------- edit ticket --------
  void editTicket(int index) {

    final ticket = ticketList[index];

    // ---------- fill fields ----------
    ticketNameController.text = ticket['name'] ?? '';
    descriptionController.text = ticket['description'] ?? '';
    sellingFromController.text = ticket['sellingFrom'] ?? '';
    sellingUpToController.text = ticket['sellingTo'] ?? '';
    amountController.text = ticket['price']?.toString() ?? '';
    countValue = ticket['totalQuantity'];
    freeOrPaid = ticket['isPaid'] ?? false;

    editingIndex = index;

    // ------ ticket ui dialog -------
    ticketDialog();

  }

// Expanded(
//   child: GestureDetector(
//     onTap: (){
//       // Navigator.pop(context);
//     },
//     child: Align(
//       alignment: AlignmentGeometry.topRight,
//       child: Container(
//           margin: EdgeInsets.only(top: 20,right: 0),
//           height: 48,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: MyColor().whiteClr,
//               borderRadius: BorderRadius.circular(30),
//               border: Border.all(color: MyColor().primaryClr)
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Preview",style: GoogleFonts.poppins(
//                   fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
//               ),),
//               Icon(Iconsax.eye_copy,color: MyColor().primaryClr,)
//             ],
//           )),
//     ),
//   ),
// ),



}
