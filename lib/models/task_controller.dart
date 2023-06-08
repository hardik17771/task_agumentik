import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tasks_app_agumentik/models/task_model.dart';

class TaskController extends GetxController {
  final tasks = <Task>[].obs;

  void setTasks(dynamic newTasks) {
    if (newTasks != null && newTasks is List) {
      tasks.value = newTasks.cast<Task>();
    }
  }


  void addTask(Task task) {
    tasks.add(task);
  }

  void deleteTask(Task task) {
    tasks.removeWhere((t) => t.id == task.id);
  }


  void updateTask(Task task) {
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }
}
