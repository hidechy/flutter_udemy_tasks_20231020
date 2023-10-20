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
    return ListView.builder(
      itemCount: undoneTaskList.length,
      itemBuilder: (context, index) {
        return Text(undoneTaskList[index].title!);
      },
    );

    /*


    return ListView.builder(
      itemCount: widget.undoneTasksList.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.undoneTasksList[index].isDone,
          onChanged: (value) {
            widget.undoneTasksList[index].isDone = value;
            widget.doneTasksList.add(widget.undoneTasksList[index]);
            widget.undoneTasksList.removeAt(index);

            setState(() {});
          },
          title: Text(widget.undoneTasksList[index].title!),
          secondary: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('edit'),
                        onTap: () {
                          Navigator.pop(context);

                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  backgroundColor: Colors.white.withOpacity(0.1),
                                  title: Column(
                                    children: [
                                      TextField(
                                        controller: titleEditController,
                                        decoration: const InputDecoration(
                                          hintText: 'title',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('edit'),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('delete'),
                        onTap: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('${widget.undoneTasksList[index].title}を削除しますか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      widget.undoneTasksList.removeAt(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('はい'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('いいえ'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        );
      },
    );


    */
  }
}
