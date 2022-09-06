import 'package:flutter/material.dart';

class MyDateTimePicker {
  final BuildContext context;
  final String title;
  bool withTime;
  MyDateTimePicker({
    required this.context,
    required this.title,
    this.withTime = false,
  });
  Future<DateTime> getDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: title,
      confirmText: 'SELECT',
    );
    if (withTime) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: title,
        confirmText: 'SELECT',
      );
      return DateTime(
        pickedDate!.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime!.hour,
        pickedTime.minute,
      );
    }
    return DateTime(
      pickedDate!.year,
      pickedDate.month,
      pickedDate.day,
    );
  }
}
