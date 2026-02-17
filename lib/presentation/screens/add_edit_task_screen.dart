import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager_app/presentation/bloc/task/task_event.dart';

import '../../domain/entities/task.dart';
import '../widgets/task_form.dart';

class AddEditTaskScreen extends StatelessWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task == null ? 'Add Task' : 'Edit Task')),
      body: TaskForm(
        existingTask: task,
        onSubmit: (title, description, dueDate, priority) {
          if (task == null) {
            final newTask = Task(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              description: description,
              dueDate: dueDate,
              priority: priority,
              isCompleted: false,
            );
            context.read<TaskBloc>().add(AddTaskEvent(newTask));
          } else {
            final updated = task!.copyWith(
              title: title,
              description: description,
              dueDate: dueDate,
              priority: priority,
            );
            context.read<TaskBloc>().add(UpdateTaskEvent(updated));
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
