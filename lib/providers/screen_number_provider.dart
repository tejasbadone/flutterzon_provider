import 'package:flutter/material.dart';

class ScreenNumberProvider extends ChangeNotifier {
  int _screenNumber = 0;
  static bool _isOpen = false;

  int get screenNumber => _screenNumber;

  bool get isOpen => _isOpen;

  void setScreenNumber(int number) {
    _screenNumber = number;
    notifyListeners();
  }

  void setIsOpen(bool isOpen) {
    _isOpen = isOpen;
    notifyListeners();
  }
}
