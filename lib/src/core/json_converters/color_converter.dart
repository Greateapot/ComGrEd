import 'package:comgred/src/core/errors/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter extends JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) {
    var i = 0;

    if (json.startsWith('#') == true) {
      json = json.substring(1);
    }

    if (json.length == 3) {
      json = json.substring(0, 1) +
          json.substring(0, 1) +
          json.substring(1, 2) +
          json.substring(1, 2) +
          json.substring(2, 3) +
          json.substring(2, 3);
    }

    if (json.length == 6 || json.length == 8) {
      i = int.parse(json, radix: 16);

      if (json.length != 8) {
        i = 0xff000000 + i;
      }

      return Color(i);
    }

    throw ColorConverterInvalidValueException('ivalid value $json');
  }

  @override
  String toJson(Color object) =>
      '#${object.value.toRadixString(16).padLeft(8, '0')}';
}
