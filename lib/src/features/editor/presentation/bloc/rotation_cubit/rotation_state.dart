part of 'rotation_cubit.dart';

sealed class RotationState extends Equatable {
  final double angleX;
  final double angleY;
  final double angleZ;

  final double pointX;
  final double pointY;
  final double pointZ;

  const RotationState({
    required this.angleX,
    required this.angleY,
    required this.angleZ,
    required this.pointX,
    required this.pointY,
    required this.pointZ,
  });

  RotationState copyWith({
    double? angleX,
    double? angleY,
    double? angleZ,
    double? pointX,
    double? pointY,
    double? pointZ,
  });

  @override
  List<Object> get props => [angleX, angleY, angleZ, pointX, pointY, pointZ];
}

final class RotationInitial extends RotationState {
  const RotationInitial({
    required super.angleX,
    required super.angleY,
    required super.angleZ,
    required super.pointX,
    required super.pointY,
    required super.pointZ,
  });

  @override
  RotationInitial copyWith({
    double? angleX,
    double? angleY,
    double? angleZ,
    double? pointX,
    double? pointY,
    double? pointZ,
  }) =>
      RotationInitial(
        angleX: angleX ?? this.angleX,
        angleY: angleY ?? this.angleY,
        angleZ: angleZ ?? this.angleZ,
        pointX: pointX ?? this.pointX,
        pointY: pointY ?? this.pointY,
        pointZ: pointZ ?? this.pointZ,
      );
}
