import 'dart:math' hide Point;

import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class EditorPainter extends CustomPainter {
  EditorPainter({
    super.repaint,
    required this.lines,
    required this.matrix,
    required this.version,
    this.group,
    this.linesColor = Colors.black,
    this.groupColor = Colors.yellowAccent,
    this.strokeWidth = 2,
  });

  /// lines
  final List<Line> lines;

  /// selected lines (group)
  final List<Line>? group;

  /// matrix
  final Matrix4 matrix;

  /// repaint flag
  final int version;

  final Color linesColor;

  final Color groupColor;

  final double strokeWidth;

  @override
  bool shouldRepaint(covariant EditorPainter oldDelegate) =>
      oldDelegate.version != version ||
      oldDelegate.matrix != matrix ||
      oldDelegate.linesColor != linesColor ||
      oldDelegate.groupColor != groupColor ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.group != group ||
      oldDelegate.lines != lines;

  @override
  void paint(Canvas canvas, Size size) {
    /// no lines = no draw
    if (lines.isEmpty) return;

    final center = size / 2;

    final paint = Paint()..strokeWidth = strokeWidth;

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

      final firstPointX =
          center.width + firstPointVector.x / firstPointVector.w;
      final firstPointY =
          center.height - firstPointVector.y / firstPointVector.w;

      final lastPointX = center.width + lastPointVector.x / lastPointVector.w;
      final lastPointY = center.height - lastPointVector.y / lastPointVector.w;

      late final Offset firstPointOffset;
      late final Offset lastPointOffset;

      /// Если обе точки за границами экрана, то ничего не рисовать
      if ((firstPointX > size.width || firstPointX < 0) &&
          (firstPointY > size.width || firstPointY < 0) &&
          (lastPointX > size.width || lastPointX < 0) &&
          (lastPointY > size.width || lastPointY < 0)) {
        continue;
      }

      /// Если обе точки находятся в одном месте, то ничего не рисовать
      else if (firstPointX == lastPointX && firstPointY == lastPointY) {
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
        firstPointOffset = calculatePointOffset(
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
        lastPointOffset = calculatePointOffset(
          lastPointX,
          lastPointY,
          firstPointX,
          firstPointY,
          size,
        );
      }

      paint.color = group != null && group!.contains(line)
          ? groupColor
          : line.color ?? linesColor;

      canvas.drawLine(firstPointOffset, lastPointOffset, paint);
    }
  }

  Offset calculatePointOffset(
    double firstPointX,
    double firstPointY,
    double lastPointX,
    double lastPointY,
    Size size,
  ) {
    final double wallX = lastPointX - firstPointX < 0 ? 0 : size.width;
    final double wallY = lastPointY - firstPointY < 0 ? 0 : size.height;

    double ytox = (wallX * lastPointY -
            wallX * firstPointY -
            firstPointX * lastPointY +
            firstPointY * lastPointX) /
        (lastPointX - firstPointX);
    double xtoy = (wallY * firstPointX -
            wallY * lastPointX -
            firstPointX * lastPointY +
            firstPointY * lastPointX) /
        (firstPointY - lastPointY);

    if (ytox > 0 && ytox < size.height) {
      xtoy = wallX;
    } else {
      ytox = wallY;
    }

    return Offset(xtoy, ytox);
  }
}

sealed class EditorPainterMatrices {
  static Matrix4 getComplexMatrix2(
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

  static Matrix4 getComplexMatrix3(
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
