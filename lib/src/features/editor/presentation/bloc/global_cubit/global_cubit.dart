import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit()
      : super(const GlobalInitial(
          angleX: 0,
          angleY: 0,
          distance: 10,
          scale: 500,
          mode: GlobalMode.threeDimensional,
          showBackgroundLines: true,
        ));

  void updateAngles({double? angleX, double? angleY}) {
    final newAngleX = angleX ?? state.angleX;
    final newAngleY = angleY ?? state.angleY;

    assert(newAngleX >= 0 && newAngleX <= 360);
    assert(newAngleY >= 0 && newAngleY <= 360);

    emit(state.copyWith(
      angleX: newAngleX,
      angleY: newAngleY,
    ));
  }

  void updateScale(double scale) {
    assert(scale > 0 && scale < 1000);

    emit(state.copyWith(scale: scale));
  }

  void updateDistance(double distance) {
    assert(distance > 0 && distance <= 100);

    emit(state.copyWith(distance: distance));
  }

  void updateMode(GlobalMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void updateShow(bool showBackgroundLines) {
    emit(state.copyWith(showBackgroundLines: showBackgroundLines));
  }

  void resetChanges() {
    emit(GlobalInitial(
      angleX: 0,
      angleY: 0,
      distance: 10,
      scale: 500,
      mode: state.mode,
      showBackgroundLines: true,
    ));
  }
}
