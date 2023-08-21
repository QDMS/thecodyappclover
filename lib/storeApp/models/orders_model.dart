// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String username;
  final String price;
  final String imageUrl;
  final String quantity;
  // final String phoneNumber;
  final Timestamp orderDate;
  OrderModel({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.username,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    // required this.phoneNumber,
    required this.orderDate,
  });
}
