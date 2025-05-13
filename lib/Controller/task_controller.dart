import 'package:get/get.dart';
import '../Database/database_helper.dart';
import '../Model/task.dart';

class TaskController extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    final dbTasks = await _dbHelper.getTasks();
    tasks.assignAll(dbTasks);
  }

  void addTask(String title, String description) async {
    final task = Task(title: title, description: description);
    final id = await _dbHelper.insertTask(task);
    task.id = id;
    tasks.add(task);
  }

  void toggleTaskCompletion(int index) async {
    final task = tasks[index];
    task.isCompleted = !task.isCompleted;
    await _dbHelper.updateTask(task);
    tasks[index] = task;
  }

  void deleteTask(int index) async {
    final task = tasks[index];
    await _dbHelper.deleteTask(task.id!);
    tasks.removeAt(index);
  }

  void updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }
}
