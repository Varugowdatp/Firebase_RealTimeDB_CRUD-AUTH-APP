import 'package:firebase_asif/firebase_services/splash_services.dart';
import 'package:firebase_asif/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          " FireBase ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }
}
