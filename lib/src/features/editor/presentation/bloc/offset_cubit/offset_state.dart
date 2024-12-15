part of 'offset_cubit.dart';

sealed class OffsetState extends Equatable {
  final double x;
  final double y;
  final double z;

  const OffsetState({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object> get props => [x, y, z];
}

final class OffsetInitial extends OffsetState {
  const OffsetInitial({
    required super.x,
    required super.y,
    required super.z,
  });
}
