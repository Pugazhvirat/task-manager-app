import 'package:task_manager_app/domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  DeleteTaskEvent(this.id);
}

class ToggleTaskEvent extends TaskEvent {
  final Task task;
  ToggleTaskEvent(this.task);
}

enum FilterType { all, completed, pending }

class FilterTasksEvent extends TaskEvent {
  final FilterType filter;
  FilterTasksEvent(this.filter);
}

class SearchTasksEvent extends TaskEvent {
  final String query;
  SearchTasksEvent(this.query);
}
