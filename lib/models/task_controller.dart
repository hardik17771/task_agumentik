import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tasks_app_agumentik/models/task_model.dart';

class TaskController extends GetxController {
  final tasks = <Task>[].obs;

  void setTasks(List<Task> newTasks) {
    tasks.clear();
    tasks.addAll(newTasks);
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