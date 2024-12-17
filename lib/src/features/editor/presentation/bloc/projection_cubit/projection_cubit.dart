import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'projection_state.dart';

class ProjectionCubit extends Cubit<ProjectionState> {
  ProjectionCubit() : super(const ProjectionInitial(p: 0, q: 0, r: 0));

  void update({double? p, double? q, double? r}) {
    final newP = p ?? state.p;
    final newQ = q ?? state.q;
    final newR = r ?? state.r;

    assert(newP >= 0 && newP <= 2);
    assert(newQ >= 0 && newQ <= 2);
    assert(newR >= 0 && newR <= 2);

    emit(ProjectionInitial(
      p: newP,
      q: newQ,
      r: newR,
    ));
  }

  void resetChanges() {
    emit(const ProjectionInitial(p: 0, q: 0, r: 0));
  }

  void applyChanges(List<Line> group) {
    for (var line in group) {
      _projectPoint(line.firstPoint);
      _projectPoint(line.lastPoint);
    }
  }

  void _projectPoint(Point point) {
    final v = point.x * state.p + point.y * state.q + point.z * state.r + 1;
    point.x /= v;
    point.y /= v;
    point.z /= v;
  }
}
