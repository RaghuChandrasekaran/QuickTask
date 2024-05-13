import 'package:flutter/material.dart';
import 'package:quicktask/data/hiveinitializer.dart';
import 'package:quicktask/data/parseinitializer.dart';
import 'package:quicktask/pages/homepage.dart';

void main() async {

  await HiveInitializer.initialize();
  await ParseInitializer.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
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
