import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/tag.dart';
import 'package:qualita/utils/generate_id.dart';

class TagRepository {
  // Box which will use to store the things
  static final box = Hive.box<Tag>('tags');
  static final testingTagId = generateID();
  static final productionTagId = generateID();

  static Future<void> setupTestData() async {
    final testTags = {
      ...Tag(
        id: testingTagId,
        label: 'Testing',
        description: 'Testing 123',
      ).formMap(),
      ...Tag(
        id: productionTagId,
        label: 'Production',
        description: 'Ready to launch',
      ).formMap(),
    };
    await box.putAll(testTags);
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
  static Tag? findTag({String? id, String? label}) {
    if (id != null) return box.get(id);
    if (label != null) {
      return getAllTags().firstWhere((tag) => tag.label == label);
    }
    return null;
  }

  // update data for particular user in hive
  static Future<void> editTag(Tag tag) async {
    await box.put(tag.id, tag);
  }

  // delete data for particular user in hive
  static Future<void> deleteTag(String id) async {
    await box.delete(id);
  }
}
