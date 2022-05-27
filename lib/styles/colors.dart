import 'package:flutter/material.dart';

final Color lprimaryColor =  HexColor("#003399");
final Color lsecondaryColor = HexColor("#00297A");
final Color lbasicDarkColor =  HexColor("#222B45");
final Color lbasicGreyColor =  HexColor("#8F9BB3");
final Color lbackgroundColor =  HexColor("#F7F9FC");

final Color dprimaryColor = HexColor("#003399");
final Color dsecondaryColor = HexColor("#00297A");
final Color dbasicDarkColor =  HexColor("#222B45");
final Color dbasicGreyColor =  HexColor("#8F9BB3");
final Color dbackgroundColor =  HexColor("#222B45");

final Color facebookColor =  HexColor("#3B5998");

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}