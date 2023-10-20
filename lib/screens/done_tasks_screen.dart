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

  ///
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.doneTasksList.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.doneTasksList[index].isDone,
          onChanged: (value) {
            widget.doneTasksList[index].isDone = value;
            widget.undoneTasksList.add(widget.doneTasksList[index]);
            widget.doneTasksList.removeAt(index);

            setState(() {});
          },
          title: Text(widget.doneTasksList[index].title!),
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
                                title: Text('${widget.doneTasksList[index].title}を削除しますか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      widget.doneTasksList.removeAt(index);
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
  }
}
