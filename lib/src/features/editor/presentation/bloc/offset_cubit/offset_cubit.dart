import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'offset_state.dart';

class OffsetCubit extends Cubit<OffsetState> {
  OffsetCubit() : super(const OffsetInitial(x: 0, y: 0, z: 0));

  void update({double? x, double? y, double? z}) {
    final newX = x ?? state.x;
    final newY = y ?? state.y;
    final newZ = z ?? state.z;

    assert(newX >= -100 && newX <= 100);
    assert(newY >= -100 && newY <= 100);
    assert(newZ >= -100 && newZ <= 100);

    emit(OffsetInitial(
      x: newX,
      y: newY,
      z: newZ,
    ));
  }

  void resetChanges() {
    emit(const OffsetInitial(x: 0, y: 0, z: 0));
  }

  void applyChanges(List<Line> group) {
    for (var line in group) {
      _movePoint(line.firstPoint);
      _movePoint(line.lastPoint);
    }
  }

  void _movePoint(Point point) {
    point.x += state.x;
    point.y += state.y;
    point.z += state.z;
  }
}
