import 'package:comgred/src/configs/injector/injector_conf.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'test_view.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<TestBloc>();

    return BlocProvider.value(
      value: bloc,
      child: const TestView(),
    );
  }
}
