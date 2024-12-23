import 'dart:math';

import 'package:comgred/src/core/utils/stack.dart';
import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:flutter/material.dart' hide Stack;

class TreePainter extends CustomPainter {
  const TreePainter({
    required this.parameters,
    required this.version,
    this.onError,
  });

  final TreeParameters parameters;
  final int version;
  final void Function(String message)? onError;

  static num deg2rad(num value) => value * pi / 180;

  String generateInstructions() {
    String instructions = parameters.axiom;
    for (var i = 0; i < parameters.iterationsCount; i++) {
      String temp = '';
      for (var instruction in instructions.characters) {
        switch (instruction) {
          case '0':
            temp += parameters.rules.rule0;
            break;
          case '1':
            temp += parameters.rules.rule1;
            break;
          case '{':
            temp += parameters.rules.ruleLCB;
            break;
          case '}':
            temp += parameters.rules.ruleRCB;
            break;
          case '[':
            temp += parameters.rules.ruleLSB;
            break;
          case ']':
            temp += parameters.rules.ruleRSB;
            break;
          default:
            onError!('Unexpected instruction "$instruction"');
        }
      }
      instructions = temp;
    }
    return instructions;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random(parameters.randomSeed);

    final trunkPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final leafPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final instructions = generateInstructions();
    final Stack<(Offset, num)> stack = Stack<(Offset, num)>();

    Offset point = Offset(size.width * 0.5, size.height);
    num angle = 0;

    for (var instruction in instructions.characters) {
      switch (instruction) {
        case '0':
          var nextPoint = Offset(
            point.dx + parameters.trunkChunkHeight * cos(angle - pi / 2),
            point.dy + parameters.trunkChunkHeight * sin(angle - pi / 2),
          );
          var leafPoint = Offset(
            nextPoint.dx + parameters.leafHeight * cos(angle - pi / 2),
            nextPoint.dy + parameters.leafHeight * sin(angle - pi / 2),
          );
          canvas.drawLine(point, nextPoint, trunkPaint);
          drawLeaf(canvas, leafPaint, nextPoint, leafPoint, angle);
          break;
        case '1':
          var nextPoint = Offset(
            point.dx + parameters.trunkChunkHeight * cos(angle - pi / 2),
            point.dy + parameters.trunkChunkHeight * sin(angle - pi / 2),
          );
          canvas.drawLine(point, nextPoint, trunkPaint);
          point = nextPoint;
          break;
        case '{':
          stack.push((point, angle));
          angle -= deg2rad(parameters.angle) + random.nextDouble() * 0.3 - 0.15;
          break;
        case '[':
          stack.push((point, angle));
          angle += deg2rad(parameters.angle) + random.nextDouble() * 0.3 - 0.15;
          break;
        case '}':
          (point, angle) = stack.pop();
          break;
        case ']':
          (point, angle) = stack.pop();
          break;
        default:
          if (onError != null) {
            onError!('Unexpected instruction "$instruction"');
          }
          return;
      }
    }
  }

  void drawLeaf(Canvas canvas, Paint paint, Offset p1, Offset p2, num angle) {
    final pr = Offset(
      (p1.dx + p2.dx) * .5 + parameters.leafWidth * .5 * cos(angle),
      (p1.dy + p2.dy) * .5 + parameters.leafWidth * .5 * sin(angle),
    );
    final pl = Offset(
      (p1.dx + p2.dx) * .5 - parameters.leafWidth * .5 * cos(angle),
      (p1.dy + p2.dy) * .5 - parameters.leafWidth * .5 * sin(angle),
    );

    final path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(pr.dx, pr.dy, p2.dx, p2.dy);
    path.quadraticBezierTo(pl.dx, pl.dy, p1.dx, p1.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) =>
      oldDelegate.version != version;
}
