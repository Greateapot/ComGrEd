import 'package:comgred/src/configs/injector/injector_conf.dart' show getIt;
import 'package:comgred/src/features/test/presentation/bloc/test_parameters_bloc/test_parameters_bloc.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_project_bloc/test_project_bloc.dart';

class TestDependency {
  TestDependency._();

  static void init() {
    getIt.registerFactory(() => TestProjectBloc());
    getIt.registerFactory(() => TestParametersBloc());
  }
}
