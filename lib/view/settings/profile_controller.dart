import 'package:qualita/data/services/auth_services.dart';

class ProfileController {
  final _services = AuthServices();

  Future<String> signout() async {
    try {
      await _services.signout();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
