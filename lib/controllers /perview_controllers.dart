import 'package:flutter/material.dart';

class PerViewScreenController extends ChangeNotifier {
  int? _indexPerViewPage;
  int? get indexPerViewPage => _indexPerViewPage;
  void changeIndex(int index) {
    _indexPerViewPage = index;
    notifyListeners();
  }
}
