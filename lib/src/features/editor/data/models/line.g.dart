// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Line _$LineFromJson(Map<String, dynamic> json) => Line(
      firstPoint: Point.fromJson(json['firstPoint'] as Map<String, dynamic>),
      lastPoint: Point.fromJson(json['lastPoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LineToJson(Line instance) => <String, dynamic>{
      'firstPoint': instance.firstPoint,
      'lastPoint': instance.lastPoint,
    };
