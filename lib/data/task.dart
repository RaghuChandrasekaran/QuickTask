import 'package:hive/hive.dart';

part 'task.g.dart';

//TODO: Explore extending hive object
@HiveType(typeId: 1)
class Task {
   
  @HiveField(0)
  String taskName;
  
  @HiveField(1)
  bool taskCompleted;

  Task({required this.taskName, required this.taskCompleted});

  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        taskCompleted = json['taskCompleted'];

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskCompleted': taskCompleted,
    };
  }
}