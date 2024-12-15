part of editor_menus;

class ScaleMenu extends StatelessWidget {
  const ScaleMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<ScaleCubit>(),
        child: const ScaleMenuForm(),
      );
}

class ScaleMenuForm extends StatelessWidget {
  const ScaleMenuForm({super.key});

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<ScaleCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ScaleCubit, ScaleState>(builder: builder);

  Widget builder(BuildContext context, ScaleState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final GlobalMode mode = context.select<GlobalCubit, GlobalMode>(
      (bloc) => bloc.state.mode,
    );
    return ListView(
      children: [
        Divider(color: colorScheme.tertiary),
        Text(
          'Масштабирование группы',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onTertiaryContainer),
          textAlign: TextAlign.center,
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'X: ${state.x.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.x,
          min: 0.01,
          max: 2,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) => context.read<ScaleCubit>().update(x: value),
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Y: ${state.y.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.y,
          min: 0.01,
          max: 2,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) => context.read<ScaleCubit>().update(y: value),
        ),
        Visibility(
          visible: mode == GlobalMode.threeDimensional,
          child: Wrap(
            children: [
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Z: ${state.z.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Slider(
                value: state.z,
                min: 0.01,
                max: 2,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.onTertiary,
                onChanged: (value) =>
                    context.read<ScaleCubit>().update(z: value),
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
          onPressed: () => context.read<ScaleCubit>().resetChanges(),
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
