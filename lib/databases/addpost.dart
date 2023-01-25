import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseseries/databases/postscreen.dart';
import 'package:firebaseseries/utils/utils.dart';
import 'package:firebaseseries/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final postController = TextEditingController();
  final database =
      FirebaseDatabase.instance.ref('post data in firebase relatime database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD POST "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                  hintText: "what u enetr in flutter firebase data base"),
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
                title: 'add',
                onTap: () {
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  database.child(id).set({
                    'Cgpa': 2.55,
                    "description": 'successfully pass out from llu',
                    "title": postController.text.toString(),
                    "id": id,
                  }).then((value) {
                    Util().toastMessage("post addaed success fully");
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
