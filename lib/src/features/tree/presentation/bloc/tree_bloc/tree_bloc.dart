import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/tree_parameters.dart';

part 'tree_event.dart';
part 'tree_state.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  TreeBloc() : super(const TreeInitial()) {
    on<TreeUpdateParametersEvent>(_onTreeUpdateParametersEvent);
    on<TreeRebuildEvent>(_onTreeRebuildEvent);
  }

  void _onTreeUpdateParametersEvent(
    TreeUpdateParametersEvent event,
    Emitter<TreeState> emit,
  ) {
    emit(state.copyWith(parameters: event.parameters));
  }

  void _onTreeRebuildEvent(
    TreeRebuildEvent event,
    Emitter<TreeState> emit,
  ) {
    emit(state.copyWith(version: state.version + 1));
  }
}
