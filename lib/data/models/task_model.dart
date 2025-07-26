import 'package:qualita/data/models/base_model.dart';

class TaskModel extends PositionalModel {
  final String? description;
  int value;
  String fkStepId;
  bool isPinned;
  final String fkProjectId;

  TaskModel({
    super.id,
    required super.name,
    this.value = 1,
    super.position,
    this.description,
    this.isPinned = false,
    required this.fkProjectId,
    required this.fkStepId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'],
    value: map['value'] as int,
    position: map['position'] as int,
    isPinned: map['is_pinned'] != null ? map['is_pinned'] as bool : false,
    fkProjectId: map['fk_project_id'] as String,
    fkStepId: map['fk_step_id'] as String,
  );

  factory TaskModel.clone(TaskModel model) => TaskModel(
    id: model.id,
    name: model.name,
    description: model.description,
    value: model.value,
    position: model.position,
    isPinned: model.isPinned,
    fkProjectId: model.fkProjectId,
    fkStepId: model.fkStepId,
  );

  @override
  Map<String, dynamic> toDTOMap() => {
    'name': name,
    'description': description,
    'value': value,
    'position': position,
    'is_pinned': isPinned,
    'fk_project_id': fkProjectId,
    'fk_step_id': fkStepId,
  };

  @override
  Map<String, dynamic> toMap() => {'id': id, ...toDTOMap()};
}
