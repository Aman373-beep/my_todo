// ignore_for_file: deprecated_member_use

import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../Model/Data.dart';

class TodoList extends ChangeNotifier {
  List<AllData> ad = [];
  List<String> l = [];
  var index = 0;
  TextEditingController workController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  var val = "";
  var val1 = "";
  DateTime date = DateTime.now();
  DatabaseReference db = FirebaseDatabase.instance.reference().child('My data');
  int counter = 0;
  void increase() {
    notifyListeners();
  }

// Adopts the time change or the new time.
  void TimeChange(Time newTime, context) {
    _time = newTime;
    val = newTime.format(context) + '';
    notifyListeners();
  }

// Returns the Time instance updated for controller.
  Time fetchTime() {
    notifyListeners();
    return _time;
  }

// Returns the String value for controller.
  String initval() {
    notifyListeners();
    return val;
  }

// Date Picker implementation
  Future<void> DatePicker(BuildContext context) async {
    DateTime? dp = await showDatePicker(
        initialDate: date,
        context: context,
        firstDate: DateTime(1999),
        lastDate: DateTime(2027));
    if (dp != null && dp != date) {
      date = dp;
      val1 = "${date.day} /${date.month} /${date.year}";
      notifyListeners();
    }
    notifyListeners();
  }

//Retreives the Date selected by user
  String fetchDate() {
    notifyListeners();
    return val1;
  }

// Retrives the data from database
  fetchData() {
    db.onChildAdded.listen((event) {
      var sent = event.snapshot.value as Map;
      var k = event.snapshot.key as String;
      if (!l.contains(k)) {
        l.add(k);
        ad.add(AllData(
            work: sent['work'],
            time: sent['time'],
            date: sent['date'],
            desc: sent['desc'],
            //category: sent['category'],
            isChecked: sent['isChecked']));
      }

      notifyListeners();
    });
  }

// Adds the data to the database
  void addData(String work, String time, String date, String desc, bool val) {
    Map<dynamic, dynamic> m1 = {
      'work': work,
      'time': time,
      'date': date,
      'desc': desc,
      // 'category': category,
      'isChecked': val,
    };
    db.push().set(m1);
    notifyListeners();
    // fetchData();
  }

// Deletes the data of specific index
  void deleteData(int index) {
    if (index == ad.length - 1) {
      db.child(l[index]).remove();
    } else {
      db.child(l[index]).remove();
      increase();
    }
    ad.removeAt(index);
    notifyListeners();
  }

// Update the data
  void updateData(int index, var work, var time, var date, var desc, bool val) {
    fetchData();
    if (work.isNotEmpty) {
      db.child(l[index]).update({"work": work});
    }
    if (time.isNotEmpty) {
      db.child(l[index]).update({"time": time});
    }
    if (date.isNotEmpty) {
      db.child(l[index]).update({"date": date});
    }
    if (desc.isNotEmpty) {
      db.child(l[index]).update({"desc": desc});
    }
    notifyListeners();
  }

// It toggles the changes of the checkbox
  void toggleCheckbox(int index, bool val) {
    ad[index].isChecked = val;
    db.child(l[index]).update({"isChecked": val});
    notifyListeners();
  }

//Retrieves the number of completed task
  int getCompleteTaskCount() {
    return ad.where((todo) => todo.isChecked).length;
  }

// Retrieves the number of incomplete task
  int getIncompleteTaskCount() {
    return ad.length - getCompleteTaskCount();
  }

// Retrives the percentage of completed task
  double getCompletionPercentage() {
    int totalTasks = ad.length;
    double percentage =
        (totalTasks == 0) ? 0 : (getCompleteTaskCount() / totalTasks) * 100;
    return percentage;
  }
}
