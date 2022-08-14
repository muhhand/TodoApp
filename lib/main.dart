import 'package:flutter/material.dart';
import 'package:todo_app/Screens/addnote.dart';
import 'package:todo_app/Test/Home.dart';
import 'package:todo_app/Screens/HomeM.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  Home(),
      routes: {"addnotes": (context) => AddNotes()},
    );
  }
}


