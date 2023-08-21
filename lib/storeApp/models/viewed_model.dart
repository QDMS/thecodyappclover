import 'package:flutter/material.dart';

class ViewedProductModel with ChangeNotifier {
  final String id;
  final String productId;
  ViewedProductModel({
    required this.id,
    required this.productId,
  });
}
