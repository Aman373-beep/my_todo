import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_todo/Components/AddWorkDialog.dart';
import 'package:my_todo/Components/Update_AddWorkDialog.dart';
import 'package:my_todo/Model/Data.dart';
import 'package:my_todo/Screens/DetailScreen.dart';
import 'package:my_todo/Screens/TaskReport_Screen.dart';
import '../Components/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:my_todo/Provider/Todo.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
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
    x.fetchData();

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 200,
                //color: Colors.yellow[300],
                child: UserAccountsDrawerHeader(
                  arrowColor: Colors.white,
                  decoration: BoxDecoration(color: Colors.yellow),
                  accountName: Text(
                    'Sample pro',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  accountEmail: Text(
                    'sample_pro@outlook.com',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TaskReport_Screen();
                  }));
                },
                title: Text(
                  'Task Report',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
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
            /*showDialog(
            context: context,
            builder: (context) => AddWorkDialog(),
          );*/
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AddWorkDialog_Screen();
              }),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Consumer(
          builder: (context, index, child) => ListView.builder(
            itemCount: x.ad.length,
            itemBuilder: (BuildContext context, int index) {
              // Dismissble widget is a slider widget to delete the widget and datas.
              return Dismissible(
                key: ValueKey(x.ad[index]),
                background: Container(
                  color: Colors.lightGreen,
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  x.deleteData(index);
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 70,
                  decoration: BoxDecoration(
                    color: (x.ad[index].isChecked)
                        ? Colors.red
                        : Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CheckboxListTile(
                    secondary: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return update_AddWorkDialog_Screen(ind: index);
                          }));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.red,
                          size: 16,
                        )),
                    activeColor: Colors.black,
                    value: x.ad[index].isChecked,
                    subtitle: Text(
                      '${x.ad[index].date} ${x.ad[index].time}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: (x.ad[index].isChecked)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Details(ind: index);
                        }));
                      },
                      child: Text(
                        x.ad[index].work,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: (x.ad[index].isChecked)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      x.toggleCheckbox(index, value!);
                    },
                  ),
                ),
              );
            },
          ),
        ));
  }
}
