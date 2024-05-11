import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/data/task.dart';

class ToDoRemoteDatabase {

  Future<Task> saveTask(String taskName, bool taskCompleted) async {
    final task = ParseObject('Task')
      ..set('taskName', taskName)
      ..set('taskCompleted', taskCompleted);

    await task.save();
    return Task.fromJson(task.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    final queryBuilder = QueryBuilder(ParseObject('Task'))
      ..orderByAscending('createdAt');

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      List<ParseObject> results = response.results as List<ParseObject>;
      return results
          .map((parseTaskObject) => Task.fromJson(parseTaskObject.toJson()))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> updateTask(Task task) async {
    var taskParseObject = ParseObject('Task')
      ..objectId = task.id
      ..set('taskName', task.taskName)
      ..set('taskCompleted', task.taskCompleted);
    await taskParseObject.save();
  }

  Future<void> deleteTask(String id) async {
    var task = ParseObject('Task')..objectId = id;
    await task.delete();
  }

}
