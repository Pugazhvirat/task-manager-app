import '../entities/task.dart';
import '../repositories/task_repository.dart';

class SearchTasks {
  final TaskRepository repository;

  SearchTasks(this.repository);

  Future<List<Task>> call(String query) async {
    final tasks = await repository.getTasks();

    if (query.isEmpty) return tasks;

    return tasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
