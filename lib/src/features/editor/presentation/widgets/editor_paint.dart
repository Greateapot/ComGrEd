import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:comgred/src/features/editor/presentation/bloc/bloc.dart';
import 'package:comgred/src/features/editor/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class EditorPaint extends StatefulWidget {
  const EditorPaint({super.key});

  @override
  State<EditorPaint> createState() => _EditorPaintState();
}

class _EditorPaintState extends State<EditorPaint> {
  late final FocusNode _focusNode;
  final double onKeyEventStep = 5;

  final List<Line> _backgroundLines2 = <Line>[
    Line(
      firstPoint: Point(x: -10000, y: 0, z: 0),
      lastPoint: Point(x: 10000, y: 0, z: 0),
      color: Colors.redAccent,
    ),
    Line(
      firstPoint: Point(x: 0, y: -10000, z: 0),
      lastPoint: Point(x: 0, y: 10000, z: 0),
      color: Colors.greenAccent,
    ),
  ];

  final List<Line> _backgroundLines3 = <Line>[
    Line(
      firstPoint: Point(x: -10000, y: 0, z: 0),
      lastPoint: Point(x: 10000, y: 0, z: 0),
      color: Colors.redAccent,
    ),
    Line(
      firstPoint: Point(x: 0, y: -10000, z: 0),
      lastPoint: Point(x: 0, y: 10000, z: 0),
      color: Colors.greenAccent,
    ),
    Line(
      firstPoint: Point(x: 0, y: 0, z: -10000),
      lastPoint: Point(x: 0, y: 0, z: 10000),
      color: Colors.blueAccent,
    ),
  ];

  void setRotation(BuildContext context, double deltaX, double deltaY) {
    final GlobalCubit globalCubit = context.read<GlobalCubit>();
    final angleY = (globalCubit.state.angleY + deltaX) % 360;
    final angleX = (globalCubit.state.angleX + deltaY) % 360;
    globalCubit.updateAngles(
      angleX: angleX,
      angleY: angleY,
    );
  }

  void setScale(BuildContext context, double delta) {
    final GlobalCubit globalCubit = context.read<GlobalCubit>();
    final scale = globalCubit.state.scale + delta;
    if (scale < 1 || scale >= 1000) return;
    globalCubit.updateScale(scale);
  }

  void setDistance(BuildContext context, double delta) {
    final GlobalCubit globalCubit = context.read<GlobalCubit>();
    final distance = globalCubit.state.distance + delta / 10;
    if (distance <= 0 || distance > 100) return;
    globalCubit.updateDistance(distance);
  }

  void onPointerSignal(BuildContext context, PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    setScale(context, event.scrollDelta.dy / 10);
  }

  void onPanUpdate(BuildContext context, DragUpdateDetails details) {
    setRotation(context, details.delta.dx, details.delta.dy);
  }

  void onKeyEvent(BuildContext context, KeyEvent value) {
    switch (value.physicalKey) {
      case PhysicalKeyboardKey.numpad2:
        setRotation(context, 0, onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpad8:
        setRotation(context, 0, -onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpad6:
        setRotation(context, onKeyEventStep, 0);
        break;
      case PhysicalKeyboardKey.numpad4:
        setRotation(context, -onKeyEventStep, 0);
        break;
      case PhysicalKeyboardKey.numpadAdd:
        setDistance(context, onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpadSubtract:
        setDistance(context, -onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpadMultiply:
        setScale(context, onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpadDivide:
        setScale(context, -onKeyEventStep);
        break;
      case PhysicalKeyboardKey.numpad0:
        context.read<GlobalCubit>().resetChanges();
        break;
    }
  }

  @override
  void initState() {
    _focusNode = FocusNode(debugLabel: 'TestPaintFocusNode');
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Builder(builder: builder);

  Widget builder(BuildContext context) {
    final projectState = context.watch<ProjectBloc>().state;
    final globalState = context.watch<GlobalCubit>().state;

    final matrix = globalState.mode == GlobalMode.threeDimensional
        ? EditorPainterMatrices.getComplexMatrix3(
            globalState.angleY.toRadians(),
            globalState.angleX.toRadians(),
            globalState.scale,
            globalState.distance,
          )
        : EditorPainterMatrices.getComplexMatrix2(
            globalState.angleX.toRadians(),
            globalState.scale,
          );

    final backgroundLines = globalState.mode == GlobalMode.threeDimensional
        ? _backgroundLines3
        : _backgroundLines2;

    Widget child = CustomPaint(
      size: MediaQuery.sizeOf(context),
      foregroundPainter: EditorPainter(
        lines: projectState.lines,
        group: projectState.group,
        matrix: matrix,
        version: projectState.version,
      ),
      painter: globalState.showBackgroundLines
          ? EditorPainter(
              lines: backgroundLines,
              matrix: matrix,
              version: projectState.version,
            )
          : null,
    );

    /// maybe flags?
    if (true) child = withKeyEvents(context, child);
    if (true) child = withPointerSignal(context, child);
    if (true) child = withPanUpdate(context, child);
    return child;
  }

  Widget withPanUpdate(BuildContext context, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanUpdate: (details) => onPanUpdate(context, details),
      onTap: () => _focusNode.requestFocus(),
      child: child,
    );
  }

  Widget withPointerSignal(BuildContext context, Widget child) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerSignal: (event) => onPointerSignal(context, event),
      child: child,
    );
  }

  Widget withKeyEvents(BuildContext context, Widget child) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (value) => onKeyEvent(context, value),
      child: child,
    );
  }
}
