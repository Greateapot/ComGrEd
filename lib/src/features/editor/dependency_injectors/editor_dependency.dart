import 'package:comgred/src/configs/injector/injector_conf.dart' show getIt;
import 'package:comgred/src/features/editor/presentation/bloc/bloc.dart';

class EditorDependency {
  EditorDependency._();

  static void init() {
    /// bloc
    getIt.registerFactory(() => ProjectBloc());

    /// cubit
    getIt.registerFactory(() => GlobalCubit());
    getIt.registerFactory(() => RotationCubit());
    getIt.registerFactory(() => ProjectionCubit());
    getIt.registerFactory(() => LandscapeCubit());
    getIt.registerFactory(() => OffsetCubit());
    getIt.registerFactory(() => ScaleCubit());
    getIt.registerFactory(() => MirrorCubit());
  }
}
