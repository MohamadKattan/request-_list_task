import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:request_list_task/model/orders_model.dart';
import 'package:request_list_task/utils/constants.dart';

import '../components /tost_msg.dart';
import '../views/all_orders.dart';
import 'local_db.dart';

class OrdersController extends ChangeNotifier {
  bool _louding = false;
  bool get louding => _louding;

  int _newInvoice = 0;
  int get newInvoice => _newInvoice;

  final List<OrdersModel> _listPickOrder = [];
  List<OrdersModel> get listPickOrder => _listPickOrder;

  void isLouding(bool loud) {
    _louding = loud;
    notifyListeners();
  }

  void clearList() {
    _listPickOrder.clear();
    _newInvoice = 0;
  }

  void updateListPickOrder(OrdersModel object) {
    bool isFound = false;
    if (_listPickOrder.isEmpty) {
      _newInvoice += object.priceOne;
      _listPickOrder.add(object);
    } else {
      for (var i = 0; i < _listPickOrder.length; i++) {
        if (object.nameOrder == _listPickOrder[i].nameOrder) {
          isFound = true;
          _listPickOrder[i].numCount += 1;
          _listPickOrder[i].totelPrice += _listPickOrder[i].priceOne;
          _listPickOrder[i].totalInvoice += _listPickOrder[i].priceOne;
          _newInvoice += _listPickOrder[i].priceOne;
        }
      }
      if (isFound == true) {
      } else {
        _listPickOrder.add(object);
        _newInvoice += object.priceOne;
      }
    }
    notifyListeners();
  }

  void incrementOrder(int index) {
    _listPickOrder[index].numCount += 1;
    _listPickOrder[index].totelPrice += _listPickOrder[index].priceOne;
    _listPickOrder[index].totalInvoice += _listPickOrder[index].priceOne;
    _newInvoice += _listPickOrder[index].priceOne;
    notifyListeners();
  }

  void discernmentOrder(int index) {
    if (_listPickOrder[index].numCount <= 1) {
      _newInvoice -= _listPickOrder[index].priceOne;
      _listPickOrder.removeAt(index);
    } else {
      _listPickOrder[index].numCount -= 1;
      _listPickOrder[index].totelPrice -= _listPickOrder[index].priceOne;
      _listPickOrder[index].totalInvoice -= _listPickOrder[index].priceOne;
      _newInvoice -= _listPickOrder[index].priceOne;
    }

    notifyListeners();
  }

  Future<void> setNewOrderToLocale(BuildContext context) async {
    String convertToString = '';
    List newList = [];
    int count = 0;
    for (var i in listPickOrder) {
      var newObj = i.toMap();
      newList.add(newObj);
      count += 1;
      if (count == listPickOrder.length) {
        convertToString = jsonEncode(newList);
        await LocalDataBase().setDataToDataBase(
            dbName: kkorderDbName,
            tabelName: kkorderTabelName,
            map: {kNewOrder: convertToString},
            isOrder: true);
        if (count == _listPickOrder.length) {
          TostMsg().displayTostMsg(msg: orderSaved);
          if (!context.mounted) return;
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AllOrders()));
        }
      }
    }
  }

  Future getOrdersFromLocal() async {
    listOrders.clear();
    List<Map<String, dynamic>> newData = await LocalDataBase().readData(
        dbName: kkorderDbName, tabelName: kkorderTabelName, isOrder: true);
    for (var i in newData) {
      var oneOrder = CustomerListOrder.fromMap(i);
      listOrders.add(oneOrder);
    }
    notifyListeners();
  }
}
