import 'package:flutter/material.dart';

class AllData {
  late String work;
  late String desc;
  late String date;
  late String time;

  //Model for our project
  late bool isChecked;
  AllData(
      {required this.work,
      required this.time,
      required this.date,
      required this.desc,
      required this.isChecked});
}
