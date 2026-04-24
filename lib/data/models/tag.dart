import 'package:hive_flutter/hive_flutter.dart';

part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String label;
  @HiveField(2)
  String? description;

  Tag({required this.id, required this.label, this.description});

  static Tag empty() => Tag(label: '', id: '');

  Map<String, Tag> formMap() => {id: this};
}
