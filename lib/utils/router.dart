import 'package:flutter/material.dart';
import 'package:laundry_lady/providers/preference.dart';
import 'package:laundry_lady/screens/createorderscreen/add_detail_screen.dart';
import 'package:laundry_lady/screens/createorderscreen/select_items.dart';
import 'package:laundry_lady/screens/decider.dart';
import 'package:laundry_lady/screens/homescreen/homes_screen.dart';
import 'package:laundry_lady/screens/loginscreen/loginscreen.dart';
import 'package:laundry_lady/screens/signup/signup.dart';
import 'package:laundry_lady/screens/signup/steper_screen.dart.dart';
import 'package:provider/provider.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const Decider(),
  '/login': (_) => LoginScreen(),
  '/signup': (_) => SignupScreen(),
  '/stepper': (_) => const StepperScreen(),
  '/home': (_) => const HomeScreen(),
  '/clothe': (_) => const SelectItemsScreen(),
  '/detail': (_) => ChangeNotifierProvider(
      create: (_) => PreferenceProvider(), child: const AddDetailScreen()),
};
