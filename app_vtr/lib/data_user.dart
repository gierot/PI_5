import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataUser {
  String token_user = '';
  final storage = const FlutterSecureStorage();

  setToken(String token, String name, String id, String telefone, String email) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'id', value: id);
    await storage.write(key: 'telefone', value: telefone);
    await storage.write(key: 'email', value: email);
  }

  getToken(String user_key) {
    return storage.read(key: user_key);
  }

  destroyUser() {
    storage.delete(key: 'token');
  }
}
