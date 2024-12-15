part of editor_menus;

class RotationMenu extends StatelessWidget {
  const RotationMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<RotationCubit>(),
        child: const RotationMenuForm(),
      );
}

class RotationMenuForm extends StatelessWidget {
  const RotationMenuForm({super.key});

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<RotationCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RotationCubit, RotationState>(builder: builder);

  Widget builder(BuildContext context, RotationState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final GlobalMode mode = context.select<GlobalCubit, GlobalMode>(
      (bloc) => bloc.state.mode,
    );

    return ListView(
      children: [
        Divider(color: colorScheme.tertiary),
        Text(
          'Вращение группы',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onTertiaryContainer),
          textAlign: TextAlign.center,
        ),
        Visibility(
          visible: mode == GlobalMode.threeDimensional,
          child: Wrap(
            children: [
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Угол X: ${state.angleX.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Slider(
                value: state.angleX,
                min: 0,
                max: 360,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.onTertiary,
                onChanged: (value) =>
                    context.read<RotationCubit>().updateAngles(angleX: value),
              ),
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Угол Y: ${state.angleY.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Slider(
                value: state.angleY,
                min: 0,
                max: 360,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.onTertiary,
                onChanged: (value) =>
                    context.read<RotationCubit>().updateAngles(angleY: value),
              ),
            ],
          ),
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Угол Z: ${state.angleZ.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.angleZ,
          min: 0,
          max: 360,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) =>
              context.read<RotationCubit>().updateAngles(angleZ: value),
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Точка X: ${state.pointX.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.pointX,
          min: -20,
          max: 20,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) =>
              context.read<RotationCubit>().updatePoint(pointX: value),
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Точка Y: ${state.pointY.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.pointY,
          min: -20,
          max: 20,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) =>
              context.read<RotationCubit>().updatePoint(pointY: value),
        ),
        Visibility(
          visible: mode == GlobalMode.threeDimensional,
          child: Wrap(
            children: [
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Точка Z: ${state.pointZ.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Slider(
                value: state.pointZ,
                min: -20,
                max: 20,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.onTertiary,
                onChanged: (value) =>
                    context.read<RotationCubit>().updatePoint(pointZ: value),
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
          onPressed: () => context.read<RotationCubit>().resetChanges(),
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
