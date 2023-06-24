import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataUser {
  final storage = const FlutterSecureStorage();

  setToken(token, name, id, telefone, email, cpf, foto) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'id', value: id);
    await storage.write(key: 'telefone', value: telefone);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'cpf', value: cpf);
    await storage.write(key: 'foto', value: foto);
  }

  setUnityToken(value, token) async {
    await storage.write(key: token, value: value);
  }

  getToken(String user_key) async {
    var key = await storage.read(key: user_key);
    return key;
  }

  updateToken(value, token) async {
    await storage.delete(key: token);
    await storage.write(key: token, value: value);
  }

  destroyUser() {
    storage.delete(key: 'token');
    storage.delete(key: 'name');
    storage.delete(key: 'id');
    storage.delete(key: 'telefone');
    storage.delete(key: 'email');
    storage.delete(key: 'token_notificacao');
    storage.delete(key: 'password');
  }
}
