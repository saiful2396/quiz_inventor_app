import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/helper/functions.dart';
import 'package:quiz_inventor_app/views/home.dart';
import 'package:quiz_inventor_app/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    checkedUserLoggedInStatus();
    super.initState();
  }

  checkedUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}
