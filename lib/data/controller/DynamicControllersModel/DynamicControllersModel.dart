import 'package:flutter/material.dart';

class EventHostItem {

  // -------- dropdown value -------
  String? selectOrganizationDepart;
  String? selectHostBy;


  // ------ Controllers -------
  final organizationNameController = TextEditingController();
  final locationController = TextEditingController();
  final organizerNumberController = TextEditingController();
  final organizerNameController = TextEditingController();

  // ------- convert json --------
  Map<String,dynamic> toJson() => {
    'hostIdentity' : selectHostBy,
    'organizationName' : organizationNameController.text,
    'location' : locationController.text,
    'organizerNumber' : organizerNumberController.text,
    'organizerName' : organizerNameController.text,
    'orgDept' : selectOrganizationDepart,
  };
}