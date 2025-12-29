import 'package:all_college_event_app/data/uiModels/MyModels.dart';
import 'package:all_college_event_app/features/screens/profile/bloc/eventCreateDropdown/orgCategories/org_categories_bloc.dart';
import 'package:all_college_event_app/features/screens/profile/model/eventCreate/ui/EventCreateDetailPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationCreateDetailModel extends StatefulWidget {
  const OrganizationCreateDetailModel({super.key});

  @override
  State<OrganizationCreateDetailModel> createState() => _OrganizationCreateDetailModelState();
}

class _OrganizationCreateDetailModelState extends State<OrganizationCreateDetailModel> {


  List<Map<String,dynamic>> orgDepartment = [
    { "code": "CSE", "name": "Computer Science and Engineering" },
    { "code": "IT", "name": "Information Technology" },
    { "code": "ECE", "name": "Electronics and CE" },
    { "code": "EEE", "name": "Electrical and EE" },
    { "code": "MECH", "name": "Mechanical Engineering" },
    { "code": "CIVIL", "name": "Civil Engineering" },
    { "code": "AI_DS", "name": "Artificial Intelligence and DS" },
    { "code": "AI_ML", "name": "Artificial Intelligence and ML" },
    { "code": "DS", "name": "Data Science" },
    { "code": "CYBER", "name": "Cyber Security" },
    { "code": "ISE", "name": "Information Science and Engineering" },
    { "code": "ROBOTICS", "name": "Robotics and Automation" },
    { "code": "MECHATRONICS", "name": "Mechatronics Engineering" },
    { "code": "AERO", "name": "Aeronautical Engineering" },
    { "code": "AUTO", "name": "Automobile Engineering" },
    { "code": "BIOTECH", "name": "Biotechnology" },
    { "code": "CHEM", "name": "Chemical Engineering" },
    { "code": "BME", "name": "Biomedical Engineering" },
    { "code": "BSC_CS", "name": "B.Sc Computer Science" },
    { "code": "BSC_IT", "name": "B.Sc Information Technology" },
    { "code": "BSC_MATHS", "name": "B.Sc Mathematics" },
    { "code": "BSC_PHYSICS", "name": "B.Sc Physics" },
    { "code": "BSC_CHEM", "name": "B.Sc Chemistry" },
    { "code": "BCA", "name": "Bachelor of CA" },
    { "code": "BBA", "name": "Bachelor of BA" },
    { "code": "BCOM", "name": "Bachelor of Commerce" },
    { "code": "BA", "name": "Bachelor of Arts" },
    { "code": "MCA", "name": "Master of CA" },
    { "code": "MBA", "name": "Master of BA" },
    { "code": "MSC_CS", "name": "M.Sc Computer Science" },
    { "code": "MSC_MATHS", "name": "M.Sc Mathematics" }
  ];
  
  // -------- dropdown value -------
  String? selectOrgCategories;

  // ------ Controllers -------
  final organizationNameController = TextEditingController();


  // ------- form global key -------
  final formKey = GlobalKey<FormState>();
  
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
                              value: 0.1,
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
                              value: 0.0,
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
                              value: 0.0,
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

          // ------ event host Dropdown ----------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 20),
              child: BlocBuilder<OrgCategoriesBloc, OrgCategoriesState>(
                builder: (context, orgCategoriesState) {
                  if(orgCategoriesState is OrgCategoriesLoading){
                    return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                  } else if(orgCategoriesState is OrgCategoriesSuccess){
                   return SizedBox(
                     width: 320,
                     child: MyModels().customDropdown(label: "Event Host By *", hint: "Select your Organization Category", value: selectOrgCategories, onChanged: (orgCategory){

                     }, items: orgCategoriesState.orgCategoriesList.map((e)=> DropdownMenuItem<String>(value: e['identity'],child: Text(e['categoryName']))).toList(), valid: Validators().validOrgCategories),
                   );
                 } else if(orgCategoriesState is OrgCategoriesFail){
                   return Center(child: Text(orgCategoriesState.errorMessage),);
                 } return SizedBox.shrink();
                },
              ),
            ),
          ),

          SizedBox(height: 20,),

          // ------ Organization Name -------
          MyModels().customTextField(label: "Organization Name *", controller: organizationNameController, hintText: "Enter Organization Name", validator: Validators().validOrganizationName, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false),

          SizedBox(height: 20,),

          // ----- Location --------
          MyModels().customTextField(label: "Location *", controller: organizationNameController, hintText: "Enter Organization Name", validator: Validators().validLocation, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false),

          SizedBox(height: 20,),

          // ---------- Organizer Number --------
          MyModels().customTextField(label: "Organizer Number *", controller: organizationNameController, hintText: "Phone number", validator: Validators().validOrganizationPhone, textInputType: TextInputType.text, textCapitalization: TextCapitalization.words, readOnly: false),

          SizedBox(height: 20,),

          // ------- Organization Department --------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 20),
              child: BlocBuilder<OrgCategoriesBloc, OrgCategoriesState>(
                builder: (context, orgCategoriesState) {
                  if(orgCategoriesState is OrgCategoriesLoading){
                    return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                  } else if(orgCategoriesState is OrgCategoriesSuccess){
                    return SizedBox(
                      width: 320,
                      child: MyModels().customDropdown(label: "Organization Department *", hint: "Select your Organization Department", value: selectOrgCategories, onChanged: (orgCategory){

                      }, items: orgDepartment.map((e)=> DropdownMenuItem<String>(value: e['code'],child: Text(e['name']))).toList(), valid: Validators().validOrgDepartment),
                    );
                  } else if(orgCategoriesState is OrgCategoriesFail){
                    return Center(child: Text(orgCategoriesState.errorMessage),);
                  } return SizedBox.shrink();
                },
              ),
            ),
          ),

          // ----- Add Collaborate -----------
          Align(
            alignment: AlignmentGeometry.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 16,right: 16),
              height: 48,
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: MyColor().primaryClr)
                ),
                child: Text("Add Collaborators +")),
          ),

          // ----- Select Eligible Department -------
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 20),
              child: BlocBuilder<OrgCategoriesBloc, OrgCategoriesState>(
                builder: (context, orgCategoriesState) {
                  if(orgCategoriesState is OrgCategoriesLoading){
                    return Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),);
                  } else if(orgCategoriesState is OrgCategoriesSuccess){
                    return SizedBox(
                      width: 320,
                      child: MyModels().customDropdown(label: "Eligible Department *", hint: "Select Eligible Department", value: selectOrgCategories, onChanged: (orgCategory){

                      }, items: orgDepartment.map((e)=> DropdownMenuItem<String>(value: e['code'],child: Text(e['name']))).toList(), valid: Validators().validEligibleDepartment),
                    );
                  } else if(orgCategoriesState is OrgCategoriesFail){
                    return Center(child: Text(orgCategoriesState.errorMessage),);
                  } return SizedBox.shrink();
                },
              ),
            ),
          ),

          // ------- Continue -------
          GestureDetector(
            onTap: (){
              // if(formKey.currentState!.validate()){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> EventCreateDetailPage()));
              // }
            },
            child: Align(
              alignment: AlignmentGeometry.topRight,
              child: Container(
                  margin: EdgeInsets.only(top: 20,right: 16),
                  height: 48,
                  width: MediaQuery.of(context).size.width/2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColor().primaryClr,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: MyColor().primaryClr)
                  ),
                  child: Text("Continue",style: GoogleFonts.poppins(
                    fontSize: 14,fontWeight: FontWeight.w600,color: MyColor().whiteClr
                  ),)),
            ),
          ),

          SizedBox(height: 30,),

        ],
      ),
    );
  }
}
