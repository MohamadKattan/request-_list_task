import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:request_list_task/components%20/ctm_drawer.dart';
import 'package:request_list_task/components%20/ctm_litems.dart';
import 'package:request_list_task/components%20/ctm_txt.dart';

import '../components /ctm_appbar.dart';
import '../components /ctm_btn.dart';
import '../components /ctm_divider.dart';
import '../components /ctm_iconbtn.dart';
import '../controllers /orders_controller.dart';
import '../controllers /perview_controllers.dart';
import '../utils/constants.dart';

class OrderScreen extends StatefulWidget {
  final int? resturnTabelNumber;
  const OrderScreen({super.key, this.resturnTabelNumber});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late PageController controllerView;

  @override
  void initState() {
    controllerView = PageController(
        initialPage:
            context.read<PerViewScreenController>().indexPerViewPage ?? 0);

    super.initState();
  }

  @override
  void dispose() {
    controllerView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var perViewController = context.read<PerViewScreenController>();
    final pickerOrder = context.watch<OrdersController>();
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: CustomAppBar(
            txtTitle: appBarOrder,
            context: context,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // picked Order List or No order txt
                SizedBox(
                    height: pickerOrder.listPickOrder.isNotEmpty
                        ? mediaQuery.size.height / 2 - 100
                        : 200,
                    child: _orderListOrNoOrder(pickerOrder)),
                // div or saveBtn
                _displyDivider(pickerOrder),
                // btn switcher between Menu pages
                Row(
                  children: [
                    CustomBtn(
                        txt: mainDish,
                        voidCallback: () => _changeIndex(0, perViewController)),
                    CustomBtn(
                        txt: soup,
                        voidCallback: () => _changeIndex(1, perViewController)),
                    CustomBtn(
                        txt: drinks,
                        voidCallback: () => _changeIndex(2, perViewController)),
                  ],
                ),
                const Gap(8.0),
                // pages of Menu items mainDish,Soup,Drinks
                SizedBox(
                  height: mediaQuery.size.height / 2 - 100,
                  child: PageView(
                    controller: controllerView,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomListItem(
                          list: itemsMainDish,
                          resturnTabelNumber: widget.resturnTabelNumber ?? 1),
                      CustomListItem(
                          list: itemsSoup,
                          resturnTabelNumber: widget.resturnTabelNumber ?? 1),
                      CustomListItem(
                          list: itemsDrink,
                          resturnTabelNumber: widget.resturnTabelNumber ?? 1)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // this method for change index of perViewPage & animate
  void _changeIndex(int index, PerViewScreenController perViewController) {
    perViewController.changeIndex(index);
    controllerView.animateToPage(perViewController.indexPerViewPage ?? 0,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

// divider or saveBtn order to db no order ? divider : SizeBox
  _displyDivider(OrdersController pickerOrder) {
    if (pickerOrder.listPickOrder.isNotEmpty) {
      return const SizedBox();
    } else {
      return CustomDivider(
        cWidth: MediaQuery.of(context).size.width,
        title: titelMenu,
      );
    }
  }

// if waiter didn’t pick an order ? msg no order : listView of order
  _orderListOrNoOrder(OrdersController pickerOrder) {
    if (pickerOrder.listPickOrder.isNotEmpty) {
      return Stack(
        children: [
          ListView.builder(
            itemCount: pickerOrder.listPickOrder.length,
            itemBuilder: (_, index) {
              var newObj = pickerOrder.listPickOrder[index];
              return Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: secondryColor,
                    borderRadius: BorderRadius.circular(mainRadius),
                    border: Border.all(color: mainColor, width: 1.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // img ,name ,price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(mainRadius)),
                          child: Image.asset(
                            newObj.imgOrder,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTxt(newObj.nameOrder,
                                  fSzie: 18, fontWeight: FontWeight.bold),
                              CustomTxt(
                                  "${newObj.numCount} * ${newObj.priceOne} = ${newObj.totelPrice}"),
                            ],
                          ),
                        )
                      ],
                    ),
                    // btn add / remove
                    Row(
                      children: [
                        CustomIconBtn(
                          onClick: () => pickerOrder.incrementOrder(index),
                          iconData: Icons.add_circle_outline,
                          btnColor: Colors.green,
                          btnSize: 24,
                        ),
                        CustomTxt('${newObj.numCount}'),
                        CustomIconBtn(
                          onClick: () => pickerOrder.discernmentOrder(index),
                          iconData: Icons.remove_circle_outline,
                          btnColor: Colors.red,
                          btnSize: 24,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: CustomTxt('$totaltxt ${pickerOrder.newInvoice}')),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async =>
                          await pickerOrder.setNewOrderToLocale(context),
                      child: Container(
                        color: Colors.greenAccent.shade700,
                        padding: const EdgeInsets.all(8),
                        child: CustomTxt(
                          saveOrder,
                          color: mainColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: CustomTxt(noOrder,
            color: mainColor, fSzie: 20, fontWeight: FontWeight.bold),
      );
    }
  }
}
