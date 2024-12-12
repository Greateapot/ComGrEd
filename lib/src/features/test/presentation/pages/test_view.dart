import 'package:comgred/src/features/test/data/models/models.dart';
import 'package:comgred/src/features/test/presentation/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  /// O-points (always exists | hideable)
  late final List<Point> points = [
    const Point(id: 'O', x: 0, y: 0, z: 0),
    const Point(id: 'Ox10', x: 10, y: 0, z: 0),
    const Point(id: 'Oy10', x: 0, y: 10, z: 0),
    const Point(id: 'Oz10', x: 0, y: 0, z: 10),
  ];

  /// O-lines (always exists | hideable)
  late final List<Line> lines = [
    const Line(firstPointId: 'O', lastPointId: 'Ox10', color: Colors.red),
    const Line(firstPointId: 'O', lastPointId: 'Oy10', color: Colors.green),
    const Line(firstPointId: 'O', lastPointId: 'Oz10', color: Colors.blue),
  ];

  /// Points
  late final List<Point> foregroundPoints = [
    const Point(id: 'A', x: 0, y: 0, z: 4),
    const Point(id: 'B', x: 4, y: 0, z: 4),
    const Point(id: 'C', x: 4, y: 0, z: 0),
    const Point(id: 'D', x: 0, y: 0, z: 0),
    const Point(id: 'E', x: 0, y: 3, z: 4),
    const Point(id: 'F', x: 4, y: 3, z: 4),
    const Point(id: 'G', x: 4, y: 3, z: 0),
    const Point(id: 'H', x: 0, y: 3, z: 0),
  ];

  /// Lines
  late final List<Line> foregroundLines = [
    const Line(firstPointId: 'A', lastPointId: 'B'), // AB
    const Line(firstPointId: 'B', lastPointId: 'C'), // BC
    const Line(firstPointId: 'C', lastPointId: 'D'), // CD
    const Line(firstPointId: 'D', lastPointId: 'A'), // DA

    const Line(firstPointId: 'E', lastPointId: 'F'), // EF
    const Line(firstPointId: 'F', lastPointId: 'G'), // FG
    const Line(firstPointId: 'G', lastPointId: 'H'), // GH
    const Line(firstPointId: 'H', lastPointId: 'E'), // HE

    const Line(firstPointId: 'A', lastPointId: 'E'), // EA
    const Line(firstPointId: 'B', lastPointId: 'F'), // FB
    const Line(firstPointId: 'C', lastPointId: 'G'), // GC
    const Line(firstPointId: 'D', lastPointId: 'H'), // HD
  ];

  final double minz = 1;
  final double maxz = 10000;

  final double basef = -45;
  final double baset = 45;
  final double basez = 30;

  late double f = basef;
  late double t = baset;
  late double z = basez;

  void onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // print(event);
      setState(() {
        final z = this.z + event.scrollDelta.dy / 100;
        if (z < minz || z > maxz) return;
        this.z = z;
        // print('update z: $z');
      });
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    // print(details);
    setState(() {
      t = (t + details.delta.dy) % 360;
      f = (f + details.delta.dx) % 360;
      // print('update t: $t; f: $f');
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Listener(
      onPointerSignal: onPointerSignal,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Scaffold(
          body: RepaintBoundary(
            child: CustomPaint(
              size: mediaQueryData.size,
              foregroundPainter: TestPainter(
                points: foregroundPoints,
                lines: foregroundLines,
                f: f,
                t: t,
                z: z,
              ),
              painter: TestPainter(
                points: points,
                lines: lines,
                f: basef,
                t: baset,
                z: basez,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
