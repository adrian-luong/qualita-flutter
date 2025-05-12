import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

/// Storing user credentials
Future<void> storeCredentials(String email, String? token) async {
  await storage.write(key: 'email', value: email);
  await storage.write(key: 'jwt', value: token);
}

/// Retrieving user credentials
Future<Map<String, String?>> getCredentials() async {
  return {
    'email': await storage.read(key: 'email'),
    'jwt': await storage.read(key: 'jwt'),
  };
}
