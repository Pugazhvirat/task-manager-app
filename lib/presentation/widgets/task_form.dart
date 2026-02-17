import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/priority_enum.dart';

import '../../domain/entities/task.dart';

class TaskForm extends StatefulWidget {
  final Task? existingTask;
  final void Function(String title, String? description, DateTime? dueDate, Priority priority)
  onSubmit;

  const TaskForm({super.key, this.existingTask, required this.onSubmit});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  Priority _priority = Priority.low;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTask?.title ?? '');
    _descriptionController = TextEditingController(text: widget.existingTask?.description ?? '');
    _dueDate = widget.existingTask?.dueDate;
    _priority = widget.existingTask?.priority ?? Priority.low;
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => _dueDate = date);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title Field
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                decoration: _inputDecoration('Title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 16),

              /// Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                style: const TextStyle(fontSize: 15),
                decoration: _inputDecoration('Description'),
              ),

              const SizedBox(height: 20),

              /// Date Picker Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.blueGrey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _dueDate == null
                            ? 'No Due Date'
                            : _dueDate!.toLocal().toString().split(' ')[0],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      child: const Text(
                        'Select Date',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Priority Dropdown
              DropdownButtonFormField<Priority>(
                value: _priority,
                decoration: _inputDecoration('Priority'),
                items: Priority.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _priority = value);
                },
              ),

              const SizedBox(height: 30),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit(
                        _titleController.text,
                        _descriptionController.text.isEmpty ? null : _descriptionController.text,
                        _dueDate,
                        _priority,
                      );
                    }
                  },
                  child: const Text(
                    'Save Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
