part of 'tree_bloc.dart';

sealed class TreeEvent extends Equatable {
  const TreeEvent();

  @override
  List<Object> get props => [];
}

final class TreeUpdateParametersEvent extends TreeEvent {
  const TreeUpdateParametersEvent({required this.parameters});

  final TreeParameters parameters;

  @override
  List<Object> get props => [parameters];
}

final class TreeRebuildEvent extends TreeEvent {
  const TreeRebuildEvent();
}
