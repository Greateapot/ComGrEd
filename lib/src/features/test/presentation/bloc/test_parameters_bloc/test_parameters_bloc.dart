import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_parameters_event.dart';
part 'test_parameters_state.dart';

class TestParametersBloc
    extends Bloc<TestParametersEvent, TestParametersState> {
  TestParametersBloc() : super(TestParametersInitial.defaults()) {
    on<TestParametersSetRotatationEvent>(_onTestParametersSetRotatationEvent);
    on<TestParametersSetZEvent>(_onTestParametersSetZEvent);
    on<TestParametersSetKFlutterEvent>(_onTestParametersSetKFlutterEvent);
    on<TestParametersResetEvent>(_onTestParametersResetEvent);
  }

  void _onTestParametersSetRotatationEvent(
    TestParametersSetRotatationEvent event,
    Emitter<TestParametersState> emit,
  ) {
    final f = event.f ?? state.f;
    final t = event.t ?? state.t;

    assert(f >= 0 && f <= 360);
    assert(t >= 0 && t <= 360);

    emit(state.copyWith(f: event.f, t: event.t, version: state.version + 1));
  }

  void _onTestParametersSetZEvent(
    TestParametersSetZEvent event,
    Emitter<TestParametersState> emit,
  ) {
    assert(event.z >= 0 && event.z <= 1000);

    emit(state.copyWith(z: event.z, version: state.version + 1));
  }

  void _onTestParametersSetKFlutterEvent(
    TestParametersSetKFlutterEvent event,
    Emitter<TestParametersState> emit,
  ) {
    assert(event.kFlutter > 0 && event.kFlutter <= 100);

    emit(state.copyWith(kFlutter: event.kFlutter, version: state.version + 1));
  }

  void _onTestParametersResetEvent(
    TestParametersResetEvent event,
    Emitter<TestParametersState> emit,
  ) {
    emit(TestParametersInitial.defaults(version: state.version + 1));
  }
}
