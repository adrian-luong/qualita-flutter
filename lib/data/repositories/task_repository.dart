import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/utils/generate_id.dart';

class TaskRepository {
  // Box which will use to store the things
  static final box = Hive.box<Task>('tasks');

  static Future<void> setupTestData() async {
    await box.clear();
    final now = DateTime.now();
    final testTasks = {
      ...Task(
        id: generateID(),
        title: 'Test Task 1',
        startDate: now,
        tags: [TagRepository.testingTagId],
        order: 0,
      ).formMap(),
      ...Task(
        id: generateID(),
        title: 'Test Task 2',
        startDate: now,
        tags: [TagRepository.productionTagId],
        order: 1,
      ).formMap(),
      ...Task(
        id: generateID(),
        title: 'Test Task 3',
        startDate: now,
        tags: [TagRepository.testingTagId, TagRepository.productionTagId],
        order: 2,
      ).formMap(),
    };
    await box.putAll(testTasks);
  }

  // Create or add single data in hive
  static Future<void> addTask(Task newTask) async {
    await box.add(newTask);
  }

  static Future<void> importTasks(List<Task> taskList) async {
    await box.clear();
    Map<String, Task> map = {};
    for (Task task in taskList) {
      map = {...task.formMap()};
    }
    await box.putAll(map);
  }

  // Get All data  stored in hive
  static List<Task> getAllTasks() {
    return box.values.toList();
  }

  // Get data for particular user in hive
  static Task? findTask(String id) {
    return box.get(id);
  }

  // update data for particular user in hive
  static Future<void> editTask(Task task) async {
    await box.put(task.id, task);
  }

  // delete data for particular user in hive
  static Future<void> deleteTask(String id) async {
    await box.delete(id);
  }
}
