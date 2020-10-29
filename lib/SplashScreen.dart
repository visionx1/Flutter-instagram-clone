import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramClone/Home.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  navigateUser() {
    // check if the user is logged in or not
    final currentUser = FirebaseAuth.instance.currentUser;
    // Just a simple way to check if the user is logged in or not --- just for demonstration
    if (currentUser != null) {
      print(currentUser.uid);
      Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, Home.routeName),
      );
    } else {
      Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (Route<dynamic> route) => false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Spinner(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: new Image.asset(
            'assets/images/logo.png',
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
