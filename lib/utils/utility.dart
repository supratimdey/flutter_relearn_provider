import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // add full opacity
  }
  return Color(int.parse('0x$hex'));
}
