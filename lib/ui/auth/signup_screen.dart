import 'package:firebase_asif/ui/auth/login_screen.dart';
import 'package:firebase_asif/ui/auth/signup_screen.dart';
import 'package:firebase_asif/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formField = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Sign up",
          style: TextStyle(letterSpacing: 5, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formField,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.password),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Signup',
              loading: loading,
              ontap: () {
                if (_formField.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _auth
                      .createUserWithEmailAndPassword(
                          email: emailcontroller.text.toString(),
                          password: passwordcontroller.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }
              },
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                Text("already have an account ?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "login",
                      style: TextStyle(color: Colors.deepPurple),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
