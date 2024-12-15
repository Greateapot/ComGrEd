part of 'global_cubit.dart';

enum GlobalMode implements Equatable {
  twoDimensional('2D'),
  threeDimensional('3D');

  const GlobalMode(this.title);

  final String title;

  @override
  List<Object?> get props => [title];

  @override
  bool? get stringify => false;
}

sealed class GlobalState extends Equatable {
  final double angleX;
  final double angleY;
  final double distance;
  final double scale;

  final GlobalMode mode;

  const GlobalState({
    required this.angleX,
    required this.angleY,
    required this.distance,
    required this.scale,
    required this.mode,
  });

  GlobalState copyWith({
    double? angleX,
    double? angleY,
    double? distance,
    double? scale,
    GlobalMode? mode,
  });

  @override
  List<Object> get props => [angleX, angleY, distance, scale, mode];
}

final class GlobalInitial extends GlobalState {
  const GlobalInitial({
    required super.angleX,
    required super.angleY,
    required super.distance,
    required super.scale,
    required super.mode,
  });

  @override
  GlobalInitial copyWith({
    double? angleX,
    double? angleY,
    double? distance,
    double? scale,
    GlobalMode? mode,
  }) =>
      GlobalInitial(
        angleX: angleX ?? this.angleX,
        angleY: angleY ?? this.angleY,
        distance: distance ?? this.distance,
        scale: scale ?? this.scale,
        mode: mode ?? this.mode,
      );
}
