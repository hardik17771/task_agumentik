import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Colors and Icons/colors_icons.dart';
import '../../Style/Icon Broken/icon_broken.dart';
import '../../models/api_service.dart';
import '../../models/task_controller.dart';
import '../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task? task;
  final bool? isAllTask;

  const TaskCard({Key? key, required this.task, required this.isAllTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAllTask == true ? Colors.blueAccent : Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    task!.title,
                    style: TextStyle(
                      color: ColorApp.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        IconAPP.accessTimeRounded,
                        color: ColorApp.whiteColor,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        task!.startTime,
                        style: TextStyle(
                          color: ColorApp.whiteColor,
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      Text(
                        ' - ${task!.endTime}',
                        style: TextStyle(
                          color: ColorApp.whiteColor,
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: ColorApp.whiteColor,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        task!.date,
                        style: TextStyle(
                          color: ColorApp.whiteColor,
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'REPEAT: ${task!.repeat}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                '${task!.isCompleted == false ? 'TODO' : 'Completed'}',
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
}



