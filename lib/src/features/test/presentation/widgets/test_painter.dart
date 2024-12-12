import 'dart:math' hide Point;

import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/test/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class TestPainter extends CustomPainter {
  TestPainter({
    super.repaint,
    required this.points,
    required this.lines,
    required this.f,
    required this.t,
    required this.z,
    this.kFlutter = 10,
  });

  /// points
  final List<Point> points;

  /// lines (bind to points with ids)
  final List<Line> lines;

  /// angle f (x-rotate)
  final double f;

  /// angle t (y-rotate)
  final double t;

  /// perspective Z
  final double z;

  /// points coordinates to flutter offset coefficient
  final double kFlutter;

  @override
  void paint(Canvas canvas, Size size) {
    /// no points = no lines
    if (points.isEmpty) return;

    final trimetricProjectionMatrix = getTrimetricProjectionMatrix(
      f.toRadians(),
      t.toRadians(),
      z,
    );

    final center = size / 2;

    final calculatedPoints = Map.fromEntries(points.map((point) {
      final vector = Vector4(point.x, point.y, point.z, 1);
      vector.applyMatrix4(trimetricProjectionMatrix);
      vector.xyzw = vector / vector.w;

      return MapEntry(
        point.id,
        Offset(
          vector.x * kFlutter + center.width,
          vector.y * -kFlutter + center.height,
        ),
      );
    }));

    final paint = Paint()..strokeWidth = 2;

    for (var line in lines) {
      paint.color = line.color;
      canvas.drawLine(
        calculatedPoints[line.firstPointId]!,
        calculatedPoints[line.lastPointId]!,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TestPainter oldDelegate) =>
      oldDelegate.points != points ||
      oldDelegate.lines != lines ||
      oldDelegate.f != f ||
      oldDelegate.t != t ||
      oldDelegate.z != z;

  static Matrix4 getTrimetricProjectionMatrix(double f, double t, double z) {
    assert(z != 0);

    final sinf = sin(f);
    final cosf = cos(f);

    final sint = sin(t);
    final cost = cos(t);

    return Matrix4(
      cosf /**  */, sinf * sint /**  */, 0, sinf * cost / z, //   =
      0 /**     */, cost /**         */, 0, sint / z, //         =
      sinf /**  */, -cosf * sint /** */, 0, -cosf * cost / z, //  =
      0 /**     */, 0 /**            */, 0, 1, //                 =
    );
  }
}
