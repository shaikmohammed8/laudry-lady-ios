import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/screens/homescreen/homes_screen.dart';
import 'package:laundry_lady/screens/landing_screen.dart';

class Decider extends StatelessWidget {
  const Decider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const LandingScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
