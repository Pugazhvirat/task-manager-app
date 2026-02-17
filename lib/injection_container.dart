import 'package:task_manager_app/presentation/bloc/task/task_bloc.dart';

import 'data/datasources/task_local_datasource.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/toggle_task_completion.dart';
import 'domain/usecases/update_task.dart';

class InjectionContainer {
  static TaskBloc init() {
    final dataSource = TaskLocalDataSource();
    final repository = TaskRepositoryImpl(dataSource);

    return TaskBloc(
      getTasks: GetTasks(repository),
      addTask: AddTask(repository),
      updateTask: UpdateTask(repository),
      deleteTask: DeleteTask(repository),
      toggleTaskCompletion: ToggleTaskCompletion(repository),
    );
  }
}
