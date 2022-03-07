import 'package:flutter/material.dart';

class Themes {
  static const mainColor = Color(0XFF01c162);
  static const lightColor = Color(0XFFc9c9c9);
  static const secondaryColor = Colors.blue;

  static var bodyText = const TextStyle(
    fontSize: 18,
    color: Colors.black,
  );
  static var blueText = const TextStyle(
    fontSize: 18,
    color: Colors.blue,
  );
  static var appBarTitle = TextStyle(
    fontSize: 20,
    color: Colors.blueGrey.shade800,
    fontWeight: FontWeight.w700,
  );
  static var overlayText = const TextStyle(
    fontSize: 16,
    color: lightColor,
  );

  static var headline = TextStyle(
    fontSize: 26,
    color: Colors.blueGrey.shade800,
    fontWeight: FontWeight.w700,
  );

  static var theme = ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.blue),
      primarySwatch: Colors.green,
      primaryColor: mainColor,
      inputDecorationTheme: InputDecorationTheme(
        // prefixIconColor: Colors.grey[350],
        floatingLabelStyle: overlayText.copyWith(color: mainColor),
        labelStyle: overlayText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: lightColor, width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      appBarTheme: AppBarTheme(
          foregroundColor: Colors.blueGrey.shade800,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: appBarTitle),
      scaffoldBackgroundColor: Colors.white);
}
