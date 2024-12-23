import 'package:equatable/equatable.dart';

class TreeRules extends Equatable {
  static const TreeRules defaults = TreeRules(
    rule0: '1{0}1[0]0',
    rule1: '11',
    ruleLCB: '{',
    ruleRCB: '}',
    ruleLSB: '[',
    ruleRSB: ']',
  );

  /// 0 -> ...
  final String rule0;

  /// 1 -> ...
  final String rule1;

  /// { -> ...
  final String ruleLCB;

  /// } -> ...
  final String ruleRCB;

  /// [ -> ...
  final String ruleLSB;

  /// ] -> ...
  final String ruleRSB;

  const TreeRules({
    required this.rule0,
    required this.rule1,
    required this.ruleRCB,
    required this.ruleLSB,
    required this.ruleRSB,
    required this.ruleLCB,
  });

  @override
  List<Object?> get props => [
        rule0,
        rule1,
        ruleLCB,
        ruleRCB,
        ruleLSB,
        ruleRSB,
      ];

  TreeRules copyWith({
    String? rule0,
    String? rule1,
    String? ruleLCB,
    String? ruleRCB,
    String? ruleLSB,
    String? ruleRSB,
  }) =>
      TreeRules(
        rule0: rule0 ?? this.rule0,
        rule1: rule1 ?? this.rule1,
        ruleLCB: ruleLCB ?? this.ruleLCB,
        ruleRCB: ruleRCB ?? this.ruleRCB,
        ruleLSB: ruleLSB ?? this.ruleLSB,
        ruleRSB: ruleRSB ?? this.ruleRSB,
      );
}
