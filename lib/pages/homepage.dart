import 'package:flutter/material.dart';
import '../widgets/todotile.dart';
import '../widgets/dialogbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskInputController = TextEditingController();

  List toDoList = [];

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _taskInputController,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void saveNewTask() {
    if (_taskInputController.text.isNotEmpty) {
      setState(() {
        toDoList.add([_taskInputController.text, false]);
        _taskInputController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Task')),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
