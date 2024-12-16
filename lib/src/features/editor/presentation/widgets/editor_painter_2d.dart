import 'dart:math' hide Point;

import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class EditorPainter2D extends CustomPainter {
  EditorPainter2D({
    super.repaint,
    required this.lines,
    this.group,
    required this.angle,
    required this.scale,
    required this.version,
  });

  /// lines
  final List<Line> lines;

  /// selected lines (group)
  final List<Line>? group;

  /// angle (rotate)
  final double angle;

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

    final matrix = getComplexMatrix(angle.toRadians(), scale);

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

      paint.color = group != null && group!.contains(line)
          ? Colors.yellowAccent
          : line.color ?? Colors.black;

      canvas.drawLine(firstPointOffset, lastPointOffset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant EditorPainter2D oldDelegate) =>
      oldDelegate.lines != lines ||
      oldDelegate.angle != angle ||
      oldDelegate.scale != scale ||
      oldDelegate.version != version;

  static Matrix4 getComplexMatrix(
    double angle,
    double scale,
  ) {
    final cosA = cos(angle);
    final sinA = sin(angle);

    return Matrix4(
      cosA, sinA, 0, 0, //
      -sinA, cosA, 0, 0, //
      0, 0, 0, 0, //
      0, 0, 0, 1 / scale, //
    );
  }
}
