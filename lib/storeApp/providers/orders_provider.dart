import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final User? user = authInstance.currentUser;
    var uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('orderDate', descending: false)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      //_productsList.clear();
      ordersSnapshot.docs.forEach((element) {
        print(element.get('price'));
        OrderModel order = OrderModel(
            // phoneNumber: element.get(field),
            orderId: element.get('orderId'),
            productId: element.get('productId'),
            userId: element.get('userId'),
            username: element.get('username'),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            price: element.get('price').toString(),
            orderDate: Timestamp.now());
        _orders.add(order);
      });
    });
    // print(_orders.length);
    notifyListeners();
  }
}
