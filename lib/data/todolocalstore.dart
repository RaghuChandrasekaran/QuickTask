import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quicktask/data/todoremotestore.dart';
import 'package:quicktask/model/task.dart';
import 'package:collection/collection.dart';

class TodoLocalStore {
  
  List<Task> _toDoList = [];
  final _myBox = Hive.box<List>('tasks');
  ToDoRemoteStore db = ToDoRemoteStore();

  Future<bool> loadInitialTasks() async {
    if (_myBox.get("toDoList") == null) {
      _toDoList = await readDefaultTasks();
      _myBox.put("toDoList", _toDoList);
    } else {
      _toDoList = getAllTasksFromLocal()!;
    }
    syncDataFromRemote();
    return true;
  }

  Future<List<Task>> readDefaultTasks() async {
    final String response =
        await rootBundle.loadString('lib/data/defaulttasks.json');
    Iterable list = json.decode(response);
    List<Task> tasks = list.map((model) => Task.fromJson(model)).toList();
    return tasks;
  }

  List<Task>? getAllTasksFromLocal() {
    return _myBox.get("toDoList")?.map((task) => task as Task).toList();
  }

  void syncDataFromRemote() async {
    List<Task> remoteTasks = await db.getAllTasks();
    List<Task> localTasks = getAllTasksFromLocal() ?? [];
    for (Task localTask in localTasks) {
      Task? remoteTask =
          remoteTasks.firstWhereOrNull((task) => task.id == localTask.id);
      if (remoteTask == null) {
        db
            .saveTask(localTask.taskName, localTask.taskCompleted)
            .then((savedTask) {
          localTask.id = savedTask.id;
          localTask.createdAt = savedTask.createdAt;
          localTask.updatedAt = savedTask.updatedAt;
          _myBox.put("toDoList", _toDoList);
        });
      }
    }
    // TODO: Fix the sync logic. If edit happens on both local and remote, we need a better logic to resolve it.
    // Read up on CRDT
    for (Task remoteTask in remoteTasks) {
      Task? localTask =
          localTasks.firstWhereOrNull((task) => task.id == remoteTask.id);
      if (localTask == null) {
        _toDoList.add(remoteTask);
      } else {
        if (remoteTask.updatedAt.isAfter(localTask.updatedAt)) {
          localTask.taskName = remoteTask.taskName;
          localTask.taskCompleted = remoteTask.taskCompleted;
          localTask.updatedAt = remoteTask.updatedAt;
        } else if (remoteTask.updatedAt.isBefore(localTask.updatedAt)) {
          print(
              'Conflict: Task "${localTask.taskName}" has been updated locally. Please resolve the conflict.');
        }
      }
    }
    _myBox.put("toDoList", _toDoList);
  }

  void saveNewTask(String taskName, bool taskCompleted) {
    Task newTask = Task(taskName: taskName, taskCompleted: taskCompleted);
    _toDoList.add(newTask);
    _myBox.put("toDoList", _toDoList);
    db.saveTask(taskName, taskCompleted).then((savedTask) {
      newTask.id = savedTask.id;
      newTask.createdAt = savedTask.createdAt;
      newTask.updatedAt = savedTask.updatedAt;
      _myBox.put("toDoList", _toDoList);
    });
  }

  void deleteTask(int index) {
    Task taskToBeDeleted = _toDoList[index];
    _toDoList.removeAt(index);
    _myBox.put("toDoList", _toDoList);
    if (taskToBeDeleted.id != null) {
      db.deleteTask(taskToBeDeleted.id!);
    }
  }

  void checkTask(int index) {
    Task taskToBeUpdated = _toDoList[index];
    taskToBeUpdated.taskCompleted = !taskToBeUpdated.taskCompleted;
    _myBox.put("toDoList", _toDoList);
    if (taskToBeUpdated.id != null) {
      db.updateTask(taskToBeUpdated);
    } else {
      db
          .saveTask(taskToBeUpdated.taskName, taskToBeUpdated.taskCompleted)
          .then((savedTask) {
        taskToBeUpdated.id = savedTask.id;
        taskToBeUpdated.createdAt = savedTask.createdAt;
        taskToBeUpdated.updatedAt = savedTask.updatedAt;
        _myBox.put("toDoList", _toDoList);
      });
    }
  }

  int getTasksCount() {
    return _toDoList.length;
  }

  Task getTask(int index) {
    return _toDoList[index];
  }
}
