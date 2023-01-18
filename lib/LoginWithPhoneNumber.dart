// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseseries/utils/utils.dart';
import 'package:firebaseseries/verifycode.dart';
import 'package:firebaseseries/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phonenumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone Number"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: phonenumberController,
                decoration: InputDecoration(
                  hintText: "+923135221088",
                ),
              ),
            ),
            RoundButton(
                title: "Login With Phone",
                onTap: () {
                  auth.verifyPhoneNumber(
                      phoneNumber: phonenumberController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        Util().toastMessage(e.toString());
                      },
                      codeSent: (String verification, token){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Verifycode(verification: verification,)));

                      },
                      codeAutoRetrievalTimeout: (e) {
                        Util().toastMessage(e.toString());
                      },);
                })
          ],
        ),
      ),
    );
  }
}
