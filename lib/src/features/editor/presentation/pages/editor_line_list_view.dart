import 'package:comgred/src/features/editor/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorLineListView extends StatelessWidget {
  const EditorLineListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProjectBloc, ProjectState>(builder: builder);

  Widget builder(BuildContext context, ProjectState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onSecondaryContainer),
          ),
          trailing: Visibility(
            visible: state.group.isNotEmpty,
            child: IconButton(
              onPressed: () => context
                  .read<ProjectBloc>()
                  .add(const ProjectRemoveLinesEvent()),
              iconSize: 20.0,
              icon: const Icon(Icons.delete_outlined),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.lines.length + 1,
            itemBuilder: (context, index) {
              final line = state.lines.elementAtOrNull(index);

              if (line == null) {
                return const EditorLineTile(isAdd: true);
              } else {
                final isSelected = state.group.contains(line);

                return EditorLineTile(
                  line: line,
                  isSelected: isSelected,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
