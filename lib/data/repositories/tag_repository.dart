import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/tag.dart';

class TagRepository {
  // Box which will use to store the things
  static final box = Hive.box<Tag>('tags');

  static Future<void> setupTestData() async {
    final testTags = [
      Tag(label: 'Testing', description: 'Testing 123'),
      Tag(label: 'Production', description: 'Ready to launch'),
    ];
    await box.addAll(testTags);
  }

  // Create or add single data in hive
  static Future<void> addTag(Tag newTag) async {
    await box.add(newTag);
  }

  // Get All data  stored in hive
  static List<Tag> getAllTags() {
    return box.values.toList();
  }

  // Get data for particular user in hive
  static Tag? findTag(int key) {
    return box.get(key);
  }

  // update data for particular user in hive
  static Future<void> editTag(int key, Tag tag) async {
    await box.putAt(key, tag);
  }

  // delete data for particular user in hive
  static Future<void> deleteTag(int key) async {
    await box.deleteAt(key);
  }
}
