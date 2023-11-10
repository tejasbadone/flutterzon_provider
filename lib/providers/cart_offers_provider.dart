import 'package:flutter/material.dart';

class CartOfferProvider extends ChangeNotifier {
  String _category1 = '';

  String get category1 => _category1;

  void setCategory1(String category) {
    _category1 = category;
    notifyListeners();
  }
}
