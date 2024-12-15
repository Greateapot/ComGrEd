import 'package:json_annotation/json_annotation.dart';

import 'point.dart';

part 'line.g.dart';

@JsonSerializable()
class Line {
  Point firstPoint;
  Point lastPoint;

  Line({
    required this.firstPoint,
    required this.lastPoint,
  });

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}
