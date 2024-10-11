import 'package:flutter/material.dart';

class FilterResultProvider extends ChangeNotifier {
  void updateWidget() {
    notifyListeners();
  }
}
