import 'package:another_flushbar/flushbar.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String numberToIdr(num param){  
  const String sysbol = 'Rp ';

  return NumberFormat.currency(
    locale: 'id',
    symbol: sysbol,
    decimalDigits: 0
  ).format(param);
}

// get current month
String getCurrentMonth() {
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM').format(now);
  return month;
}

// string to date d M yy
String stringToDate(String param) {
  DateTime now = DateTime.parse(param);
  String date = DateFormat('d MMM yyyy').format(now);
  return date;
}

// string to date Senin 12 januari 2025 11:32
String stringToDateTime(String param) {
  DateTime now = DateTime.parse(param);
  String date = DateFormat('dd MMM yyyy HH:mm').format(now);
  return date;
}

void customSnackbar(BuildContext context, String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    message: message,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.error, color:Colors.white)
  ).show(context);
}

void successSnackbar(BuildContext context, String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: greenColor,
    message: message,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.check, color:Colors.white)
  ).show(context);
}

// parse date from 2024-10-02 13:21:18 to 12 januari 2024
String parseDate2(String param) {
  DateTime now = DateTime.parse(param);
  String date = DateFormat('d MMMM yyyy').format(now);
  return date;
}

// parse time from 2024-10-02 13:21:18 to 13:21
String parseTime2(String param) {
  DateTime now = DateTime.parse(param);
  String date = DateFormat('HH:mm').format(now);
  return date;
}


// ge tcurrent month number 2 digits
String getCurrentMonthNumber() {
  DateTime now = DateTime.now();
  String month = DateFormat('MM').format(now);
  return month;
}