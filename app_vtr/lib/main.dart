import 'package:flutter/material.dart';
import 'package:app_vtr/login.dart';
import 'package:app_vtr/about/about.dart';
import 'package:app_vtr/data_user.dart';

DataUser data = DataUser();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var token_is_defined = await data.getToken('token');

  if (token_is_defined != null && token_is_defined.isNotEmpty) {
    runApp(const About());
  } else {
    runApp(const Login());
  }
}
