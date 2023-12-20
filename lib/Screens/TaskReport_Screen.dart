import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_todo/Components/AddWorkDialog.dart';
import 'package:my_todo/Components/Update_AddWorkDialog.dart';
import 'package:my_todo/Model/Data.dart';
import 'package:my_todo/Screens/DetailScreen.dart';
import 'package:my_todo/Screens/HomeScreen.dart';
import '../Components/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:my_todo/Provider/Todo.dart';

class TaskReport_Screen extends StatelessWidget {
  const TaskReport_Screen({super.key});

  @override
  // This Screen was built for showing the number of complete and incomplete and percentage of task.
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoList(),
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
  Widget build(BuildContext context) {
    final x = Provider.of<TodoList>(context);
    var h = MediaQuery.sizeOf(context).height;
    x.fetchData();

    return Consumer(
        builder: ((context, index, value) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.05),
                  Container(
                    height: 200,
                    width: h / 2.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Task',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('${x.ad.length}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700))
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.yellow[500],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(height: h * 0.02),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 200,
                          width: h / 4.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Complete Task',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${x.getCompleteTaskCount()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.yellow[500],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Container(
                          height: 200,
                          width: h / 4.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Incomplete Task',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${x.getIncompleteTaskCount()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.yellow[500],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.033),
                  Container(
                    height: 140,
                    width: h / 2.28,
                    child: Center(
                      child: Text(
                        'Completed Task Percentage : ${x.getCompletionPercentage().toStringAsFixed(2)}%',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ))));
  }
}
