import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks_app_agumentik/models/task_model.dart';

class APIService {
  static const String baseUrl = 'https://task-backend-o9j8.onrender.com';

  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> taskData = responseData['data'];
      return taskData.map((taskJson) => Task.fromJson(taskJson)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }







  static Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      body: task.toJson(),
    );
    if (response.statusCode == 201) {
      final dynamic data = json.decode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to create task');
    }
  }

  static Future<Task> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/${task.id}'),
      body: task.toJson(),
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to update task');
    }
  }

  static Future<void> deleteTask(String taskId) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$taskId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
