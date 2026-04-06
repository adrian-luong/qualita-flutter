import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/models/task.dart';

class TaskRepository {
  // Box which will use to store the things
  static final box = Hive.box<Task>('tasks');

  static Future<void> setupTestData() async {
    final now = DateTime.now();
    final testTasks = [
      Task(title: 'Test Task 1', startDate: now),
      Task(title: 'Test Task 2', startDate: now),
      Task(title: 'Test Task 3', startDate: now),
    ];
    await box.addAll(testTasks);
  }

  // Create or add single data in hive
  static Future<void> addTask(Task newTask) async {
    await box.add(newTask);
  }

  // Get All data  stored in hive
  static List<Task> getAllTasks() {
    return box.values.toList();
  }

  // Get data for particular user in hive
  static Task? findTask(int key) {
    return box.get(key);
  }

  // update data for particular user in hive
  static Future<void> editTask(int key, Task task) async {
    await box.put(key, task);
  }

  // delete data for particular user in hive
  static void deleteTask(int key) async {
    await box.delete(key);
  }
}
