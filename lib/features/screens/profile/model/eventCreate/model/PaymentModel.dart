import 'dart:math';

import 'package:all_college_event_app/data/controller/Date&TimeController/Date&TimeController.dart';
import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PaymentModel extends StatefulWidget {
  const PaymentModel({super.key});

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
  String? countValue;
  bool freeOrPaid = false;

  // ------ local stored ticket ------
 final List<Map<String,dynamic>> ticketList = [];

 // -------- editing index --------
 int? editingIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    DataCell(Text(ticket['ticket_name'] ?? "-")),
                    DataCell(Text(ticket['amount']?.toString() ?? "free")),
                    DataCell(Text(ticket['total_count']?.toString() ?? "-")),
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
          margin: EdgeInsets.only(left: 16,right: 16),
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
                        margin: EdgeInsets.only(top: 20,right: 0),
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
                child: GestureDetector(
                  onTap: (){
                    // Navigator.pop(context);
                  },
                  child: Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Container(
                        margin: EdgeInsets.only(top: 20,right: 0),
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor().whiteClr,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: MyColor().primaryClr)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Preview",style: GoogleFonts.poppins(
                                fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().primaryClr
                            ),),
                            Icon(Iconsax.eye_copy,color: MyColor().primaryClr,)
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            child: MyModels().customButton(onPressed: (){}, title: "Submit"))
      ],
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
                MyModels().customDropdown(label: "Total Count *", hint: "Select Total Count", value: countValue, onChanged: (onChanged){
                  setState((){
                    countValue = onChanged;
                  });
                }, items: countList.map((e)=> DropdownMenuItem<String>(value: e.toString(),child: Text(e.toString()))).toList(), valid: Validators().validTotalCount),
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
        'ticket_name': ticketNameController.text,
        'description': descriptionController.text,
        'selling_from': sellingFromController.text,
        'selling_upto': sellingUpToController.text,
        'total_count': countValue ?? 0,
        'paid': freeOrPaid,
        if (amountController.text.isNotEmpty)
          'amount': amountController.text,
      };

      setState(() {
        if(editingIndex == null){
          ticketList.add(ticketData);
        } else{
          ticketList[editingIndex!] = ticketData;
        }
      });

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
    ticketNameController.text = ticket['ticket_name'] ?? '';
    descriptionController.text = ticket['description'] ?? '';
    sellingFromController.text = ticket['selling_from'] ?? '';
    sellingUpToController.text = ticket['selling_upto'] ?? '';
    amountController.text = ticket['amount']?.toString() ?? '';
    countValue = ticket['total_count'].toString();
    freeOrPaid = ticket['paid'] ?? false;

    print("countValuecountValuecountValuecountValue$countValue");
    editingIndex = index;

    // ------ ticket ui dialog -------
    ticketDialog();

  }

}
