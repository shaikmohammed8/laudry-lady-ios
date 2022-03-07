import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/repositories/auth_repositories.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository authRepo = AuthRepository();

  bool _isLoading = false;

  String? userId;
  AuthType? authType;

  //text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  //getters
  int _stepperScreenIndex = 0;
  int get stepperScreenIndex => _stepperScreenIndex;

  bool get isLoading => _isLoading;

  //funtions
  //

  onScreenChange(int index) {
    _stepperScreenIndex = index;
    notifyListeners();
  }

//
//google authentication
//
  Future<bool> signupWithGoogle(bool forLogIn) async {
    loadingValue(true);
    if (!forLogIn) {
      var isAvailable =
          await authRepo.isAvailableOnZip(postalCodeController.text);
      if (!isAvailable) {
        throw FirebaseAuthException(
            message: "We don't serve at this zip but we will in future",
            code: 'zip_code_not_available');
      }
    }

    var user = await authRepo.signInWithGoogle();

    emailController.text = user.user!.email!;
    firstNameController.text = user.user!.displayName!.split(" ")[0];
    lastNameController.text = user.user!.displayName!.split(" ")[1];
    if (user.additionalUserInfo!.isNewUser) {
      await authRepo.createUser(getUser(user.user!.uid));
      userId = user.user!.uid;

      return true;
    }
    return false;
  }

//
//email authentication
//
  Future<void> signupWithEmail(bool forDataOnly) async {
    loadingValue(true);
    var isAvailable =
        await authRepo.isAvailableOnZip(postalCodeController.text);
    if (!isAvailable) {
      throw FirebaseAuthException(
          message: "We don't serve at this zip but we will in future",
          code: 'zip_code_not_available');
    }
    if (forDataOnly) {
      return;
    } else {
      var user = await authRepo.signupWithEmail(
          emailController.text, passwordController.text);
      await authRepo.createUser(getUser(user.user!.uid));
    }
    loadingValue(false);
  }

//
//facebook authentication
//
  Future<bool> signupWithFacebook(bool forLogIn) async {
    loadingValue(true);

    if (!forLogIn) {
      var isAvailable =
          await authRepo.isAvailableOnZip(postalCodeController.text);
      if (!isAvailable) {
        throw FirebaseAuthException(
            message: "We don't serve at this zip but we will in future",
            code: 'zip_code_not_available');
      }
    }
    var user = await authRepo.signInWithFacebook();
    emailController.text = user.user!.email!;
    firstNameController.text = user.user!.displayName!.split(" ")[0];
    lastNameController.text = user.user!.displayName!.split(" ")[1];
    if (user.additionalUserInfo!.isNewUser) {
      await authRepo.createUser(getUser(user.user!.uid));
      userId = user.user!.uid;
      return user.additionalUserInfo!.isNewUser;
    }
    return false;
  }

  UserModel getUser(id) {
    return UserModel(
        postalCode: postalCodeController.text,
        city: cityController.text,
        lastName: lastNameController.text,
        firstName: firstNameController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        email: emailController.text,
        id: id,
        apartment: apartmentController.text);
  }

  loadingValue(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void close() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    addressController.clear();
    apartmentController.clear();
    postalCodeController.clear();
    cityController.clear();

    _isLoading = false;
    userId = null;
    _stepperScreenIndex = 0;
    authType = null;
    notifyListeners();
  }

  singInWithEmail() async {
    loadingValue(true);
    await authRepo.signInWithEmail(
        emailController.text, passwordController.text);
    loadingValue(false);
  }

  updateUser() async {
    loadingValue(true);
    var isAvailable =
        await authRepo.isAvailableOnZip(postalCodeController.text);
    if (!isAvailable) {
      throw FirebaseAuthException(
          message: "We don't serve at this zip but we will in future",
          code: 'zip_code_not_available');
    }
    await authRepo.updateUser(
        userId!,
        UserModel(
            postalCode: postalCodeController.text,
            city: cityController.text,
            lastName: lastNameController.text,
            firstName: firstNameController.text,
            phoneNumber: phoneNumberController.text,
            address: addressController.text,
            apartment: apartmentController.text));
  }

  resetPassword() async {
    loadingValue(true);
    await authRepo.resetPassword(emailController.text);
  }
}

enum AuthType {
  GOOGLE,
  EMAIL,
  FACEBOOK,
}
