import 'package:qualita/data/models/base_model.dart';

class TaskModel extends BaseModel {
  final String name;
  final String? description;
  int value;
  int position;
  final String fkStepId;
  final String fkProjectId;

  TaskModel({
    super.id,
    required this.name,
    this.value = 1,
    this.position = 0,
    this.description,
    required this.fkProjectId,
    required this.fkStepId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'] as String,
    value: map['value'] as int,
    position: map['position'] as int,
    fkProjectId: map['fk_project_id'] as String,
    fkStepId: map['fk_step_id'] as String,
  );

  @override
  Map<String, dynamic> toDTOMap() => {
    'name': name,
    'description': description,
    'value': value,
    'position': position,
    'fk_project_id': fkProjectId,
    'fk_step_id': fkStepId,
  };

  @override
  Map<String, dynamic> toMap() => {'id': id, ...toDTOMap()};
}
