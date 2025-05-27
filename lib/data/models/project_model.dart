class ProjectModel {
  final String? id;
  final String name;
  final String? description;
  final String fkUserId;
  final DateTime? createdAt;

  ProjectModel({
    this.id,
    required this.name,
    required this.description,
    required this.fkUserId,
    this.createdAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) => ProjectModel(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    fkUserId: map['fk_user_id'],
    createdAt: DateTime.tryParse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'fk_user_id': fkUserId,
    'created_at': createdAt,
  };

  Map<String, dynamic> toUpsertMap() => {
    'name': name,
    'description': description,
    'fk_user_id': fkUserId,
  };
}
