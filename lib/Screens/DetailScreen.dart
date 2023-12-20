import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_todo/Components/AddWorkDialog.dart';
import 'package:my_todo/Model/Data.dart';
import 'package:my_todo/Screens/HomeScreen.dart';
import '../Components/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:my_todo/Provider/Todo.dart';

class Details extends StatelessWidget {
  final int ind;
  Details({super.key, required this.ind});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) {
        return TodoList();
      }),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Details_Main(ind: ind),
      ),
    );
  }
}

class Details_Main extends StatelessWidget {
  final int ind;
  Details_Main({super.key, required this.ind});

  @override
  Widget build(BuildContext context) {
    // Provider.of() function used to retrieved the data from the model for consumer model.
    final x = Provider.of<TodoList>(context);
    x.fetchData();
    var h = MediaQuery.sizeOf(context).height;
    // Scaffold wrapped under Consumer model.
    return Consumer(
        builder: (context, data, index) => Scaffold(
            backgroundColor: Colors.yellow[300],
            resizeToAvoidBottomInset: false,
            // Appbar having icon for retrieveing backward.
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
            // Shows the overall data in full retrieved freom database.
            body: Padding(
              padding: EdgeInsets.only(left: 20, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Name of the Task :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                        )),
                    WidgetSpan(
                        child: SizedBox(
                      width: 7.5,
                    )),
                    TextSpan(
                        text: x.ad.isNotEmpty ? x.ad[ind].work : "<None>",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ))
                  ])),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Task Assigned Date :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )),
                    WidgetSpan(
                        child: SizedBox(
                      width: 7.5,
                    )),
                    TextSpan(
                        text: x.ad.isNotEmpty ? x.ad[ind].date : "<None>",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ))
                  ])),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Task Assigned Time :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                        )),
                    WidgetSpan(
                        child: SizedBox(
                      width: 7.5,
                    )),
                    TextSpan(
                        text: x.ad.isNotEmpty ? x.ad[ind].time : "<None>",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ))
                  ])),
                  SizedBox(
                    height: h * 0.035,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Task Description :",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.red,
                          )),
                      WidgetSpan(
                          child: SizedBox(
                        width: 7.5,
                      )),
                      TextSpan(
                          text: x.ad.isNotEmpty ? x.ad[ind].desc : "<None>",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ))
                    ])),
                  ))
                ],
              ),
            )));
  }
}
