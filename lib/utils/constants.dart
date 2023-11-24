import 'package:flutter/material.dart';

import '../model/item_model.dart';
import '../model/orders_model.dart';

Color mainColor = Colors.black;
Color secondryColor = Colors.grey.shade700;
Color btnColor = Colors.amberAccent;
double mainSpacer = 20.0;
int tabeslNumber = 4; // as dynamic Number Table from dataBase
double mainPadding = 12.0;
double mainMargin = 12.0;
double mainRadius = 8.0;
List<ItemModel> itemsMainDish = [];
List<ItemModel> itemsSoup = [];
List<ItemModel> itemsDrink = [];
List<CustomerListOrder> listOrders = [];

// keys Of local dataBase
const String itemDbName = 'item.db';
const String itemTabelName = 'item';
const String kkorderDbName = 'kkorder.db';
const String kkorderTabelName = 'kkorder';
const String id = 'id';
const String type = 'type';
const String name = 'name';
const String price = 'price';
const String img = 'img';
const String count = 'count';
const String totel = 'totel';
const String invoice = 'invoice';
const String kNewOrder = 'neworder';

// txt in Home Screen
const String appBarHome = 'Restaurant Hall';
const String mainDecHome =
    'Below List of tabel \n click on an tabel to pick order';
const String titleDividerHome = 'List of Tabel';
const String txtNumOfTabel = 'Table No : ';
const String txtTabelhasOrder = 'had order';
const String txtTabelnohasOrder = ' No order yet';

// txt in order Screen
const String appBarOrder = 'Order Screen';
const String titelMenu = 'Menu';
const String mainDish = 'Main Dish';
const String soup = 'Soup';
const String drinks = 'Drinks';
const String noOrder = 'No order yet ...';
const String saveOrder = 'SAVE ORDER';
const String totaltxt = 'Totel : ';

// txt All order SCreen
const String appBarALL = 'All orders';
const String noOrederSave = 'No Oreder Saved yet ...';
const String tabelNo = 'Table No : ';
const String totelOfInvoice = 'Total Invoice : ';
const String detailsOrdertxt = 'Details Order';

// tost msg
const orderSaved = 'Order has saved';
