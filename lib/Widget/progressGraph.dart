import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytasks/Controller/task_controller.dart';

Widget buildProgressGraph() {
  final taskController = Get.find<TaskController>();
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Completed tasks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final tasks = taskController.tasks;
          final completedTasks = tasks.where((task) => task.isCompleted).length;
          final totalTasks = tasks.length;
          final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

          return Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    minHeight: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          );
        }),
      ],
    ),
  );
}
