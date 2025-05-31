class StepModel {
  final String? id;
  final String name;
  int position;
  final String fkProjectId;
  final DateTime? createdAt;

  StepModel({
    this.id,
    required this.name,
    this.position = 0,
    required this.fkProjectId,
    this.createdAt,
  });

  factory StepModel.fromMap(Map<String, dynamic> map) => StepModel(
    id: map['id'],
    name: map['name'],
    position: map['position'],
    fkProjectId: map['fk_project_id'],
    createdAt: DateTime.tryParse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'position': position,
    'fk_project_id': fkProjectId,
    'created_at': createdAt?.toIso8601String(),
  };

  Map<String, dynamic> toUpsertMap() => {
    'name': name,
    'position': position,
    'fk_project_id': fkProjectId,
  };

  Map<String, dynamic> toUpdateMap() => {
    'id': id,
    'name': name,
    'position': position,
    'fk_project_id': fkProjectId,
  };
}
