import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// date and time both picker dd MMM yyyy, hh:mm a format
class DateAndTimeController {
  Future<dynamic> selectedDateAndTimePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    return DateFormat('dd MMM yyyy, hh:mm a').format(finalDateTime);
  }

  // date and time yyyy-MM-dd, hh:mm a format
  Future<dynamic> selectedDateAndTimePickerFormate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    return DateFormat('yyyy-MM-dd, hh:mm a').format(finalDateTime);
  }

  // date picker only format is yyyy-MM-dd
  Future<dynamic> selectedDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    return DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}

class DateTimeBlock {
  late TextEditingController startController;
  late TextEditingController endController;

  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  late TextEditingController startDateController;
  late TextEditingController endDateController;

  DateTimeBlock()
    : startController = TextEditingController(),
      startDateController = TextEditingController(),
      startTimeController = TextEditingController(),
      endController = TextEditingController(),
      endDateController = TextEditingController(),
      endTimeController = TextEditingController();
}
