import 'package:qualita/data/models/base_model.dart';

class StepModel extends PositionalModel {
  String name;
  final String fkProjectId;

  StepModel({
    super.id,
    super.position,
    required this.name,
    required this.fkProjectId,
  });

  factory StepModel.fromMap(Map<String, dynamic> map) => StepModel(
    id: map['id'] as String,
    name: map['name'] as String,
    position: map['position'] as int,
    fkProjectId: map['fk_project_id'] as String,
  );

  @override
  Map<String, dynamic> toDTOMap() => {
    'name': name,
    'position': position,
    'fk_project_id': fkProjectId,
  };

  @override
  Map<String, dynamic> toMap() => {'id': id, ...toDTOMap()};
}
