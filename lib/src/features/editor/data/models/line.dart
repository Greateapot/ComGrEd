import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'point.dart';

part 'line.g.dart';

@JsonSerializable()
class Line {
  Point firstPoint;
  Point lastPoint;

  @JsonKey(includeToJson: false, includeFromJson: false)
  Color? color;

  Line({
    required this.firstPoint,
    required this.lastPoint,
    this.color,
  });

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}
