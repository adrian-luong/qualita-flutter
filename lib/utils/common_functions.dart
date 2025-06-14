import 'package:qualita/data/models/base_model.dart';

void sortByAttr<T extends BaseModel>(List<T> list, String attr) {
  list.sort((a, b) {
    var positionA = a.toMap()[attr] as int;
    var positionB = b.toMap()[attr] as int;
    return positionA.compareTo(positionB);
  });
}

List<T> reorder<T extends BaseModel>({
  required int oldPosition,
  required int newPosition,
  String positionAttr = 'position',
  required List<T> oldOrder,
}) {
  List<T> newOrder = List.from(oldOrder);
  sortByAttr(newOrder, positionAttr);
  if (oldPosition < newPosition) {
    newPosition -= 1;
  }

  final reorderTarget = newOrder.removeAt(oldPosition);
  newOrder.insert(newPosition, reorderTarget);
  newOrder.asMap().forEach((index, item) => item.toMap()[positionAttr] = index);
  sortByAttr(newOrder, positionAttr);

  return newOrder;
}
