import 'package:hive/hive.dart';
import 'package:task_manager_app/domain/entities/priority_enum.dart';
import 'package:task_manager_app/domain/entities/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final DateTime? dueDate;

  @HiveField(4)
  final int priority;

  @HiveField(5)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.priority,
    required this.isCompleted,
  });

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority.index,
      isCompleted: task.isCompleted,
    );
  }

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: Priority.values[priority],
      isCompleted: isCompleted,
    );
  }
}
