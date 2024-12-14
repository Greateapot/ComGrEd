// import 'package:comgred/src/core/json_converters/color_converter.dart';
// import 'package:flutter/material.dart' show Color, Colors;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'point.dart';

part 'line.g.dart';

@JsonSerializable()
// @ColorConverter()
class Line extends Equatable {
  final Point firstPoint;
  final Point lastPoint;
  // final Color color;
  // final double width;

  const Line({
    required this.firstPoint,
    required this.lastPoint,
    // this.color = Colors.black,
    // this.width = 2,
  });

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  List<Object?> get props => [firstPoint, lastPoint];

  @JsonKey(includeToJson: false, includeFromJson: false)
  String get id => 'Line#$hashCode';
}
