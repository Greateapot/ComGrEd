import 'package:comgred/src/configs/injector/injector_conf.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';

class TreeDependency {
  TreeDependency._();

  static void init() {
    getIt.registerFactory(() => TreeBloc());
  }
}
