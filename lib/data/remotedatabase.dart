import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void saveTask(String taskName, bool taskCompleted) async {
  final task = ParseObject('Task')
    ..set('taskName', taskName)
    ..set('taskCompleted', taskCompleted);

  await task.save();
}