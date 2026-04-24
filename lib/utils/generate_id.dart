import 'dart:math';

/// Generate a 4-character string that is used as ID
String generateID() {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(
    Iterable.generate(4, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
  );
}
