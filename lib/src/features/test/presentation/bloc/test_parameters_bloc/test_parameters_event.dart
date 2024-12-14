part of 'test_parameters_bloc.dart';

sealed class TestParametersEvent extends Equatable {
  const TestParametersEvent();

  @override
  List<Object?> get props => [];
}

final class TestParametersSetRotatationEvent extends TestParametersEvent {
  final double? f;
  final double? t;

  const TestParametersSetRotatationEvent({this.f, this.t});

  @override
  List<Object?> get props => [f, t];
}

final class TestParametersSetZEvent extends TestParametersEvent {
  final double z;

  const TestParametersSetZEvent({required this.z});

  @override
  List<Object?> get props => [z];
}

final class TestParametersSetKFlutterEvent extends TestParametersEvent {
  final double kFlutter;

  const TestParametersSetKFlutterEvent({required this.kFlutter});

  @override
  List<Object?> get props => [kFlutter];
}

final class TestParametersResetEvent extends TestParametersEvent {
  const TestParametersResetEvent();

  @override
  List<Object?> get props => [];
}
