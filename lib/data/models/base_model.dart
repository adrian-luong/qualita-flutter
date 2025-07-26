abstract class BaseModel {
  final String? id;
  String name;
  BaseModel({required this.id, required this.name});

  // Abstract factory constructor to create a model from a JSON map
  BaseModel.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String;
  // Abstract method to convert the model to a JSON map
  Map<String, dynamic> toMap();
  // Abstract method to convert the model to a DTO JSON map
  Map<String, dynamic> toDTOMap();
}

abstract class PositionalModel extends BaseModel {
  int position;
  PositionalModel({super.id, required super.name, this.position = 0});
}
