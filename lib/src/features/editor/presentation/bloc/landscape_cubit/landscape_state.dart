part of 'landscape_cubit.dart';

sealed class LandscapeState extends Equatable {
  final int depth;
  final double randomness;
  final double squareSize;

  const LandscapeState({
    required this.depth,
    required this.randomness,
    required this.squareSize,
  });

  LandscapeState copyWith({
    int? depth,
    double? randomness,
    double? squareSize,
  });

  @override
  List<Object> get props => [depth, randomness, squareSize];
}

final class LandscapeInitial extends LandscapeState {
  const LandscapeInitial({
    required super.depth,
    required super.randomness,
    required super.squareSize,
  });

  @override
  LandscapeInitial copyWith({
    int? depth,
    double? randomness,
    double? squareSize,
  }) =>
      LandscapeInitial(
        depth: depth ?? this.depth,
        randomness: randomness ?? this.randomness,
        squareSize: squareSize ?? this.squareSize,
      );
}
