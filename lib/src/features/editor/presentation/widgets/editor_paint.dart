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
    setScale(context, event.scrollDelta.dy);
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
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final ProjectState projectState = context.watch<ProjectBloc>().state;
        final GlobalState globalState = context.watch<GlobalCubit>().state;

        final CustomPainter painter;

        if (globalState.mode == GlobalMode.threeDimensional) {
          painter = EditorPainter3D(
            lines: projectState.lines,
            group: projectState.group,
            angleX: globalState.angleX,
            angleY: globalState.angleY,
            scale: globalState.scale,
            distance: globalState.distance,
            version: projectState.version,
          );
        } else {
          painter = EditorPainter2D(
            lines: projectState.lines,
            group: projectState.group,
            angle: globalState.angleX,
            scale: globalState.scale,
            version: projectState.version,
          );
        }

        final MediaQueryData mediaQueryData = MediaQuery.of(context);

        Widget child = CustomPaint(
          size: mediaQueryData.size,
          painter: painter,
        );

        if (true) child = withKeyEvents(context, child);
        if (true) child = withPointerSignal(context, child);
        if (true) child = withPanUpdate(context, child);
        return child;
      },
    );
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
