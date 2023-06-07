import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tasks_app_agumentik/models/task_model.dart';

class TaskController extends GetxController {
  final tasks = <Task>[].obs;

  void setTasks(dynamic newTasks) {
    if (newTasks is List) {
      tasks.clear();
      tasks.addAll(newTasks.map((task) => Task.fromJson(task)).toList());
    }
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void updateTask(Task task) {
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }
}
