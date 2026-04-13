import 'package:hive_flutter/hive_flutter.dart';

part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag extends HiveObject {
  @HiveField(0)
  String label;
  @HiveField(1)
  String? description;

  Tag({required this.label, this.description});

  static Tag empty() => Tag(label: '');
}
