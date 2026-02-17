import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/usecases/add_task.dart';
import 'package:task_manager_app/domain/usecases/delete_task.dart';
import 'package:task_manager_app/domain/usecases/get_tasks.dart';
import 'package:task_manager_app/domain/usecases/toggle_task_completion.dart';
import 'package:task_manager_app/domain/usecases/update_task.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final ToggleTaskCompletion toggleTaskCompletion;

  FilterType currentFilter = FilterType.all;
  List<Task> allTasks = [];

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.toggleTaskCompletion,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoad);
    on<AddTaskEvent>(_onAdd);
    on<UpdateTaskEvent>(_onUpdate);
    on<DeleteTaskEvent>(_onDelete);
    on<ToggleTaskEvent>(_onToggle);
    on<FilterTasksEvent>(_onFilter);
    on<SearchTasksEvent>(_onSearch);
  }

  Future<void> _onLoad(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    allTasks = await getTasks();
    currentFilter = FilterType.all;
    emit(TaskLoaded(allTasks, currentFilter));
  }

  Future<void> _onAdd(AddTaskEvent event, Emitter<TaskState> emit) async {
    await addTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onUpdate(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    await updateTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onDelete(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await deleteTask(event.id);
    add(LoadTasks());
  }

  Future<void> _onToggle(ToggleTaskEvent event, Emitter<TaskState> emit) async {
    await toggleTaskCompletion(event.task);
    add(LoadTasks());
  }

  void _onFilter(FilterTasksEvent event, Emitter<TaskState> emit) {
    currentFilter = event.filter;
    emit(TaskLoaded(_applyFilter(), currentFilter));
  }

  void _onSearch(SearchTasksEvent event, Emitter<TaskState> emit) {
    final query = event.query.toLowerCase();

    final searchedTasks = _applyFilter().where((task) {
      return task.title.toLowerCase().contains(query);
    }).toList();

    emit(TaskLoaded(searchedTasks, currentFilter));
  }

  List<Task> _applyFilter() {
    switch (currentFilter) {
      case FilterType.completed:
        return allTasks.where((e) => e.isCompleted).toList();
      case FilterType.pending:
        return allTasks.where((e) => !e.isCompleted).toList();
      default:
        return allTasks;
    }
  }
}
