import 'package:flutter/material.dart';

import '../model/restaurant_tabels.dart';
import '../utils/constants.dart';

class TabelsController extends ChangeNotifier {
  TabelsController() {
    addNewTabel();
  }

  bool _louding = false;
  bool get louding => _louding;

  final List<RestaurantTabels> _listRestaurantTabels = [];
  List<RestaurantTabels> get listRestaurantTabels => _listRestaurantTabels;

  void _isLouding(bool state) {
    _louding = state;
    notifyListeners();
  }

  void addNewTabel() {
    _isLouding(true);
    if (_listRestaurantTabels.length < tabeslNumber) {
      for (var i = 0; i < tabeslNumber; i++) {
        var newTabel = RestaurantTabels(
            tabelNumber: i+1, isOrdered: false, tabelColor: Colors.white);
        _listRestaurantTabels.add(newTabel);
      }
    }
    _isLouding(false);
  }
}
