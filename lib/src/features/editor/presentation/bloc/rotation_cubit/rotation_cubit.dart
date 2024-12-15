import 'package:bloc/bloc.dart';
import 'package:comgred/src/core/extensions/double_extension.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:vector_math/vector_math_64.dart';

part 'rotation_state.dart';

class RotationCubit extends Cubit<RotationState> {
  RotationCubit()
      : super(const RotationInitial(
          angleX: 0,
          angleY: 0,
          angleZ: 0,
          pointX: 0,
          pointY: 0,
          pointZ: 0,
        ));

  void updatePoint({double? pointX, double? pointY, double? pointZ}) {
    final newPointX = pointX ?? state.pointX;
    final newPointY = pointY ?? state.pointY;
    final newPointZ = pointZ ?? state.pointZ;

    assert(newPointX >= -20 && newPointX <= 20);
    assert(newPointY >= -20 && newPointY <= 20);
    assert(newPointZ >= -20 && newPointZ <= 20);

    emit(state.copyWith(
      pointX: newPointX,
      pointY: newPointY,
      pointZ: newPointZ,
    ));
  }

  void updateAngles({double? angleX, double? angleY, double? angleZ}) {
    final newAngleX = angleX ?? state.angleX;
    final newAngleY = angleY ?? state.angleY;
    final newAngleZ = angleZ ?? state.angleZ;

    assert(newAngleX >= 0 && newAngleX <= 360);
    assert(newAngleY >= 0 && newAngleY <= 360);
    assert(newAngleZ >= 0 && newAngleZ <= 360);

    emit(state.copyWith(
      angleX: newAngleX,
      angleY: newAngleY,
      angleZ: newAngleZ,
    ));
  }

  void resetChanges() {
    emit(const RotationInitial(
      angleX: 0,
      angleY: 0,
      angleZ: 0,
      pointX: 0,
      pointY: 0,
      pointZ: 0,
    ));
  }

  void applyChanges(List<Line> group) {
    final rotationX = Matrix4.rotationX(state.angleX.toRadians());
    final rotationY = Matrix4.rotationY(state.angleY.toRadians());
    final rotationZ = Matrix4.rotationZ(state.angleZ.toRadians());

    final matrix = rotationX * rotationY * rotationZ;

    for (var line in group) {
      _rotatePoint(line.firstPoint, matrix);
      _rotatePoint(line.lastPoint, matrix);
    }
  }

  void _rotatePoint(Point point, Matrix4 matrix) {
    final vector = Vector4(
      point.x - state.pointX,
      point.y - state.pointY,
      point.z - state.pointZ,
      1,
    );
    vector.applyMatrix4(matrix);
    vector.xyzw = vector / vector.w;

    point.x = vector.x + state.pointX;
    point.y = vector.y + state.pointY;
    point.z = vector.z + state.pointZ;
  }
}
