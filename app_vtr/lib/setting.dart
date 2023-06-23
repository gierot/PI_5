import 'package:flutter/material.dart';
import 'package:app_vtr/data_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

DataUser user_vtr = DataUser();

class Settings {
  String url = 'http://18.228.214.223/api';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  var all_colors = {
    'background': const Color(0xFF04121F),
    'color_font': const Color(0xFFbdb113),
    'green_btn': const Color(0xFF31B425)
  };

  getColor(color) {
    return all_colors[color];
  }

  getAccountData(Map<String, String> data) async {
    http.Response response = await http.post(Uri.parse(url + '/login'),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      var token = await user_vtr.getToken('token_notificacao');

      if(token != null) {
        await registerTokenNotificacao(token, user['token']);
      }
      else {
        await getTokenNotificacao(user['token']);
      }
      user_vtr.setToken(
          user['token'].toString(),
          user['nome'].toString(),
          user['id'].toString(),
          user['telefone'],
          user['email'].toString(),
          user['cpfcnpj'].toString());
      return true;
    }
    return false;
  }

  registerUser(Map<String, String> data) async {
    http.Response response = await http.post(Uri.parse(url + '/register'),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      return true;
    }
    return false;
  }

  Future<bool> registerTokenNotificacao(String notificationToken, String authorizationToken) async {

    Map<String, String> data = {'token': notificationToken};
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorizationToken'
    };

    http.Response response = await http.post(
        Uri.parse('$url/notificacao/cadastro-token'),
        headers: headers,
        body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> getTokenNotificacao(String authorizationToken) async {

    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorizationToken'
    };

    http.Response response = await http.get(
        Uri.parse(url + '/notificacao/regastar-token'),
        headers: headers
    );

    if (response.statusCode == 200) {
      var responseDecode = await jsonDecode(response.body);
      await const FlutterSecureStorage().write(key: 'token_notificacao', value: responseDecode['data']['token']);
      return true;
    }
    return false;
  }

  getProducts() async {
    Uri rota = Uri.parse(url + '/produtos');
    http.Response response = await http.get(rota);

    if (response.statusCode == 200) {
      var teste = await jsonDecode(response.body);
      return teste['data'];
    }
  }

  getManual(id_produto) async {
    String token = await user_vtr.getToken('token');
    Uri rota = Uri.parse(url + '/manuais/?product_id=' + id_produto.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response response = await http.get(rota, headers: header);
    if (response.statusCode == 200) {
      var retorno = await jsonDecode(response.body);
      return retorno['data'].toString();
    }
  }

  getGarantia() async {
    String token = await user_vtr.getToken('token');
    Uri rota = Uri.parse(url + '/garantias/');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response response = await http.get(rota, headers: header);
    if (response.statusCode == 200) {
      var retorno = await jsonDecode(response.body);
      return retorno['data'];
    }
  }

  getProductsUser() async {
    String token = await user_vtr.getToken('token');
    Uri rota = Uri.parse(url + '/auth/produtos');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(rota, headers: header);

    if (response.statusCode == 200) {
      var retorno = await jsonDecode(response.body);
      return retorno['data'];
    }
  }

  registerNotificacao(Map<String, String> data) async{
    http.Response response = await http.post(
        Uri.parse(url + '/notificacao/cadastro-token'),
        headers: headers, body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      return true;
    }
    return false;
  }

  sendProduct(Map<String, String> destiny) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.post(Uri.parse(url + '/transferencia'),
        headers: header, body: jsonEncode(destiny));

    var body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['data'] != null) {
      return true;
    }
    return false;
  }

  getForums() async {
    String token = await user_vtr.getToken('token');
    Uri rota = Uri.parse(url + '/forums');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(rota, headers: header);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return json['data'];
    }

    return null;
  }

  getComents(int id) async {
    String token = await user_vtr.getToken('token');
    Uri rota = Uri.parse(url + '/forums/$id');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(rota, headers: header);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return json['data'];
    }

    return null;
  }

  sendForum(Map<String, String> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.post(Uri.parse(url + '/forums/'),
        headers: header, body: jsonEncode(data));

    var json = jsonDecode(response.body);

    return (json['error'] == null && response.statusCode == 200);
  }

  sendComent(Map<String, dynamic> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.post(
        Uri.parse(url + '/forums/comentarios/'),
        headers: header,
        body: jsonEncode(data));

    var json = jsonDecode(response.body);

    return (json['error'] == null && response.statusCode == 200);
  }

  likeComent(data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.post(
        Uri.parse(url + '/forums/comentarios/like'),
        headers: header,
        body: jsonEncode(data));
  }

  updatePerfil(Map<String, dynamic> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.put(Uri.parse(url + '/perfis'),
        headers: header, body: jsonEncode(data));

    return response.statusCode == 200 ? true : false;
  }

  postImage(String imagepath) async{
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };
    
    var request = http.MultipartRequest('POST', Uri.parse(url + '/perfis/image'))
                   ..headers.addAll(header)
                   ..files.add(await http.MultipartFile.fromPath('image', imagepath));
    var response = await request.send();
    print(response.statusCode);

  }
}