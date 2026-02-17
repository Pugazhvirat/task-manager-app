import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import '../models/task_model.dart';

class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks() async {
    final box = await Hive.openBox<TaskModel>(AppConstants.taskBox);
    return box.values.toList();
  }

  Future<void> addTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>(AppConstants.taskBox);
    await box.put(task.id, task);
  }

  Future<void> updateTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>(AppConstants.taskBox);
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await Hive.openBox<TaskModel>(AppConstants.taskBox);
    await box.delete(id);
  }
}
