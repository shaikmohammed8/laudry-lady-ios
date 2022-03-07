import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/repositories/firesotre_user_repository.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _disable = true;
  bool get isLoading => _isLoading;
  bool get isDisabled => _disable;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  void assignToController(UserModel user) {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email ?? '';
    phoneNumberController.text = user.phoneNumber ?? '';
    addressController.text = user.address ?? '';
    apartmentController.text = user.apartment ?? '';
    postalCodeController.text = user.postalCode ?? '';
    cityController.text = user.city ?? '';
  }

  Future<void> save() async {
    await FirestoreUserRepository().updateUser(
        FirebaseAuth.instance.currentUser!.uid,
        UserModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            address: addressController.text,
            apartment: apartmentController.text,
            postalCode: postalCodeController.text,
            city: cityController.text));
  }

  void changeLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void hasAnyChanges(UserModel user) {
    if (user.firstName == firstNameController.text &&
        user.lastName == lastNameController.text &&
        user.email == emailController.text &&
        user.phoneNumber == phoneNumberController.text &&
        user.address == addressController.text &&
        user.apartment == apartmentController.text &&
        user.postalCode == postalCodeController.text &&
        user.city == cityController.text) {
      _disable = true;
    } else {
      _disable = false;
    }
    notifyListeners();
  }
}
