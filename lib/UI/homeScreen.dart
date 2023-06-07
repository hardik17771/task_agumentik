import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app_agumentik/UI/allTasksScreen.dart';
import '../Colors and Icons/colors_icons.dart';
import '../models/api_service.dart';
import '../models/task_controller.dart';
import '../models/task_model.dart';
import 'Widgets/TaskCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

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

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // TODO: Add DatePicker here

          Expanded(
            child: Obx(() {
              if (_taskController.tasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.lock,
                        size: 70.0,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'No tasks found',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: _taskController.tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = _taskController.tasks[index];
                    return Dismissible(
                      key: Key(task.id),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.green,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          _deleteTask(task);
                        } else if (direction == DismissDirection.endToStart) {
                          _updateTask(task);
                        }
                      },
                      child: TaskCard(
                        task: task, isAllTask: true,
                      ),
                    );
                  },
                );

              }
            }),
          ),
        ],
      ),
    );
  }
}







void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    home: HomeScreen(),
  ));
}
