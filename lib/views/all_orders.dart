import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_list_task/views/details_order.dart';
import 'package:request_list_task/views/home_screen.dart';

import '../components /ctm_appbar.dart';
import '../components /ctm_drawer.dart';
import '../components /ctm_txt.dart';
import '../controllers /local_db.dart';
import '../controllers /orders_controller.dart';
import '../utils/constants.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  void initState() {
    Provider.of<OrdersController>(context, listen: false).getOrdersFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pickerOrder = context.watch<OrdersController>();
    pickerOrder.clearList();

    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await LocalDataBase().deleteAll(dbName: kkorderDbName);
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false);
              },
              child: const Icon(Icons.delete),
            ),
            drawer: const CustomDrawer(),
            appBar: CustomAppBar(txtTitle: appBarALL, context: context),
            body: _displayListOrders());
      }),
    );
  }

  _displayListOrders() {
    return listOrders.isNotEmpty
        ? ListView.builder(
            itemCount: listOrders.length,
            itemBuilder: (_, index) {
              var newObj = listOrders[index];
              var convertObj = json.decode(newObj.neworder ?? 'null');
              num totel = 0;
              for (var i in convertObj) {
                totel += i['invoice'];
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailsOrder(
                                    customerListOrder: newObj,
                                    totelArg: totel,
                                  )));
                    },
                    title: CustomTxt(
                      '$tabelNo ${convertObj[0][type]} ',
                      color: mainColor,
                      txtAlign: TextAlign.start,
                      fSzie: 20,
                    ),
                    subtitle: CustomTxt(
                      '$totelOfInvoice $totel ',
                      color: secondryColor,
                      txtAlign: TextAlign.start,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            },
          )
        : Center(
            child: CustomTxt(
              noOrederSave,
              color: mainColor,
              fSzie: 20,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
