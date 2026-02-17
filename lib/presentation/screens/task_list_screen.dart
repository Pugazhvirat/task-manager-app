import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager_app/presentation/bloc/task/task_event.dart';
import 'package:task_manager_app/presentation/bloc/task/task_state.dart';

import '../../domain/entities/task.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/task_item.dart';
import 'add_edit_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  void _showUndo(BuildContext context, Task task) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    final snackBar = SnackBar(
      content: const Text('Task deleted'),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          context.read<TaskBloc>().add(AddTaskEvent(task));
        },
      ),
    );

    messenger.showSnackBar(snackBar);

    Future.delayed(const Duration(seconds: 4), () {
      if (context.mounted) {
        messenger.hideCurrentSnackBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by title...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              onChanged: (value) {
                context.read<TaskBloc>().add(SearchTasksEvent(value));
              },
            ),
          ),
        ),
        actions: [
          PopupMenuButton<FilterType>(
            onSelected: (FilterType value) {
              context.read<TaskBloc>().add(FilterTasksEvent(value));
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(value: FilterType.all, child: Text('All')),
              PopupMenuItem(value: FilterType.completed, child: Text('Completed')),
              PopupMenuItem(value: FilterType.pending, child: Text('Pending')),
            ],
          ),
        ],
      ),

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (BuildContext context, TaskState state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const EmptyStateWidget();
            }

            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final Task task = state.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,

                  onDismissed: (DismissDirection direction) {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        _showUndo(context, task);
                      }
                    });
                  },
                  child: TaskItem(
                    task: task,
                    onToggle: () {
                      context.read<TaskBloc>().add(ToggleTaskEvent(task));
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<AddEditTaskScreen>(
                          builder: (BuildContext context) => AddEditTaskScreen(task: task),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<AddEditTaskScreen>(
              builder: (BuildContext context) => const AddEditTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
