import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/priority_enum.dart';

class PriorityChip extends StatelessWidget {
  final Priority priority;

  const PriorityChip({super.key, required this.priority});

  Color _getColor() {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  String _getLabel() {
    return priority.name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_getLabel(), style: const TextStyle(color: Colors.white)),
      backgroundColor: _getColor(),
      visualDensity: VisualDensity.compact,
    );
  }
}
