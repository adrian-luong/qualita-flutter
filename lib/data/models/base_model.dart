abstract class BaseModel {
  final String? id;
  BaseModel({required this.id});

  // Abstract factory constructor to create a model from a JSON map
  BaseModel.fromMap(Map<String, dynamic> map) : id = map['id'] as String;
  // Abstract method to convert the model to a JSON map
  Map<String, dynamic> toMap();
  // Abstract method to convert the model to a DTO JSON map
  Map<String, dynamic> toDTOMap();
}

abstract class PositionalModel extends BaseModel {
  int position;
  PositionalModel({super.id, this.position = 0});
}
