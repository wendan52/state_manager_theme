import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {
  int _count = 0;
  get count => _count;

  void add() {
    _count++;
    notifyListeners();
  }

  void dec() {
    _count--;
    notifyListeners();
  }
}