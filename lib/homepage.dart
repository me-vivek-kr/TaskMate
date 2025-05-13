import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytasks/Widget/buildTask.dart';
import 'package:mytasks/Widget/date_selector.dart';
import 'package:mytasks/Controller/task_controller.dart';
import 'package:mytasks/Widget/progressGraph.dart';
import 'package:mytasks/Widget/showDialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    final DateTime today = DateTime.now();
    final String dayOfWeek = DateFormat('EEEE').format(today);
    final String formattedDate = DateFormat('MMMM d, y').format(today);

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 100,
      //   // backgroundColor: Colors.grey[200],
      //   elevation: 0,
      //   title:
      // ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dayOfWeek,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // IconButton(
                        //   icon: const Icon(Icons.calendar_today, color: Colors.black),
                        //   onPressed: () {},
                        // ),
                        const SizedBox(width: 8),
                        // CircleAvatar(
                        //   radius: 20,
                        //   backgroundColor: Colors.blue[100],
                        //   child: ClipOval(
                        //     child: Image.asset(
                        //       'assets/images/profile.jpg',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildDateSelector(),
              SizedBox(height: 1.h),
              buildProgressGraph(),
              Expanded(
                child: Obx(() {
                  final tasks = taskController.tasks;
                  final toDoTasks =
                      tasks.where((task) => !task.isCompleted).toList();
                  final doneTasks =
                      tasks.where((task) => task.isCompleted).toList();

                  return ListView(
                    children: [
                      buildTaskSection('Tasks', toDoTasks, taskController),
                      buildTaskSection('Done', doneTasks, taskController),
                    ],
                  );
                }),
              ),
              Center(
                child: SizedBox(
                  width: 60, // Increased width
                  height: 60, // Increased height
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(35), // Adjusted for larger size
                    ),
                    onPressed: () => showAddTaskDialog(),
                    backgroundColor: Colors.black,
                    child: const Icon(Icons.add,
                        color: Colors.white, size: 30), // Larger icon
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
