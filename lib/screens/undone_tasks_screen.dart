import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class UndoneTasksScreen extends StatefulWidget {
  const UndoneTasksScreen({super.key, required this.doneTasksList, required this.undoneTasksList});

  final List<Task> doneTasksList;
  final List<Task> undoneTasksList;

  ///
  @override
  State<UndoneTasksScreen> createState() => _UndoneTasksScreenState();
}

class _UndoneTasksScreenState extends State<UndoneTasksScreen> {
  TextEditingController titleEditController = TextEditingController();

  List<Task> undoneTaskList = [];

  ///
  Future<void> getUndoneTaskList() async {
    final collection = FirebaseFirestore.instance.collection('task');
    final snapshot = await collection.where('is_done', isEqualTo: false).get();

    snapshot.docs.forEach((element) {
      final undoneTask = Task(
        id: element.id,
        title: element['title'],
        isDone: element['is_done'],
        // ignore: avoid_dynamic_calls
        createdAt: element['createdAt'].toDate(),
      );

      undoneTaskList.add(undoneTask);
    });

    setState(() {});
  }

  ///
  @override
  void initState() {
    super.initState();

    getUndoneTaskList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    final collection = FirebaseFirestore.instance.collection('task');

    return ListView.builder(
      itemCount: undoneTaskList.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: undoneTaskList[index].isDone,
          onChanged: (value) => collection.doc(undoneTaskList[index].id).update({'is_done': value}),
          title: Text(undoneTaskList[index].title!),
        );
      },
    );
  }
}
