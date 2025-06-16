import 'package:qualita/data/models/base_model.dart';

List<T> reorder<T extends PositionalModel>({
  required int oldPosition,
  required int newPosition,
  String positionAttr = 'position',
  required List<T> oldOrder,
}) {
  List<T> newOrder = List.from(oldOrder);
  newOrder.sort((a, b) => a.position.compareTo(b.position));

  if (oldPosition < newPosition) {
    newPosition -= 1;
  }

  final reorderTarget = newOrder.removeAt(oldPosition);
  newOrder.insert(newPosition, reorderTarget);
  newOrder.asMap().forEach((index, item) => item.position = index);
  newOrder.sort((a, b) => a.position.compareTo(b.position));

  return newOrder;
}
