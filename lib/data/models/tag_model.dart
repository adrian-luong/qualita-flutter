import 'package:qualita/data/models/base_model.dart';

class TagModel extends BaseModel {
  final String fkProjectId;
  String? description;

  TagModel({
    super.id,
    required super.name,
    required this.fkProjectId,
    this.description,
  });
  factory TagModel.fromMap(Map<String, dynamic> map) => TagModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'],
    fkProjectId: map['fk_project_id'] as String,
  );

  @override
  Map<String, dynamic> toDTOMap() => {
    'name': name,
    'description': description,
    'fk_project_id': fkProjectId,
  };

  @override
  Map<String, dynamic> toMap() => {'id': id, ...toDTOMap()};
}
