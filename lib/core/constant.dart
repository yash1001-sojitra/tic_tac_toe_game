// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextStyle CustomText(
        {double fontSize = 16.0,
        required Color color,
        FontWeight fontWeight = FontWeight.normal}) =>
    TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
