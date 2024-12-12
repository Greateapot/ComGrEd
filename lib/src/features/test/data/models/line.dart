import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color, Colors;

class Line extends Equatable {
  final String firstPointId;
  final String lastPointId;
  final Color color;

  const Line({
    required this.firstPointId,
    required this.lastPointId,
    this.color = Colors.black,
  });

  @override
  List<Object?> get props => [firstPointId, lastPointId, color];
}
