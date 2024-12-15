import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'mirror_state.dart';

class MirrorCubit extends Cubit<MirrorState> {
  MirrorCubit() : super(const MirrorInitial(x: false, y: false, z: false));

  void update({bool? x, bool? y, bool? z}) {
    final newX = x ?? state.x;
    final newY = y ?? state.y;
    final newZ = z ?? state.z;

    emit(MirrorInitial(
      x: x ?? newX,
      y: y ?? newY,
      z: z ?? newZ,
    ));
  }

  void resetChanges() {
    emit(const MirrorInitial(
      x: false,
      y: false,
      z: false,
    ));
  }

  void applyChanges(List<Line> group) {
    for (var line in group) {
      _mirrorPoint(line.firstPoint);
      _mirrorPoint(line.lastPoint);
    }
  }

  void _mirrorPoint(Point point) {
    if (state.x) point.x *= -1;
    if (state.y) point.y *= -1;
    if (state.z) point.z *= -1;
  }
}
