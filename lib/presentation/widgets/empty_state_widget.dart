import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.task_alt, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('No tasks found', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
