// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseseries/databases/postscreen.dart';
// import 'package:firebaseseries/utils/utils.dart';
import 'package:firebaseseries/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

class Verifycode extends StatefulWidget {
  final String verification;
  const Verifycode({super.key, required this.verification});

  @override
  State<Verifycode> createState() => _VerifycodeState();
}

class _VerifycodeState extends State<Verifycode> {
  // ignore: non_constant_identifier_names
  final VerifycodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify code screen"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: VerifycodeController,
                decoration: InputDecoration(
                  hintText: "6 Digit Code",
                ),
              ),
            ),
            RoundButton(
                title: "Verify",
                onTap: ()async {
                  final AuthCredential = PhoneAuthProvider.credential(
                      verificationId: widget.verification,
                      smsCode: VerifycodeController.text.toString());
                  try {
                   await auth.signInWithCredential(AuthCredential);
                   
                     Navigator.push(context,
                       MaterialPageRoute(builder: (context) => PostScreen()));
                  } catch (e) {}
                  // auth.verifyPhoneNumber(
                  //     phoneNumber: phonenumberController.text,
                  //     verificationCompleted: (_) {},
                  //     verificationFailed: (e) {
                  //       Util().toastMessage(e.toString());
                  //     },
                  //     codeSent: (String verification, token){
                  //       Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => Verifycode(verification: verification,)));

                  //     },
                  //     codeAutoRetrievalTimeout: (e) {
                  //       Util().toastMessage(e.toString());
                  //     },);
                })
          ],
        ),
      ),
    );
  }
}
