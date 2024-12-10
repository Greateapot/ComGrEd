import 'package:comgred/src/configs/injector/injector_conf.dart';
import 'package:comgred/src/configs/injector/injectors.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  static const String title = 'Computer Graphics Editor';

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouteConf>().router;

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: title,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
