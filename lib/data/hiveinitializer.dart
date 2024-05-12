import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quicktask/model/task.dart';

class HiveInitializer {

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<List>('tasks');
  }
  
}
