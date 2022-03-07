import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundry_lady/models/user_model.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  final _firestoreUser = FirebaseFirestore.instance.collection('users');

  Future<UserCredential> signupWithEmail(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithFacebook() async {
    if (kIsWeb) {
      // initialiaze the facebook javascript SDK
      FacebookAuth.i.webInitialize(
        appId: "277996544445388", //<-- YOUR APP_ID
        cookie: true,
        xfbml: true,
        version: "v12.0",
      );
    }
    var facebookAuth = FacebookAuth.instance;
    LoginResult? userData =
        await facebookAuth.login(loginBehavior: LoginBehavior.webOnly);
    if (userData == null) throw Exception('Facebook sign in failed');
    var userInfo = await facebookAuth.getUserData();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(userData.accessToken!.token);
    return _auth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    await GoogleSignIn().signOut();
    late var googleAccount;
    if (kIsWeb) {
      googleAccount = await GoogleSignIn(
              clientId:
                  '568550453977-61b5gdl6iajto28ffdtu6ks0pb2pr95o.apps.googleusercontent.com')
          .signIn();
    } else {
      googleAccount = await GoogleSignIn().signIn();
    }
    if (googleAccount == null) {
      throw FirebaseAuthException(
          message: 'Google sign in failed', code: 'google_sign_in_failed');
    }
    final GoogleSignInAuthentication? googleAuth =
        await googleAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<void> createUser(UserModel userModel) async {
    await _firestoreUser.doc(userModel.id).set(userModel.toJson());
  }

  Future<void> updateUser(String uid, UserModel userModel) async {
    await _firestoreUser.doc(uid).update(userModel.toJson());
  }

  Future<bool> isAvailableOnZip(String postalCode) async {
    var postalCodes = await FirebaseFirestore.instance
        .collection('postalcodes')
        .doc('uk5IeAwZB5WRR2uX30rt')
        .get();
    return (postalCodes.data()?['postalCode'] as List).contains(postalCode);
  }

  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isNewUser(String doc) async {
    var user = await _firestoreUser.doc(doc).get();
    return !user.exists;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
