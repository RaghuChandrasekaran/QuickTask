import 'package:hive/hive.dart';

part 'task.g.dart';

//TODO: Explore extending hive object
@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool taskCompleted;

  @HiveField(2)
  String? id;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  Task({required this.taskName, required this.taskCompleted})
      : createdAt = DateTime.timestamp(),
        updatedAt = DateTime.timestamp();

  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        taskCompleted = json['taskCompleted'],
        createdAt = DateTime.parse(json['createdAt'] ?? DateTime.timestamp().toString()),
        updatedAt = DateTime.parse(json['updatedAt'] ?? DateTime.timestamp().toString()),
        id = json['objectId'];

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskCompleted': taskCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'objectId': id
    };
  }
}
