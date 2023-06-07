import 'package:flutter/material.dart';

import '../../Colors and Icons/colors_icons.dart';
import '../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task? task;
  final bool? isAllTask;

  const TaskCard({Key? key, required this.task, required this.isAllTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAllTask == true
        ? Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColor(ColorApp.blueAccent as int?), // ColorApp.blueAccent
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${task!.title}',
                      style: TextStyle(
                        color: ColorApp.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          IconAPP.accessTimeRounded,
                          color: ColorApp.whiteColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${task!.startTime}',
                          style: TextStyle(color: ColorApp.whiteColor),
                        ),
                        Text(
                          '- ${task!.endTime}',
                          style: TextStyle(color: ColorApp.whiteColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: ColorApp.whiteColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${task!.date}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(right: 105.0),
                      child: Container(
                        height: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'REPEAT: ${task!.repeat}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: 0.5,
              color: Colors.white,
            ),
            const SizedBox(
              width: 3,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                '${task!.isCompleted == 0 ? 'TODO' : 'Completed'}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: ColorApp.whiteColor,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    )
        : Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColor(ColorApp.blueAccent as int?), // ColorApp.blueAccent
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      task!.title,
                      style: TextStyle(
                        color: ColorApp.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          IconAPP.accessTimeRounded,
                          color: ColorApp.whiteColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          task!.startTime,
                          style: TextStyle(color: ColorApp.whiteColor),
                        ),
                        Text(
                          '- ${task!.endTime}',
                          style: TextStyle(color: ColorApp.whiteColor),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 105.0),
                      child: Container(
                        height: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'REPEAT: ${task!.repeat}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: 0.5,
              color: Colors.white,
            ),
            const SizedBox(
              width: 3,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                '${task!.isCompleted == 0 ? 'TODO' : 'Completed'}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: ColorApp.whiteColor,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }




  getColor(int? Color) {
    switch (Color) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.orangeAccent;
      case 3:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}