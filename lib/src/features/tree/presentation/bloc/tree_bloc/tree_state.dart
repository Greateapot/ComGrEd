part of 'tree_bloc.dart';

sealed class TreeState extends Equatable {
  const TreeState({
    required this.parameters,
    required this.version,
  });

  final TreeParameters parameters;
  final int version;

  @override
  List<Object?> get props => [parameters, version];

  TreeState copyWith({
    TreeParameters? parameters,
    int? version,
  });
}

final class TreeInitial extends TreeState {
  const TreeInitial({
    super.parameters = TreeParameters.defaults,
    super.version = 1,
  });

  @override
  TreeInitial copyWith({
    TreeParameters? parameters,
    int? version,
  }) =>
      TreeInitial(
        parameters: parameters ?? this.parameters,
        version: version ?? this.version,
      );
}
