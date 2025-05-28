class StepModel {
  final String? id;
  final String name;
  final String fkProjectId;
  final DateTime? createdAt;

  StepModel({
    this.id,
    required this.name,
    required this.fkProjectId,
    this.createdAt,
  });

  factory StepModel.fromMap(Map<String, dynamic> map) => StepModel(
    id: map['id'],
    name: map['name'],
    fkProjectId: map['fk_project_id'],
    createdAt: DateTime.tryParse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'fk_project_id': fkProjectId,
    'created_at': createdAt,
  };

  Map<String, dynamic> toUpsertMap() => {
    'name': name,
    'fk_project_id': fkProjectId,
  };
}
