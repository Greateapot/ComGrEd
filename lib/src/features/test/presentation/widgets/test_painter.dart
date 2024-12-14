import 'dart:math' hide Point;

import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/test/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class TestPainter extends CustomPainter {
  TestPainter({
    super.repaint,
    required this.lines,
    required this.selectedLineIds,
    required this.f,
    required this.t,
    required this.z,
    required this.kFlutter,
    required this.version,
  });

  /// lines
  final List<Line> lines;

  /// selected lines ids
  final List<String> selectedLineIds;

  /// angle f (x-rotate)
  final double f;

  /// angle t (y-rotate)
  final double t;

  /// perspective Z
  final double z;

  /// points coordinates to flutter offset coefficient
  final double kFlutter;

  /// repaint flag
  final int version;

  @override
  void paint(Canvas canvas, Size size) {
    /// no points = no lines
    if (lines.isEmpty) return;

    final center = size / 2;
    final paint = Paint()..strokeWidth = 2;
    final trimetricProjectionMatrix = getTrimetricProjectionMatrix(
      f.toRadians(),
      t.toRadians(),
      z,
    );

    for (var line in lines) {
      final firstPointVector = Vector4(
        line.firstPoint.x,
        line.firstPoint.y,
        line.firstPoint.z,
        1,
      );

      firstPointVector.applyMatrix4(trimetricProjectionMatrix);
      firstPointVector.xyzw = firstPointVector / firstPointVector.w;

      final firstPointOffset = Offset(
        firstPointVector.x * kFlutter + center.width,
        firstPointVector.y * -kFlutter + center.height,
      );

      final lastPointVector = Vector4(
        line.lastPoint.x,
        line.lastPoint.y,
        line.lastPoint.z,
        1,
      );

      lastPointVector.applyMatrix4(trimetricProjectionMatrix);
      lastPointVector.xyzw = lastPointVector / lastPointVector.w;

      final lastPointOffset = Offset(
        lastPointVector.x * kFlutter + center.width,
        lastPointVector.y * -kFlutter + center.height,
      );

      paint.color = selectedLineIds.contains(line.id)
          /** FORCE LINE BREAK */
          ? Colors.redAccent
          : Colors.black;

      canvas.drawLine(firstPointOffset, lastPointOffset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant TestPainter oldDelegate) =>
      oldDelegate.lines != lines ||
      oldDelegate.selectedLineIds != selectedLineIds ||
      oldDelegate.f != f ||
      oldDelegate.t != t ||
      oldDelegate.z != z ||
      oldDelegate.kFlutter != kFlutter ||
      oldDelegate.version != version;

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


    // final calculatedPoints = Map.fromEntries(points.map((point) {
    //   final vector = Vector4(point.x, point.y, point.z, 1);
    //   vector.applyMatrix4(trimetricProjectionMatrix);
    //   vector.xyzw = vector / vector.w;

    //   return MapEntry(
    //     point.id,
    //     Offset(
    //       vector.x * kFlutter + center.width,
    //       vector.y * -kFlutter + center.height,
    //     ),
    //   );
    // }));
