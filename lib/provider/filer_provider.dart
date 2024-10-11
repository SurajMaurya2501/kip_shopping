import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  void updateWidget() {
    notifyListeners();
  }
}
