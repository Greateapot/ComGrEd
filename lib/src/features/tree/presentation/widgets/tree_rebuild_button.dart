import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreeRebuildButton extends StatelessWidget {
  const TreeRebuildButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MaterialButton(
      color: colorScheme.primary,
      onPressed: () {
        context.read<TreeBloc>().add(const TreeRebuildEvent());
      },
      child: Text(
        'Rebuild',
        style: textTheme.labelMedium?.copyWith(color: colorScheme.onPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
