import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:request_list_task/components%20/ctm_appbar.dart';
import 'package:request_list_task/components%20/ctm_drawer.dart';
import 'package:request_list_task/components%20/ctm_progress.dart';
import 'package:request_list_task/components%20/ctm_txt.dart';
import 'package:request_list_task/utils/constants.dart';

import '../controllers /local_db.dart';
import '../model/orders_model.dart';
import 'home_screen.dart';

class DetailsOrder extends StatelessWidget {
  final CustomerListOrder customerListOrder;
  final num totelArg;
  const DetailsOrder(
      {super.key, required this.customerListOrder, required this.totelArg});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                _delete(context);
              },
              child: const Icon(Icons.delete),
            ),
            drawer: const CustomDrawer(),
            appBar: CustomAppBar(txtTitle: detailsOrdertxt, context: context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(mainSpacer),
                  CustomTxt(
                    '$totelOfInvoice$totelArg',
                    color: mainColor,
                    fSzie: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      child: _listDetailsOrder(customerListOrder))
                ],
              ),
            ));
      }),
    );
  }

  _listDetailsOrder(CustomerListOrder customerListOrder) {
    List convertObj = json.decode(customerListOrder.neworder ?? 'null');
    return convertObj.isNotEmpty
        ? ListView.builder(
            itemCount: convertObj.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    trailing: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(mainRadius)),
                      child: Image.asset(
                        '${convertObj[index][img]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: CustomTxt(
                      '${convertObj[index][name]} ',
                      color: mainColor,
                      txtAlign: TextAlign.start,
                      fSzie: 20,
                    ),
                    subtitle: CustomTxt(
                      '${convertObj[index][count]} * ${convertObj[index][price]} = ${convertObj[index][totel]}',
                      color: secondryColor,
                      txtAlign: TextAlign.start,
                    ),
                  ),
                ),
              );
            })
        : const CustomProgressIndicator();
  }

  // del one order
  Future<void> _delete(BuildContext context) async {
    await LocalDataBase().deleteOneItem(
      dbName: kkorderDbName,
      tabelName: kkorderTabelName,
      idItem: customerListOrder.idCoustmer ?? 1,
    );
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false);
  }
}
