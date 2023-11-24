import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_list_task/components%20/ctm_txt.dart';
import 'package:request_list_task/utils/constants.dart';

import '../controllers /tabels_controllers.dart';
import '../views/order_screen.dart';
import 'ctm_progress.dart';

class CustomListTabels extends StatelessWidget {
  const CustomListTabels({super.key});

  @override
  Widget build(BuildContext context) {
    var tabels = context.watch<TabelsController>();
    return tabels.louding
        ? const CustomProgressIndicator()
        : Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              ),
              itemCount: tabels.listRestaurantTabels.length,
              itemBuilder: (_, index) {
                var newTabel = tabels.listRestaurantTabels;
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              OrderScreen(resturnTabelNumber: index + 1))),
                  child: Container(
                    padding: EdgeInsets.all(mainPadding),
                    margin: EdgeInsets.all(mainMargin),
                    decoration: BoxDecoration(
                      color: newTabel[index].isOrdered
                          ? Colors.red.shade400
                          : Colors.black45,
                      borderRadius: BorderRadius.circular(mainRadius),
                      border: Border.all(color: mainColor, width: 2.0),
                    ),
                    child: Column(
                      children: [
                        CustomTxt(txtNumOfTabel +
                            newTabel[index].tabelNumber.toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
