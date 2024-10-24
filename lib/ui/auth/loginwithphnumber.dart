import 'package:firebase_asif/ui/auth/verifycode.dart';
import 'package:firebase_asif/utils/utils.dart';
import 'package:firebase_asif/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginwithphnumber extends StatefulWidget {
  const Loginwithphnumber({super.key});

  @override
  State<Loginwithphnumber> createState() => _LoginwithphnumberState();
}

class _LoginwithphnumberState extends State<Loginwithphnumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;

  final _phonenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _phonenumberController,
              decoration: InputDecoration(
                hintText: '+1 23 456 7890',
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'login',
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: _phonenumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCode(
                                      verificationId: verificationId,
                                    )));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
