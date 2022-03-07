import 'package:flutter/cupertino.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/utils/utils.dart';

class PreferenceProvider extends ChangeNotifier {
  var _detergent = hypoallergenic;
  var _fabric = hypoallergenic;
  String _starch = 'None';
  bool _isExpress = false;
  String get detergent => _detergent;
  String get fabric => _fabric;
  String get starch => _starch;
  bool get isExpress => _isExpress;
  var addressController = TextEditingController();

  var nameController = TextEditingController();

  var phonNumberController = TextEditingController();

  var cityController = TextEditingController();

  var postalCodeController = TextEditingController();

  var apartmentController = TextEditingController();

  void changeDetergentVal(val) {
    _detergent = val;
    notifyListeners();
  }

  void express(bool val) {
    _isExpress = val;
    notifyListeners();
  }

  void changeFabricVal(val) {
    _fabric = val;
    notifyListeners();
  }

  void changeStarchVal(val) {
    _starch = val;
    notifyListeners();
  }

  void addToText(UserModel user) {
    nameController.text = user.firstName!;
    phonNumberController.text = user.phoneNumber!;
    cityController.text = user.city!;
    postalCodeController.text = user.postalCode!;
    apartmentController.text = user.apartment!;
    addressController.text = user.address!;
  }
}
