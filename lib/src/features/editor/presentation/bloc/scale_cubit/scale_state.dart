part of 'scale_cubit.dart';

sealed class ScaleState extends Equatable {
  final double x;
  final double y;
  final double z;

  const ScaleState({
    required this.x,
    required this.y,
    required this.z,
  });
  @override
  List<Object> get props => [x, y, z];
}

final class ScaleInitial extends ScaleState {
  const ScaleInitial({
    required super.x,
    required super.y,
    required super.z,
  });
}
