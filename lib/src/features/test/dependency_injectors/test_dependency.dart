import 'package:comgred/src/configs/injector/injector_conf.dart' show getIt;
import 'package:comgred/src/features/test/presentation/bloc/test_bloc/test_bloc.dart';

class TestDependency {
  TestDependency._();

  static void init() {
    getIt.registerFactory(() => TestBloc());
  }
}
