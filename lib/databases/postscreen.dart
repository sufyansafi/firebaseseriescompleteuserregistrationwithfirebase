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
  Future<void> showMyDialouge(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text("Update"),
          content: SizedBox(
            child: TextFormField(
              controller: editcontroller,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  refrence.child(id).update({
                    'title': editcontroller.text.toLowerCase()
                  }).then((value) {
                    Util().toastMessage("post updates");
                  }).onError((error, stackTrace) {
                    Util().toastMessage(error.toString());
                  });
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }

  final searchcontroller = TextEditingController();
  final editcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final refrence =
      FirebaseDatabase.instance.ref('post data in firebase relatime database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: "Search you Want",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              // Expanded(
              //     child: StreamBuilder(
              //   builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
              //     Map<dynamic, dynamic> map =
              //         snapshot.data!.snapshot.value as dynamic;
              //     List<dynamic> list = [];
              //     list.clear();
              //     list = map.values.toList();
              //     if (snapshot.hasData) {
              //       return const CircularProgressIndicator();
              //     } else {
              //       return ListView.builder(
              //         itemBuilder: (context, index) {
              //           return ListTile(
              //             title: Text(list[index]["title"]),
              //             subtitle: Text(list[index]["description"]),
              //           );
              //         },
              //         itemCount: snapshot.data!.snapshot.children.length,
              //       );
              //     }
              //   }),
              //   stream: refrence.onValue,
              // )),
              Expanded(
                child: FirebaseAnimatedList(
                    query: refrence,
                    itemBuilder: ((context, snapshot, animation, index) {
                      final title = snapshot.child("title").value.toString();

                      if (searchcontroller.text.isEmpty) {
                        return ListTile(
                            title:
                                Text(snapshot.child("title").value.toString()),
                            subtitle:
                                Text(snapshot.child("id").value.toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        showMyDialouge(
                                            title,
                                            snapshot
                                                .child('id')
                                                .value
                                                .toString());
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Edit"),
                                    )),
                                PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        refrence
                                            .child(snapshot
                                                .child("id")
                                                .value
                                                .toString())
                                            .remove();
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    )),
                              ],
                            ));
                      } else if (title.toLowerCase().contains(
                          searchcontroller.text.toLowerCase().toLowerCase())) {
                        return ListTile(
                          title: Text(snapshot.child("title").value.toString()),
                          subtitle: Text(snapshot.child("id").value.toString()),
                        );
                      } else {
                        return Container();
                      }

                      // return ListTile(
                      //   title: Text(snapshot.child("title").value.toString()),
                      //   subtitle: Text(
                      //       snapshot.child("description").value.toString()),
                      //   trailing: Text(snapshot.child("Cgpa").value.toString()),
                      // );
                    })),
              ),
            ],
          ),
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
