import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytasks/Controller/task_controller.dart';
import 'package:mytasks/Widget/showDialog.dart';


Widget buildTaskSection(
      String title, List tasks, TaskController taskController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...tasks.map((task) {
            return Dismissible(
              key: Key(task.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: const Color(0xFFD0A4A1),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                final deletedTask = task;
                final taskIndex = taskController.tasks.indexOf(task);

                taskController.deleteTask(taskIndex);

                // Show SnackBar with Undo option
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(
                    content: const Text('Task deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        if (!taskController.tasks.contains(deletedTask)) {
                          taskController.tasks.insert(taskIndex, deletedTask);
                          deletedTask.save();
                        }
                      },
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Add border
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  leading: CircleAvatar(
                    backgroundColor:
                        task.isCompleted ? Colors.blue : Colors.green,
                    radius: 8,
                  ),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => taskController.toggleTaskCompletion(
                        taskController.tasks.indexOf(task)),
                  ),
                  onTap: () => showUpdateTaskDialog(task, taskController),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }