import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'scale_state.dart';

class ScaleCubit extends Cubit<ScaleState> {
  ScaleCubit() : super(const ScaleInitial(x: 1, y: 1, z: 1));

  void update({double? x, double? y, double? z}) {
    final newX = x ?? state.x;
    final newY = y ?? state.y;
    final newZ = z ?? state.z;

    assert(newX > 0 && newX <= 2);
    assert(newY > 0 && newY <= 2);
    assert(newZ > 0 && newZ <= 2);

    emit(ScaleInitial(
      x: newX,
      y: newY,
      z: newZ,
    ));
  }

  void resetChanges() {
    emit(const ScaleInitial(x: 1, y: 1, z: 1));
  }

  void applyChanges(List<Line> group) {
    for (var line in group) {
      _movePoint(line.firstPoint);
      _movePoint(line.lastPoint);
    }
  }

  void _movePoint(Point point) {
    point.x *= state.x;
    point.y *= state.y;
    point.z *= state.z;
  }
}
