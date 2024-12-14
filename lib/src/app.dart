import 'dart:math' show Random;

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
      behavior: HitTestBehavior.deferToChild,
      child: MaterialApp.router(
        title: title,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
          ),
        ),
      ),
    );
  }

  Color get seedColor {
    final Random random = Random.secure();
    final int r = random.nextInt(127) + 127;
    final int g = random.nextInt(127) + 127;
    final int b = random.nextInt(127) + 127;
    return Color.fromRGBO(r, g, b, 1);
  }
}
