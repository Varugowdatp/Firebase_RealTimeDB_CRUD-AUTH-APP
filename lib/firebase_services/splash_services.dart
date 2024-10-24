import 'package:firebase_asif/post/post_screen.dart';
import 'package:firebase_asif/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
