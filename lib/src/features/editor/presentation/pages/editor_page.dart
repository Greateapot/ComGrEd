import 'package:comgred/src/configs/injector/injector_conf.dart';
import 'package:comgred/src/features/editor/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'editor_view.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ProjectBloc>()),
        BlocProvider.value(value: getIt<GlobalCubit>()),
      ],
      child: const EditorView(),
    );
  }
}
