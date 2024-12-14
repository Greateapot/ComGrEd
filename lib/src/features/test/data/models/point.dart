import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point.g.dart';

@JsonSerializable()
class Point extends Equatable {
  final double x;
  final double y;
  final double z;

  const Point({
    required this.x,
    required this.y,
    required this.z,
  });

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  List<Object?> get props => [x, y, z];

  @JsonKey(includeToJson: false, includeFromJson: false)
  String get id => 'Point#$hashCode';
}
