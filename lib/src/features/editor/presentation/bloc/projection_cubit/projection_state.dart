part of 'projection_cubit.dart';

sealed class ProjectionState extends Equatable {
  final double p;
  final double q;
  final double r;

  const ProjectionState({
    required this.p,
    required this.q,
    required this.r,
  });

  @override
  List<Object> get props => [p, q, r];
}

final class ProjectionInitial extends ProjectionState {
  const ProjectionInitial({
    required super.p,
    required super.q,
    required super.r,
  });
}
