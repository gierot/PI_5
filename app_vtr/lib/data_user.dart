import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataUser {
  String token_user = '';
  final storage = const FlutterSecureStorage();

  setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  getToken() async {
    return storage.read(key: 'token');
  }

  destroyUser() {
    storage.delete(key: 'token');
  }
}
