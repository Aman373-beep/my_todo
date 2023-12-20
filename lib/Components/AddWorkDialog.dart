import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/annotations.dart';
import 'package:my_todo/Screens/HomeScreen.dart';

import 'package:my_todo/Model/Data.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:my_todo/Provider/Todo.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class AddWorkDialog_Screen extends StatelessWidget {
  AddWorkDialog_Screen({super.key});
  var select;

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) {
        return TodoList();
      }),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Secondary(),
      ),
    );
  }
}

class Secondary extends StatelessWidget {
  const Secondary({super.key});

  @override
  // The overall add function and interraction of the TODOLIST model for adding is done here
  // There are 4 contoller and 4 textformfield that takes the data.
  // Floating action button pressing adds up the data to the realtime database.
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    Time _time = Time(hour: 11, minute: 30, second: 20);
    bool iosStyle = true;
    final x = Provider.of<TodoList>(context);

    TextEditingController timeController = TextEditingController(
      text: x.initval(),
    );
    TextEditingController dateController =
        TextEditingController(text: x.fetchDate());

    return Consumer(
        builder: ((context, value, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        (MaterialPageRoute(builder: (context) {
                          return Main();
                        })));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                backgroundColor: Colors.yellow,
                title: Text(
                  "My TODO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                shape: CircleBorder(),
                onPressed: () {
                  x.addData(
                    x.workController.text,
                    timeController.text,
                    dateController.text,
                    x.descController.text,
                    false,
                  );
                  x.workController.clear();
                  x.descController.clear();
                  timeController.clear();
                  dateController.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Main();
                  }));
                },
                child: Icon(Icons.done),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 25, top: 30),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Container(
                      height: 50,
                      width: w / 1.2,
                      child: TextFormField(
                        controller: x.workController,
                        decoration: InputDecoration(
                          labelText: 'Enter your task',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Container(
                      height: 60,
                      width: w / 1.2,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: x.descController,
                        textInputAction:
                            TextInputAction.newline, // Adjust text size here
                        decoration: InputDecoration(
                          labelText: 'Enter your Describtion',
                          // Adjust border and content padding to increase overall size
                          border: OutlineInputBorder(),
                          //contentPadding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.0277,
                    ),
                    Text(
                      "Time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.018,
                    ),
                    Container(
                      height: 50,
                      width: w / 1.2,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: timeController,
                        // initialValue: x.fetchTime().toString(),

                        textInputAction:
                            TextInputAction.newline, // Adjust text size here
                        decoration: InputDecoration(
                          hintText: 'Pickup your time',
                          // Adjust border and content padding to increase overall size
                          suffixIcon: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  showPicker(
                                    context: context,
                                    value: x.fetchTime(),
                                    maxHour: 22, minHour: 9,
                                    iosStylePicker: true,
                                    sunrise: TimeOfDay(
                                        hour: 6, minute: 0), // optional
                                    sunset: TimeOfDay(
                                        hour: 18, minute: 0), // optional
                                    duskSpanInMinutes: 120, // optional
                                    onChange: (value) {
                                      x.TimeChange(value, context);
                                      //timeController.text =
                                      // value.format(context);
                                    },
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.alarm,
                                size: 20.5,
                                color: Colors.black54,
                              )),
                          contentPadding: EdgeInsets.only(
                              left: 7, top: 10, right: 10, bottom: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.0277,
                    ),
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.018,
                    ),
                    Container(
                      height: 50,
                      width: w / 1.2,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: dateController,
                        textInputAction:
                            TextInputAction.newline, // Adjust text size here
                        decoration: InputDecoration(
                          hintText: 'Pickup your Date',
                          // Adjust border and content padding to increase overall size
                          suffixIcon: IconButton(
                              onPressed: () {
                                x.DatePicker(context);
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                size: 20.5,
                                color: Colors.black54,
                              )),
                          contentPadding: EdgeInsets.only(
                              left: 7, top: 10, right: 10, bottom: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.0277,
                    ),
                  ],
                ),
              ),
            )));
  }
}
