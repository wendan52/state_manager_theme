import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  int _themeColor = 0xFF3391EA;
  get themeColor => _themeColor;

  void changeTheme (int color) {
    this._themeColor = color;
    // 通知监听器
    notifyListeners();
  }
}