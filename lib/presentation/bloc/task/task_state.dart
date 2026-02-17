import 'package:task_manager_app/domain/entities/task.dart';

import 'task_event.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final FilterType filter;
  TaskLoaded(this.tasks, this.filter);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
