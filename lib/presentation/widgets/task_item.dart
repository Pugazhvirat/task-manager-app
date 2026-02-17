import 'package:flutter/material.dart';

import '../../core/utils/date_utils.dart';
import '../../domain/entities/task.dart';
import 'priority_chip.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskItem({super.key, required this.task, required this.onToggle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Checkbox(value: task.isCompleted, onChanged: (_) => onToggle()),
        title: Text(
          task.title,
          style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : null),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty) Text(task.description!),
            if (task.dueDate != null)
              Text(AppDateUtils.format(task.dueDate), style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            PriorityChip(priority: task.priority),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
