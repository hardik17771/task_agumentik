import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/api_service.dart';
import '../models/task_controller.dart';
import '../models/task_model.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  Future<void> _loadTasks() async {
    try {
      final tasks = await APIService.getTasks();
      _taskController.setTasks(tasks);
    } catch (e) {
      // Handle error
      print('Failed to load tasks: $e');
    }
  }

  Future<void> _deleteTask(Task task) async {
    try {
      await APIService.deleteTask(task.id.toString());
      _taskController.deleteTask(task);
    } catch (e) {
      // Handle error
      print('Failed to delete task: $e');
    }
  }

  Future<void> _updateTask(Task task) async {
    try {
      await APIService.updateTask(task);
      _taskController.updateTask(task);
    } catch (e) {
      // Handle error
      print('Failed to update task: $e');
    }
  }

  Future<void> _addTask() async {
    final result = await Get.to(() => AllTaskScreen());
    if (result != null && result is Task) {
      try {
        final createdTask = await APIService.createTask(result);
        _taskController.addTask(createdTask);
      } catch (e) {
        // Handle error
        print('Failed to create task: $e');
      }
    }
  }

  final TaskController _taskController = Get.put(TaskController());
  late final Task tasks;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_left),
        ),
        title: Text('All Tasks'),
        actions: [
          if (_taskController.tasks.isNotEmpty)
            IconButton(
              onPressed: () {
                alertDialogBuild(context);
              },
              icon: Icon(Icons.delete),
            ),
          const SizedBox(width: 14),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _showTask(),
          ],
        ),
      ),
    );
  }

  Widget _showTask() {
    return Expanded(
      child: Obx(() {
        if (_taskController.tasks.isEmpty) {
          return Center(
            child: Text('Task List is Empty'),
          );
        } else {
          return ListView.builder(
            itemCount: _taskController.tasks.length,
            itemBuilder: (context, index) {
              var task = _taskController.tasks[index];
              return ListTile(
                title: Text(task.title),
                onTap: () {
                  _showBottomSheet(context, task);
                },
              );
            },
          );
        }
      }),
    );
  }

  void _showBottomSheet(context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // RESTful operations based on task properties
            if (task.isCompleted == 1) ...[
              ListTile(
                onTap: () {
                  // RESTful operation to update task as not complete
                  _updateTask(task);
                  Get.back();
                },
                leading: Icon(Icons.repeat),
                title: Text('Convert to ToDo'),
              ),
            ] else ...[

            ],
            ListTile(
              onTap: () {
                // RESTful operation to delete task
               _deleteTask(task);
                Get.back();
              },
              leading: Icon(Icons.clear),
              title: Text('Delete Task'),
            ),
          ],
        ),
      ),
    );
  }

  void alertDialogBuild(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      title: Text('Delete Task'),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text('Are you sure you want to delete all tasks?'),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      // RESTful operation to delete all tasks
                      _deleteTask(tasks);
                      Get.back();
                      // Show success snackbar
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (ctx) => alert, barrierDismissible: false);
  }
}
