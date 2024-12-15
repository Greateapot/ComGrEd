part of 'mirror_cubit.dart';

sealed class MirrorState extends Equatable {
  final bool x;
  final bool y;
  final bool z;

  const MirrorState({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object> get props => [x, y, z];
}

final class MirrorInitial extends MirrorState {
  const MirrorInitial({
    required super.x,
    required super.y,
    required super.z,
  });
}
