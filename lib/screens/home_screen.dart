import 'package:flutter/material.dart';

import '../data/task_list.dart';
import 'add_tasks_screen.dart';
import 'done_tasks_screen.dart';
import 'undone_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showUndoneTasksScreen = true;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Udemy Tasks'),
        backgroundColor: Colors.redAccent.withOpacity(0.3),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            showUndoneTasksScreen
                ? UndoneTasksScreen(
                    doneTasksList: taskList.where((element) => element.isDone == true).toList(),
                    undoneTasksList: taskList.where((element) => element.isDone == false).toList(),
                  )
                : DoneTasksScreen(
                    doneTasksList: taskList.where((element) => element.isDone == true).toList(),
                    undoneTasksList: taskList.where((element) => element.isDone == false).toList(),
                  ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showUndoneTasksScreen = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.3)),
                      child: const Text('未完了'),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showUndoneTasksScreen = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.3)),
                      child: const Text('完了'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTasksScreen(
                undoneTasksList: taskList.where((element) => element.isDone == false).toList(),
              ),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
