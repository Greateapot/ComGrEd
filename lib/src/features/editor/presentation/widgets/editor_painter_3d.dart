import 'dart:math' hide Point;

import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class EditorPainter3D extends CustomPainter {
  EditorPainter3D({
    super.repaint,
    required this.lines,
    required this.group,
    required this.angleY,
    required this.angleX,
    required this.scale,
    required this.distance,
    required this.version,
  });

  /// lines
  final List<Line> lines;

  /// selected lines (group)
  final List<Line> group;

  /// angle x (x-rotate)
  final double angleX;

  /// angle y (y-rotate)
  final double angleY;

  /// spectator distance (z)
  final double distance;

  /// scale
  final double scale;

  /// repaint flag
  final int version;

  @override
  void paint(Canvas canvas, Size size) {
    /// no lines = no draw
    if (lines.isEmpty) return;

    final center = size / 2;

    final paint = Paint()..strokeWidth = 2;

    final matrix = getComplexMatrix(
      angleY.toRadians(),
      angleX.toRadians(),
      scale,
      distance,
    );

    for (var line in lines) {
      final firstPointVector = Vector4(
        line.firstPoint.x,
        line.firstPoint.y,
        line.firstPoint.z,
        1,
      );

      firstPointVector.applyMatrix4(matrix);
      firstPointVector.xyzw = firstPointVector / firstPointVector.w;

      final firstPointOffset = Offset(
        firstPointVector.x + center.width,
        -firstPointVector.y + center.height,
      );

      final lastPointVector = Vector4(
        line.lastPoint.x,
        line.lastPoint.y,
        line.lastPoint.z,
        1,
      );

      lastPointVector.applyMatrix4(matrix);
      lastPointVector.xyzw = lastPointVector / lastPointVector.w;

      final lastPointOffset = Offset(
        lastPointVector.x + center.width,
        -lastPointVector.y + center.height,
      );

      paint.color = group.contains(line) ? Colors.redAccent : Colors.black;

      canvas.drawLine(firstPointOffset, lastPointOffset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant EditorPainter3D oldDelegate) =>
      oldDelegate.lines != lines ||
      oldDelegate.angleY != angleY ||
      oldDelegate.angleX != angleX ||
      oldDelegate.distance != distance ||
      oldDelegate.scale != scale ||
      oldDelegate.version != version;

  static Matrix4 getComplexMatrix(
    double angleY,
    double angleX,
    double scale,
    double distance,
  ) {
    assert(distance != 0);

    final cosX = cos(angleX);
    final sinX = sin(angleX);

    final sinY = sin(angleY);
    final cosY = cos(angleY);

    return Matrix4(
      cosY, sinY * sinX, 0, (sinY * cosX) / scale, //
      0, cosX, 0, -sinX / scale, //
      sinY, -cosY * sinX, 0, (-cosY * cosX) / scale, //
      0, 0, 0, distance / scale, //
    );
  }
}
