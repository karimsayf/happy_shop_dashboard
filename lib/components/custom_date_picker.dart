
import 'package:flutter/material.dart';

showCustomDatePicker({required Function(DateTime? dateTime) callback,required BuildContext context,DateTime? firstDate, DateTime? lastDate}){
  showDatePicker(
      barrierDismissible: false,
      confirmText: 'اختيار',
      cancelText: 'الغاء',
      helpText: 'اختيار تاريخ',
      context: context,
      firstDate: firstDate?? DateTime(1950),
      lastDate: lastDate ?? DateTime.now())
      .then(
        (value) {
      callback(value);
    },
  );
}