import 'package:flutter/material.dart';
import 'package:app_vtr/data_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

    var user = jsonDecode(response.body);

    return (user['error'] != null && response.statusCode == 200);
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

  deleteForum(int id) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response =
        await http.delete(Uri.parse(url + '/forums/$id'), headers: header);

    print(response.statusCode);
    return (response.statusCode == 200);
  }

  updateForum(int id, Map<String, dynamic> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.put(Uri.parse(url + '/forums/$id'),
        headers: header, body: jsonEncode(data));

    var json = jsonDecode(response.body);
    return (json['error'] == null && response.statusCode == 200);
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

  deleteComent(int id) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http
        .delete(Uri.parse(url + '/forums/comentarios/$id'), headers: header);
    var json = jsonDecode(response.body);
    return (response.statusCode == 200 && json['error'] != null);
  }

  updateComent(int id, Map<String, dynamic> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.put(
        Uri.parse(url + '/forums/comentarios/$id'),
        headers: header,
        body: jsonEncode(data));

    var json = jsonDecode(response.body);
    return (response.statusCode == 200 && json['error'] != null);
  }

  likeComent(data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    await http.post(Uri.parse(url + '/forums/comentarios/like'),
        headers: header, body: jsonEncode(data));
  }

  unlikeComent(Map<String, dynamic> data) async {
    String token = await user_vtr.getToken('token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    await http.delete(Uri.parse(url + '/forums/comentarios/like'),
        headers: header, body: jsonEncode(data));
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
}
