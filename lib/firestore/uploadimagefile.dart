import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseseries/utils/utils.dart';
import 'package:firebaseseries/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageFireStore extends StatefulWidget {
  const UploadImageFireStore({super.key});

  @override
  State<UploadImageFireStore> createState() => _UploadImageFireStoreState();
}

class _UploadImageFireStoreState extends State<UploadImageFireStore> {
  // leet we create refrence and inastance for excexx the database firestore//

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  //FirebaseDatabase DatabaseReference = FirebaseDatabase.instance.ref("Sufyan Safi") as FirebaseDatabase;
  final database = FirebaseDatabase.instance.ref("Users");
  // final firestore = FirebaseFirestore.instance.collection("Users");
  File? image;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);

    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print("Noo Image FouNd");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              getGalleryImage();
            },
            child: Container(
                height: 500,
                width: 400,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 69, 22, 176),
                    border: Border.all()),
                child: image != null
                    ? Image.file(image!.absolute)
                    : Icon(Icons.image)),
          ),
          RoundButton(
              title: "Upload Image",
              onTap: () async {
                //lets we  cretae a refrence for upload an aimage innfirebasse firetore data base tht we needd refrenc to upload image//
                firebase_storage.Reference ref =
                    firebase_storage.FirebaseStorage.instance.ref(
                        "/Pics Folder/${DateTime.now().millisecondsSinceEpoch}");
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(image!.absolute);
                Future.value(uploadTask);
                var url = await ref.getDownloadURL();
                database
                    .child("1")
                    .set({"id": '11', "title": url.toString()}).then((value) {
                  Util().toastMessage("Uploded image");
                }).onError((error, stackTrace) {
                  Util().toastMessage(error.toString());
                });
              })
        ],
      ),
    );
  }
}
