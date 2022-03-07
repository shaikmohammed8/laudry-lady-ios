import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

String handelFirebaseAuthError(Exception e) {
  if (e is FirebaseAuthException) {
    if (e.code == "wrong-password") return "wrong password";
    if (e.code == "user-not-found") {
      return "user not found with this email address";
    }
    return e.message!;
  } else {
    return "something went wrong";
  }
}

//widley use widgets
//
//loading widget
var loading = LottieBuilder.asset("assets/images/lf30_editor_woxbbkbs.json");
//
//loading with with stack
//
var stackLoading = Container(
  height: double.infinity,
  width: double.infinity,
  alignment: Alignment.center,
  color: Colors.white54,
  child: LottieBuilder.asset("assets/images/lf30_editor_woxbbkbs.json"),
);

var dialogConfig = const FadeScaleTransitionConfiguration(
  transitionDuration: Duration(milliseconds: 300),
  reverseTransitionDuration: Duration(milliseconds: 300),
);
//
//page transition between widget
//

List postalCodes = ['341021', '400009'];

//const
String hypoallergenic = 'Hypoallergenic';
String regular = 'Regular';

class RegexPattern {
  static String username = r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$';
  static String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String url =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-@]+))*$";
  static String phone =
      r'^(0|\+|(\+[0-9]{2,4}|\(\+?[0-9]{2,4}\)) ?)([0-9]*|\d{2,4}-\d{2,4}(-\d{2,4})?)$';

  static String currency =
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$';
  static String numericOnly = r'^\d+$';
  static String alphabetOnly = r'^[a-zA-Z]+$';

  static String password =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%\^&\*])(?=.{8,})";

  static String postalCode = r"^\d{5,6}([-]|\s*)?(\d{4})?$";
}
