import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quicktask/data/task.dart';

class TodoLocalDatabase {
  List<Task> _toDoList = [];
  final _myBox = Hive.box<List>('tasks');

  Future<bool> createInitialTasks() async {
    if (getAllTasksFromLocalStorage() == null) {
      _toDoList = await readDefaultTasks();
      return true;
    }
    return false;
  }

  Future<List<Task>> readDefaultTasks() async {
      final String response =  await rootBundle.loadString('lib/data/defaulttasks.json');
      Iterable list = json.decode(response);
      List<Task> tasks = list.map((model) => Task.fromJson(model)).toList();
      return tasks;
  }

  List<Task>? getAllTasksFromLocalStorage() {
    return _myBox.get("toDoList")?.map((task) => task as Task).toList();
  }

  void loadTasks() {
    if (getAllTasksFromLocalStorage() != null) {
      _toDoList = getAllTasksFromLocalStorage()!;
    }
  }

  void saveNewTask(String taskName, bool taskCompleted) {
    Task newTask = Task(taskName: taskName, taskCompleted: taskCompleted);
    _toDoList.add(newTask);
    _myBox.put("toDoList", _toDoList);
  }

  void deleteTask(int index) {
    Task taskToBeDeleted = _toDoList[index];
    _toDoList.removeAt(index);
    _myBox.put("toDoList", _toDoList);
  }

  void checkTask(int index) {
    Task taskToBeUpdated = _toDoList[index];
    taskToBeUpdated.taskCompleted = !taskToBeUpdated.taskCompleted;
    _myBox.put("toDoList", _toDoList);
  }

  int getTasksCount() {
    return _toDoList.length;
  }

  Task getTask(int index) {
    return _toDoList[index];
  }

}
