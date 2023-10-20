import 'package:flutter/material.dart';

import '../models/task.dart';

class AddTasksScreen extends StatefulWidget {
  const AddTasksScreen({super.key, required this.undoneTasksList});

  final List<Task> undoneTasksList;

  @override
  State<AddTasksScreen> createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  TextEditingController titleController = TextEditingController();

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTasksScreen'),
        backgroundColor: Colors.redAccent.withOpacity(0.3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.undoneTasksList.add(
                    Task(
                      title: titleController.text,
                      isDone: false,
                      createdAt: DateTime.now(),
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text('input'),
            ),
          ],
        ),
      ),
    );
  }
}
