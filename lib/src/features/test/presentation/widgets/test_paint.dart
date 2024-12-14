import 'package:comgred/src/features/test/presentation/bloc/test_parameters_bloc/test_parameters_bloc.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_project_bloc/test_project_bloc.dart';
import 'package:comgred/src/features/test/presentation/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPaint extends StatelessWidget {
  TestPaint({super.key});

  final FocusNode _focusNode = FocusNode(debugLabel: 'TestPaintFocusNode');

  void setRotation(BuildContext context, double df, double dt) {
    final bloc = context.read<TestParametersBloc>();
    final f = (bloc.state.f + df) % 360;
    final t = (bloc.state.t + dt) % 360;
    bloc.add(TestParametersSetRotatationEvent(f: f, t: t));
  }

  void setZ(BuildContext context, double dz) {
    final bloc = context.read<TestParametersBloc>();
    final z = bloc.state.z + dz / 10;
    if (z < 1 || z > 1000) return;
    bloc.add(TestParametersSetZEvent(z: z));
  }

  void onPointerSignal(BuildContext context, PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    setZ(context, event.scrollDelta.dy);
  }

  void onPanUpdate(BuildContext context, DragUpdateDetails details) {
    setRotation(context, details.delta.dx, details.delta.dy);
  }

  void onKeyEvent(BuildContext context, KeyEvent value) {
    switch (value.physicalKey) {
      case PhysicalKeyboardKey.numpad2:
        setRotation(context, 0, 10);
        break;
      case PhysicalKeyboardKey.numpad8:
        setRotation(context, 0, -10);
        break;
      case PhysicalKeyboardKey.numpad6:
        setRotation(context, 10, 0);
        break;
      case PhysicalKeyboardKey.numpad4:
        setRotation(context, -10, 0);
        break;
      case PhysicalKeyboardKey.numpadAdd:
        setZ(context, -10);
        break;
      case PhysicalKeyboardKey.numpadSubtract:
        setZ(context, 10);
        break;
      case PhysicalKeyboardKey.numpad0:
        context
            .read<TestParametersBloc>()
            .add(const TestParametersResetEvent());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final parametersState = context.watch<TestParametersBloc>().state;
        final projectState = context.watch<TestProjectBloc>().state;

        final MediaQueryData mediaQueryData = MediaQuery.of(context);

        Widget child = CustomPaint(
          size: mediaQueryData.size,
          painter: TestPainter(
            lines: projectState.lines,
            selectedLineIds: projectState.selectedLineIds,
            f: parametersState.f,
            t: parametersState.t,
            z: parametersState.z,
            kFlutter: parametersState.kFlutter,
            version: projectState.version + parametersState.version,
          ),
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
