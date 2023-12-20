import 'package:flutter/material.dart';
import 'package:my_todo/Components/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:my_todo/Components/AddWorkDialog.dart';
import 'package:my_todo/Screens/HomeScreen.dart';
import 'package:my_todo/Provider/Todo.dart';

import 'Components/firebase_options.dart';

void main() async {
  //Flutter firebase widget binding initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoList(),
      child: Main(),
    ),
  );
}
