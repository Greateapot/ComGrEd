import 'package:comgred/src/core/utils/logger.dart';
import 'package:comgred/src/features/test/presentation/bloc/test_project_bloc/test_project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestLineListView extends StatelessWidget {
  const TestLineListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TestProjectBloc, TestProjectState>(builder: builder);

  Widget builder(BuildContext context, TestProjectState state) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Список линий',
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.lines.length,
            itemBuilder: (context, index) {
              final line = state.lines[index];
              return ListTile(
                leading: Checkbox(
                  value: state.selectedLineIds.contains(line.id),
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<TestProjectBloc>().add(
                          value
                              ? TestProjectSelectLineEvent(lineId: line.id)
                              : TestProjectUnselectLineEvent(lineId: line.id),
                        );
                  },
                ),
                title: Text(line.id),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        logger.i('on edit');
                      },
                      iconSize: 20.0,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        logger.i('on delete');
                      },
                      iconSize: 20.0,
                      icon: const Icon(Icons.delete_outlined),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        MaterialButton(
          onPressed: () {
            logger.i('on add');
          },
          child: const Icon(Icons.add_outlined),
        ),
      ],
    );
  }
}
