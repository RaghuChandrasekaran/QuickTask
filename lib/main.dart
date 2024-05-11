import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/data/task.dart';
import 'package:quicktask/pages/homepage.dart';
import './env/env.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<List<Task>>('tasks');

  final String keyApplicationId = Env.keyApplicationId;
  final String keyClientKey = Env.keyClientKey;
  const String keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.yellow,
            elevation: 0,
            centerTitle: true,
          ),
        ));
  }
}
