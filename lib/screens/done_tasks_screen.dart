import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({super.key, required this.doneTasksList, required this.undoneTasksList});

  final List<Task> doneTasksList;
  final List<Task> undoneTasksList;

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  TextEditingController titleEditController = TextEditingController();

  List<Task> doneTaskList = [];

  ///
  Future<void> getDoneTaskList() async {
    final collection = FirebaseFirestore.instance.collection('task');
    final snapshot = await collection.where('is_done', isEqualTo: true).get();

    snapshot.docs.forEach((element) {
      final doneTask = Task(
        id: element.id,
        title: element['title'],
        isDone: element['is_done'],
        // ignore: avoid_dynamic_calls
        createdAt: element['createdAt'].toDate(),
      );

      doneTaskList.add(doneTask);
    });

    setState(() {});
  }

  ///
  @override
  void initState() {
    super.initState();

    getDoneTaskList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    final collection = FirebaseFirestore.instance.collection('task');

    return ListView.builder(
      itemCount: doneTaskList.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: doneTaskList[index].isDone,
          onChanged: (value) => collection.doc(doneTaskList[index].id).update({'is_done': value}),
          title: Text(doneTaskList[index].title!),
        );
      },
    );
  }
}
