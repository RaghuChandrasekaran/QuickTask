import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/data/userremotestore.dart';
import 'package:quicktask/model/task.dart';

class ToDoRemoteStore {

  UserRemoteStore userRemoteStore = UserRemoteStore();

  Future<Task> saveTask(String taskName, bool taskCompleted) async {
    ParseACL acl = await userRemoteStore.getACL();

    final task = ParseObject('Task')
      ..set('taskName', taskName)
      ..set('taskCompleted', taskCompleted);
    task.setACL(acl);
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
