import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseseries/databases/addpost.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseseries/loginpage.dart';
import 'package:firebaseseries/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final refrence =
      FirebaseDatabase.instance.ref('post data in firebase relatime database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Screen "),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }).onError((error, stackTrace) {
                    Util().toastMessage(error.toString());
                  });
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                if (snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list[index]["title"]),
                        subtitle: Text(list[index]["description"]),
                      );
                    },
                    itemCount: snapshot.data!.snapshot.children.length,
                  );
                }
              }),
              stream: refrence.onValue,
            )),
            Expanded(
              child: FirebaseAnimatedList(
                  query: refrence,
                  itemBuilder: ((context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle:
                          Text(snapshot.child("description").value.toString()),
                      trailing: Text(snapshot.child("Cgpa").value.toString()),
                    );
                  })),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Addpost()));
          },
          child: const Icon(
            Icons.add,
          ),
        ));
  }
}
