import 'dart:math' hide Point;

import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class EditorPainter3D extends CustomPainter {
  EditorPainter3D({
    super.repaint,
    required this.lines,
    this.group,
    required this.angleY,
    required this.angleX,
    required this.scale,
    required this.distance,
    required this.version,
  });

  /// lines
  final List<Line> lines;

  /// selected lines (group)
  final List<Line>? group;

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
      final lastPointVector = Vector4(
        line.lastPoint.x,
        line.lastPoint.y,
        line.lastPoint.z,
        1,
      );

      firstPointVector.applyMatrix4(matrix);
      lastPointVector.applyMatrix4(matrix);

      var firstPointX = center.width + firstPointVector.x / firstPointVector.w;
      var firstPointY = center.height - firstPointVector.y / firstPointVector.w;

      var lastPointX = center.width + lastPointVector.x / lastPointVector.w;
      var lastPointY = center.height - lastPointVector.y / lastPointVector.w;

      late final Offset firstPointOffset;
      late final Offset lastPointOffset;

      /// Если обе точки за границами экрана, то ничего не рисовать
      if ((firstPointX > size.width || firstPointX < 0) &&
          (firstPointY > size.width || firstPointY < 0) &&
          (lastPointX > size.width || lastPointX < 0) &&
          (lastPointY > size.width || lastPointY < 0)) {
        continue;
      }

      /// Если обе точки за камерой, то ничего не рисовать
      else if (firstPointVector.w < 0 && lastPointVector.w < 0) {
        continue;
      }

      /// Если обе точки перед камерой, то провести линию между точками
      else if (firstPointVector.w > 0 && lastPointVector.w > 0) {
        firstPointOffset = Offset(firstPointX, firstPointY);
        lastPointOffset = Offset(lastPointX, lastPointY);
      }

      /// Если первая точка за камерой, то провести линию от второй
      /// точки до границы экрана так, чтобы линия уходила в точку схода
      else if (firstPointVector.w < 0 && lastPointVector.w > 0) {
        firstPointOffset = recalculateCoordinates(
          firstPointX,
          firstPointY,
          lastPointX,
          lastPointY,
          size,
        );
        lastPointOffset = Offset(lastPointX, lastPointY);
      }

      /// Если вторая точка за камерой, то провести линию от первой
      /// точки до границы экрана так, чтобы линия уходила в точку сход
      else if (firstPointVector.w > 0 && lastPointVector.w < 0) {
        firstPointOffset = Offset(firstPointX, firstPointY);
        lastPointOffset = recalculateCoordinates(
          lastPointX,
          lastPointY,
          firstPointX,
          firstPointY,
          size,
        );
      }

      paint.color = group != null && group!.contains(line)
          ? Colors.yellowAccent
          : line.color ?? Colors.black;

      canvas.drawLine(firstPointOffset, lastPointOffset, paint);
    }
  }

  Offset recalculateCoordinates(
    double x1,
    double y1,
    double x2,
    double y2,
    Size size,
  ) {
    final double wallX = x2 - x1 < 0 ? 0 : size.width;
    final double wallY = y2 - y1 < 0 ? 0 : size.height;
    double ytox = (wallX * y2 - wallX * y1 - x1 * y2 + y1 * x2) / (x2 - x1);
    double xtoy = (wallY * x1 - wallY * x2 - x1 * y2 + y1 * x2) / (y1 - y2);

    if (ytox > 0 && ytox < size.height) {
      xtoy = wallX;
    } else {
      ytox = wallY;
    }

    return Offset(xtoy, ytox);
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
