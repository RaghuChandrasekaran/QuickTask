import 'package:hive/hive.dart';

class TodoLocalDatabase {
  List toDoList = [];
  final _myBox = Hive.box('tasks');

  void createInitialTasks() {
    if (_myBox.get("toDoList") == null) {
      toDoList = [
        ['Add a task by clicking on the Add Icon', false],
        ['This task is done', true],
        ['Delete this task by sliding the task to left', false],
      ];
    }
  }

  void loadTasks() {
    if (_myBox.get("toDoList") != null) {
      toDoList = _myBox.get("toDoList");
    }
  }

  void updateTasks() {
    _myBox.put("toDoList", toDoList);
  }
}
