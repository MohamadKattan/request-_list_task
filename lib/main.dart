import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_list_task/controllers%20/orders_controller.dart';

import 'controllers /items_controller.dart';
import 'controllers /perview_controllers.dart';
import 'controllers /tabels_controllers.dart';
import 'views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ItemsController().setItemsDumyDataToLocale();
  await ItemsController().getItemsFromLocal();

  runApp(
    const MyApp(),
  );
}
// task start from 08.00 am => 6.00 pm
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabelsController()),
        ChangeNotifierProvider(create: (_) => PerViewScreenController()),
        ChangeNotifierProvider(create: (_) => ItemsController()),
        ChangeNotifierProvider(create: (_) => OrdersController())
      ],
      child: MaterialApp(
        title: 'Waiter order list',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
