import 'package:flutter/material.dart';
import 'package:app_vtr/login.dart';
import 'package:app_vtr/about/about.dart';
import 'package:app_vtr/data_user.dart';

DataUser data = DataUser();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  1 < 3 ? runApp(const Login()) : runApp(const About());
}
