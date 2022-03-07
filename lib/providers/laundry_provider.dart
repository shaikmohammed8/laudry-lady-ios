import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_lady/models/order_model.dart';
import 'package:laundry_lady/repositories/firesotre_user_repository.dart';
import 'package:laundry_lady/repositories/laundry_firestore.dart';

class LaundryProvider extends ChangeNotifier {
  var _dryClean = false;
  var _washAndFold = false;
  var _hangDry = false;
  final _isCvvFocused = false;
  int _tabIndex = 0;
  bool pickedASchedule = false;
  bool _isLoading = false;
  DateTime? date;
  int _totalPrice = 0;
  final List<String> _addedClothes = [];
  final List<bool> _opened = [false, false, false, false];

//textfield
  final TextEditingController instructionController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardDateController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  //getters

  bool get isCvvFocused => _isCvvFocused;
  bool get dryClean => _dryClean;
  int get tabIndex => _tabIndex;
  bool get washAndFold => _washAndFold;
  bool get hangDry => _hangDry;
  int get totalPrice => _totalPrice;
  bool get isLoading => _isLoading;
  UnmodifiableListView<bool> get opened => UnmodifiableListView(_opened);
  //
//preferences screen functions
//

//
//clothes screen functions
//
  changeTab(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  changePanel(int index) {
    _opened[index] = !_opened[index];
    notifyListeners();
  }

  closeAll() {
    _opened.fillRange(0, _opened.length, false);
    notifyListeners();
  }

  void addToList(String item, int price) {
    _addedClothes.add(item);
    _totalPrice += price;
    notifyListeners();
  }

  void removeFromList(String item, int price) {
    var isRemoved = _addedClothes.remove(item);
    isRemoved ? _totalPrice -= price : null;
    notifyListeners();
  }

  int getItemCountFromList(item) {
    if (_addedClothes.isEmpty) {
      return 0;
    } else {
      int count = _addedClothes
          .map((element) => element == item ? 1 : 0)
          .reduce((value, element) => value + element);
      return count;
    }
  }

  selectSevices(int index) {
    switch (index) {
      case 1:
        _dryClean = !_dryClean;
        break;
      case 2:
        _washAndFold = !_washAndFold;
        break;
      case 3:
        _hangDry = !_hangDry;
        break;
    }
    notifyListeners();
  }

//payment screen functions
  Future<void> addCard() async {
    _isLoading = true;
    await FirestoreUserRepository().assUsersCard(
        FirebaseAuth.instance.currentUser!.uid,
        cardHolderController.text,
        cardNumberController.text,
        cardDateController.text);
    _isLoading = false;
  }

//
//make order
//
  Future<void> makeOrder(
      {required String city,
      required String postalCode,
      required String name,
      required String phone,
      required String address,
      required String starch,
      required String fabricSoftener,
      String? apartment,
      required String detergent}) async {
    loadingValue(true);
    var order = OrderModel(
        services: {
          'hangDry': hangDry,
          'dryClean': dryClean,
          'washAndFold': washAndFold
        },
        price: totalPrice,
        detergent: detergent,
        fabricSoftener: fabricSoftener,
        starch: starch,
        name: name,
        phone: phone,
        address: address,
        city: city,
        postalCode: postalCode,
        items: _addedClothes,
        apartment: apartment,
        instructions: instructionController.text,
        status: "ordered",
        date: date.toString());

    await LaundryFirestore().makeOrder(order);
  }

  loadingValue(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  clearAll() {
    _addedClothes.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  void onClose() {
    _dryClean = false;
    _washAndFold = false;
    _hangDry = false;
  }
}
