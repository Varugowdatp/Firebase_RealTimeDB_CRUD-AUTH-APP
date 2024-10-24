import 'package:firebase_asif/ui/auth/loginwithphnumber.dart';
import 'package:firebase_asif/ui/auth/signup_screen.dart';
import 'package:firebase_asif/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../post/post_screen.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _islogin = false;
  final _formField = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    setState(() {
      _islogin = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      setState(() {
        _islogin = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        _islogin = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: 4),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
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
                title: 'login',
                loading: _islogin,
                ontap: () {
                  if (_formField.currentState!.validate()) {
                    login();
                  }
                },
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("don't have an account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context)=>Loginwithphnumber()));
                  },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black54,
                      )),
                  child: Center(
                    child: Text("Login with Phone Number"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
