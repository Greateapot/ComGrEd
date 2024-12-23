import 'package:equatable/equatable.dart';

import 'tree_rules.dart';

class TreeParameters extends Equatable {
  static const TreeParameters defaults = TreeParameters(
    axiom: '0',
    rules: TreeRules.defaults,
    randomSeed: 0xE630B2,
    iterationsCount: 5,
    trunkChunkHeight: 10,
    leafHeight: 20,
    leafWidth: 20,
    angle: 45,
  );

  const TreeParameters({
    required this.axiom,
    required this.rules,
    required this.randomSeed,
    required this.iterationsCount,
    required this.trunkChunkHeight,
    required this.leafHeight,
    required this.leafWidth,
    required this.angle,
  });

  final String axiom;
  final TreeRules rules;
  final int randomSeed;
  final int iterationsCount;
  final num trunkChunkHeight;
  final num leafHeight;
  final num leafWidth;
  final num angle;

  @override
  List<Object?> get props => [
        axiom,
        rules,
        randomSeed,
        iterationsCount,
        trunkChunkHeight,
        leafHeight,
        leafWidth,
        angle,
      ];

  TreeParameters copyWith({
    String? axiom,
    TreeRules? rules,
    int? randomSeed,
    int? iterationsCount,
    num? trunkChunkHeight,
    num? leafHeight,
    num? leafWidth,
    num? angle,
  }) =>
      TreeParameters(
        axiom: axiom ?? this.axiom,
        rules: rules ?? this.rules,
        randomSeed: randomSeed ?? this.randomSeed,
        iterationsCount: iterationsCount ?? this.iterationsCount,
        trunkChunkHeight: trunkChunkHeight ?? this.trunkChunkHeight,
        leafHeight: leafHeight ?? this.leafHeight,
        leafWidth: leafWidth ?? this.leafWidth,
        angle: angle ?? this.angle,
      );
}
