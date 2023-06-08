import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Style/Icon Broken/icon_broken.dart';
import '../../models/api_service.dart';
import '../../models/task_controller.dart';
import '../../models/task_model.dart';


class AddTaskScreen extends StatelessWidget {
  final TaskController _taskController = Get.find<TaskController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();

  final List<int> remindList = [0, 5, 10, 15, 20];
  int _selectedRemind = 0;

  final List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  String _selectedRepeat = 'None';


  void _addTask() async {
    String title = titleController.text;
    String date = dateController.text;
    String startTime = startTimeController.text;
    String endTime = endTimeController.text;

    String repeat = _selectedRepeat;


    try {
      Task newTask = Task(
        id: '',
        title: title,

        date: date,
        startTime: startTime,
        endTime: endTime,
        repeat: repeat,

        isCompleted: true,
      );

      final createdTask = await APIService.createTask(newTask);
      _taskController.addTask(createdTask);

      Get.back(); // Go back to previous screen
    } catch (e) {
      // Handle error
      print('Failed to create task: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(IconBroken.arrowLeft2),
        ),
        title: Text('Add Task'),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter title here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        dateController.text =
                        '${picked.year}-${picked.month}-${picked.day}';
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Select date',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Time',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter start time here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    controller: startTimeController,
                    keyboardType: TextInputType.datetime,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Time',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter end time here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    controller: endTimeController,
                    keyboardType: TextInputType.datetime,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remind',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<int>(
                    value: _selectedRemind,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        _selectedRemind = newValue;
                      }
                    },
                    items: remindList.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value minutes before'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Repeat',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedRepeat,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _selectedRepeat = newValue;
                      }
                    },
                    items: repeatList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTask,
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
