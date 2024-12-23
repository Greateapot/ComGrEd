import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:comgred/src/features/tree/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreePaint extends StatelessWidget {
  const TreePaint({super.key});

  void onPaintError(BuildContext context, String? message) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
        width: size.width / 5,
        backgroundColor: colorScheme.errorContainer,
        // showCloseIcon: true,
        // closeIconColor: colorScheme.onErrorContainer,
        content: Text(
          message ?? 'Unexpected instruction!',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onErrorContainer),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<TreeBloc, TreeState>(
      builder: (context, state) {
        return ListView(
          reverse: true,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 5,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: TreePainter(
                    parameters: state.parameters,
                    version: state.version,
                    onError: (message) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => onPaintError(context, message),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
