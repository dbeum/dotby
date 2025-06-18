
import 'package:dotby1/home/home.dart';
import 'package:dotby1/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in
          return Home(); // Replace with your home page
        } else {
          // User is not logged in
          return Login(); // Replace with your registration/login page
        }
      },
    );
  }
}