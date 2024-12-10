import 'package:get_it/get_it.dart';

import 'injectors.dart';

final getIt = GetIt.I;

void configureDepedencies() {
  TestDependency.init();

  getIt.registerLazySingleton(
    () => AppRouteConf(),
  );
}
