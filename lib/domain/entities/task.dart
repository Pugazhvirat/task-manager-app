import 'package:equatable/equatable.dart';
import 'package:task_manager_app/domain/entities/priority_enum.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final Priority priority;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.priority,
    required this.isCompleted,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, description, dueDate, priority, isCompleted];
}
