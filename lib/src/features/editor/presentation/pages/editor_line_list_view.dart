import 'package:comgred/src/core/utils/logger.dart';
import 'package:comgred/src/features/editor/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorLineListView extends StatelessWidget {
  const EditorLineListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProjectBloc, ProjectState>(builder: builder);

  Widget builder(BuildContext context, ProjectState state) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          leading: Visibility(
            visible: state.lines.isNotEmpty,
            child: Checkbox(
              value: state.group.length == state.lines.length,
              onChanged: (value) {
                if (value == null) return;
                context.read<ProjectBloc>().add(
                      value
                          ? const ProjectSelectLinesEvent()
                          : const ProjectUnselectLinesEvent(),
                    );
              },
            ),
          ),
          title: Text(
            'Список линий',
            style: textTheme.titleMedium,
          ),
          trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  logger.i('on add');
                },
                icon: const Icon(Icons.add_outlined),
              ),
              Visibility(
                visible: state.group.isNotEmpty,
                child: IconButton(
                  onPressed: () {
                    logger.i('on delete group');
                  },
                  iconSize: 20.0,
                  icon: const Icon(Icons.delete_outlined),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.lines.length,
            itemBuilder: (context, index) {
              final line = state.lines[index];

              return ListTile(
                leading: Checkbox(
                  value: state.group.contains(line),
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<ProjectBloc>().add(
                          value
                              ? ProjectSelectLineEvent(line: line)
                              : ProjectUnselectLineEvent(line: line),
                        );
                  },
                ),
                title: Text('Line#${line.hashCode}'),
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
      ],
    );
  }
}
