import 'package:flutter/material.dart';
import 'package:app_vtr/login.dart';
import 'package:app_vtr/about/about.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  1 < 3 ? runApp(const Login()) : runApp(const About());
}
