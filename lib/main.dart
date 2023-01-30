import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseseries/databases/addpost.dart';
import 'package:firebaseseries/databases/postscreen.dart';
import 'package:firebaseseries/firestore/addfirestoredata.dart';
import 'package:firebaseseries/loginpage.dart';
// import 'package:firebaseseries/loginpage.dart';
import 'package:firebaseseries/signupscreen.dart';
import 'package:flutter/material.dart';

import 'LoginWithPhoneNumber.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const AddFireSTorDta(),
    );
  }
}
