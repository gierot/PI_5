import 'package:flutter/material.dart';

class Settings {
  var all_colors = {
    'background': const Color(0xFF04121F),
    'color_font': const Color(0xFFbdb113),
  };

  getColor(color) {
    return all_colors[color];
  }
}
