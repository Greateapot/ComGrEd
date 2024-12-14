part of 'test_parameters_bloc.dart';

sealed class TestParametersState extends Equatable {
  /// angle f (x-rotate)
  final double f;

  /// angle t (y-rotate)
  final double t;

  /// perspective Z
  final double z;

  /// points coordinates to flutter offset coefficient
  final double kFlutter;

  /// state version
  final int version;

  const TestParametersState({
    required this.f,
    required this.t,
    required this.z,
    required this.kFlutter,
    required this.version,
  });

  TestParametersState copyWith({
    double? f,
    double? t,
    double? z,
    double? kFlutter,
    int? version,
  });

  @override
  List<Object> get props => [f, t, z, kFlutter, version];
}

final class TestParametersInitial extends TestParametersState {
  const TestParametersInitial({
    required super.f,
    required super.t,
    required super.z,
    required super.kFlutter,
    required super.version,
  });

  factory TestParametersInitial.defaults({
    double? f,
    double? t,
    double? z,
    double? kFlutter,
    int? version,
  }) =>
      TestParametersInitial(
        f: f ?? 0,
        t: t ?? 0,
        z: z ?? 30,
        kFlutter: kFlutter ?? 10,
        version: version ?? -1,
      );

  @override
  TestParametersInitial copyWith({
    double? f,
    double? t,
    double? z,
    double? kFlutter,
    int? version,
  }) =>
      TestParametersInitial(
        f: f ?? this.f,
        t: t ?? this.t,
        z: z ?? this.z,
        kFlutter: kFlutter ?? this.kFlutter,
        version: version ?? this.version,
      );
}
