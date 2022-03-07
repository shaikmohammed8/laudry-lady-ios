import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundry_lady/models/item_model.dart';
import 'package:laundry_lady/models/order_model.dart';

class LaundryFirestore {
  var firestore = FirebaseFirestore.instance;

  Future<List<ItemModel>> getItems() async {
    var items = await firestore.collection('items').get();
    var itemList =
        items.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
    return itemList;
  }

  Future<void> makeOrder(OrderModel order) {
    return firestore
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('usersOrder')
        .add(order.toJson());
  }

  Future<List<OrderModel>> getOrders() {
    return firestore
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('usersOrder')
        .get()
        .then((value) {
      return value.docs.map((doc) {
        return OrderModel.fromJson(doc.data());
      }).toList();
    });
  }
}
