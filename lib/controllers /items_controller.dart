import 'package:flutter/material.dart';
import 'package:request_list_task/model/item_model.dart';
import 'package:request_list_task/utils/dumy_data.dart';

import '../utils/constants.dart';
import 'local_db.dart';

class ItemsController extends ChangeNotifier {
  bool _louding = false;
  bool get louding => _louding;

  void _isLouding(bool loud) {
    _louding = loud;
    notifyListeners();
  }

  Future<void> setItemsDumyDataToLocale() async {
    await LocalDataBase().deleteAll(dbName: itemDbName);
    for (var i in dumyData) {
      await LocalDataBase().setDataToDataBase(
          dbName: itemDbName, tabelName: itemTabelName, map: i.toMap());
    }
  }

  Future<void> getItemsFromLocal() async {
    _isLouding(true);
    List<Map<String, dynamic>> newData = await LocalDataBase()
        .readData(dbName: itemDbName, tabelName: itemTabelName);
    if (newData.isNotEmpty) {
      for (var i in newData) {
        var oneItem = ItemModel.fromMap(i);
        if (oneItem.typeItem!.contains(mainDish)) {
          itemsMainDish.add(oneItem);
        } else if (oneItem.typeItem!.contains(soup)) {
          itemsSoup.add(oneItem);
        } else {
          itemsDrink.add(oneItem);
        }
      }
      _isLouding(false);
    }
  }
}
