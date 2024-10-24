import 'package:firebase_asif/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AddPostscreen extends StatefulWidget {
  const AddPostscreen({super.key});

  @override
  State<AddPostscreen> createState() => _AddPostscreenState();
}

class _AddPostscreenState extends State<AddPostscreen> {
  final postController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                hintText: 'Whats in ur mind',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: 'add',
                ontap: () {
                  setState(() {
                    loading:
                    true;
                  });
                  databaseRef.child('1').set({'Id': 1}).then((value) {
                    setState(() {
                      Utils().toastMessage('Post added');
                      loading:
                      false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading:
                      false;
                    });
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'Name': postController.text.toString(),
                    'age': id,
                  }).then((value) {
                    setState(() {
                      Utils().toastMessage('Post added');
                      loading:
                      false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading:
                      false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
