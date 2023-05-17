import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Settings {
  String url = 'http://0.0.0.0:8000';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  var all_colors = {
    'background': const Color(0xFF04121F),
    'color_font': const Color(0xFFbdb113),
    'green_btn': const Color(0xFF31B425)
  };

  getColor(color) {
    return all_colors[color];
  }

  getAccountData(data) {
    return true;
  }

  registerUser(Map<String, String> data) async {
    http.Response response = await http.post(Uri.parse(url + '/register'),
        headers: headers, body: jsonEncode(data));
  }
}
