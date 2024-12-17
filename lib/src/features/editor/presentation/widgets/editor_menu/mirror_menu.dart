part of editor_menu;

class MirrorMenu extends StatelessWidget {
  const MirrorMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<MirrorCubit>(),
        child: const MirrorMenuForm(),
      );
}

class MirrorMenuForm extends StatelessWidget {
  const MirrorMenuForm({super.key});

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<MirrorCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MirrorCubit, MirrorState>(builder: builder);

  Widget builder(BuildContext context, MirrorState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final GlobalMode mode = context.select<GlobalCubit, GlobalMode>(
      (bloc) => bloc.state.mode,
    );

    return ListView(
      children: [
        Divider(color: colorScheme.tertiary),
        Text(
          'Зеркалирование группы',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onTertiaryContainer),
          textAlign: TextAlign.center,
        ),
        Divider(color: colorScheme.tertiary),
        Row(
          children: [
            Checkbox(
              value: state.x,
              onChanged: (value) =>
                  context.read<MirrorCubit>().update(x: value),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Отразить относительно оси X',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
            ),
          ],
        ),
        Divider(color: colorScheme.tertiary),
        Row(
          children: [
            Checkbox(
              value: state.y,
              onChanged: (value) =>
                  context.read<MirrorCubit>().update(y: value),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Отразить относительно оси Y',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: mode == GlobalMode.threeDimensional,
          child: Wrap(
            children: [
              Divider(color: colorScheme.tertiary),
              Row(
                children: [
                  Checkbox(
                    value: state.z,
                    onChanged: (value) =>
                        context.read<MirrorCubit>().update(z: value),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Отразить относительно оси Z',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.onTertiaryContainer),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () => applyChanges(context),
          child: Text(
            'Применить',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () => context.read<MirrorCubit>().resetChanges(),
          child: Text(
            'Сброс',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
      ],
    );
  }
}
