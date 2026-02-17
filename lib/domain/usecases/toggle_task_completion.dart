import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleTaskCompletion {
  final TaskRepository repository;
  ToggleTaskCompletion(this.repository);

  Future<void> call(Task task) {
    return repository.updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }
}
