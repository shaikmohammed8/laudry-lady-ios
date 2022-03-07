import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundry_lady/models/user_model.dart';

class FirestoreUserRepository {
  var firestoreUser = FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUser(String userId) async {
    var user = await firestoreUser.doc(userId).get();
    return UserModel.fromJson(user.data()!);
  }

  Future<void> updateUser(String userId, UserModel userModel) async {
    await firestoreUser.doc(userId).update(userModel.toJson());
  }

  Future<void> assUsersCard(
      String userId, String name, String cardNumber, String date) async {
    await FirebaseFirestore.instance
        .collection('cards')
        .doc(userId)
        .set({"name": name, "cardNumber": cardNumber, "date": date});
  }
}
