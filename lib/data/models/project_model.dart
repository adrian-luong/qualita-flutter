import 'package:qualita/data/models/base_model.dart';

class ProjectModel extends BaseModel {
  final String name;
  final String? description;
  final String fkUserId;

  ProjectModel({
    super.id,
    required this.name,
    required this.description,
    required this.fkUserId,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) => ProjectModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'],
    fkUserId: map['fk_user_id'] as String,
  );

  @override
  Map<String, dynamic> toDTOMap() => {
    'name': name,
    'description': description,
    'fk_user_id': fkUserId,
  };

  @override
  Map<String, dynamic> toMap() => {'id': id, ...toDTOMap()};
}
