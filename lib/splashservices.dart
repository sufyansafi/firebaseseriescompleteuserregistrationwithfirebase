import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseseries/databases/postscreen.dart';
import 'package:firebaseseries/firestore/forestorelistscreen.dart';
import 'package:firebaseseries/firestore/uploadimagefile.dart';
import 'package:firebaseseries/loginpage.dart';
import 'package:flutter/material.dart';

import 'databases/addpost.dart';
import 'firestore/addfirestoredata.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
// its mean if user is alrady login then go to firestorelistscreen page other wise go to loginpage//
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UploadImageFireStore())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }
  }
}
