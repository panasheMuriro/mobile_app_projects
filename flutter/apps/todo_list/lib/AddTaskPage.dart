import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    void saveTask() {
      final title = titleController.text;
      final description = descriptionController.text;
      if (title.isNotEmpty && description.isNotEmpty) {
        Navigator.pop(
          context,
          {'title': title, 'description': description},
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Task Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveTask,
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
