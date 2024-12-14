import 'package:comgred/src/configs/injector/injector_conf.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_parameters_bloc/test_parameters_bloc.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_project_bloc/test_project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'test_view.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<TestProjectBloc>()),
        BlocProvider.value(value: getIt<TestParametersBloc>()),
      ],
      child: const TestView(),
    );
  }
}
