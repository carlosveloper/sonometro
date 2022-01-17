import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miapp/core/utils/utils.dart';

extension AsyncSnapshotValidateError on AsyncSnapshot<Object?> {
  String? getStringError(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.error != null) {
      return snapshot.error.toString();
    }

    return null;
  }
}

extension StringExtension on String {
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();

  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize)
      .join(' ');

  bool get validateCorreo => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  String dayDiference() {
    var dateTime = DateTime.parse(this).toLocal();

    var date = DateTime.now().toLocal();

    var formatDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime)).toLocal();
    date = DateTime.parse(DateFormat('yyyy-MM-dd').format(date)).toLocal();
    var difference = date.difference(formatDateTime).inDays;

    return difference.toString();
  }

  String time() {
    /* var dateTime = DateTime.parse(this).toLocal();
    var date = DateTime.now().toLocal();

    var formatDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime)).toLocal();

    date = DateTime.parse(DateFormat('yyyy-MM-dd').format(date)).toLocal();

    var difference = date.difference(formatDateTime).inDays; */

    var dateTime = DateTime.parse(this).toLocal();

    var date = DateTime.now().toLocal();

    var formatDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime)).toLocal();
    date = DateTime.parse(DateFormat('yyyy-MM-dd').format(date)).toLocal();
    var difference = date.difference(formatDateTime).inDays;

    return dayTimePresentation(difference, dateTime);
  }

  String formatTime({String formato = 'HH:mm a'}) {
    var dateTime = DateTime.parse(this).toLocal();

    var formattedDate = DateFormat(formato).format(
      dateTime,
    );

    return formattedDate;
  }

  double priceToDouble() {
    var onlyDigits = replaceAll(RegExp('[^0-9]'), '');
    return double.parse(onlyDigits) / 100;
  }
}
