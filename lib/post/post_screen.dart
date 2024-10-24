import 'package:firebase_asif/post/add_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';
import '../utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final addedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((event) {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Post"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    });
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onTapOutside: (tap) {
                FocusScope.of(context).unfocus();
              },
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text("Loading"),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('Name').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('Name').value.toString()),
                      subtitle: Text(snapshot.child('age').value.toString()),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title,
                                      snapshot.child('age').value.toString());
                                },
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(Icons.delete_rounded),
                                title: Text("delete"),
                                onTap: () {
                                  Navigator.pop(context);
                                  ref
                                      .child((snapshot
                                          .child('age')
                                          .value
                                          .toString()))
                                      .remove();
                                },
                              )),
                        ],
                        icon: Icon(Icons.more_vert),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchFilter.text.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(snapshot.child('Name').value.toString()),
                      subtitle: Text(snapshot.child('age').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostscreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    addedController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
                child: TextField(
              controller: addedController,
              decoration: InputDecoration(
                hintText: 'Edit',
              ),
            )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.child(id).update({
                    'Name': addedController.text.toString(),
                  }).then((value) {
                    Utils().toastMessage('Value updated');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }
}

// fetching of data using stream builder

// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
// if (!snapshot.hasData) {
// return CircularProgressIndicator();
// } else {
// Map<dynamic, dynamic> map =
// snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list = [];
// list.clear();
// list = map.values.toList();
// return ListView.builder(itemBuilder: (context, index) {
// return ListTile(
// title: Text('$index'),
// );
// });
// }
// })),
