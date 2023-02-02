import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/roundedbutton.dart';

class AddFireSTorDta extends StatefulWidget {
  const AddFireSTorDta({super.key});

  @override
  State<AddFireSTorDta> createState() => _AddFireSTorDtaState();
}

class _AddFireSTorDtaState extends State<AddFireSTorDta> {

  final postController = TextEditingController();

  final firestore = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              decoration: InputDecoration(hintText: "whAts In yOUr MinD????"),
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
                title: 'add',
                onTap: () {
                  String id = DateTime.now().millisecond.toString();
                  firestore.doc(id).set({
                    "title": postController.text.toString(),
                    "id": id,
                    "description": "hello fellows",
                  }).then((value) {
                    Util().toastMessage("Data add in add firestore database");
                  }).onError((error, stackTrace) {
                    Util().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
