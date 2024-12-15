part of editor_menus;

class GlobalMenu extends StatelessWidget {
  const GlobalMenu({super.key});

  @override
  Widget build(BuildContext context) => const GlobalMenuForm();
}

class GlobalMenuForm extends StatelessWidget {
  const GlobalMenuForm({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GlobalCubit, GlobalState>(builder: builder);

  Widget builder(BuildContext context, GlobalState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        Divider(color: colorScheme.tertiary),
        Text(
          'Параметры отображения',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onTertiaryContainer),
          textAlign: TextAlign.center,
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Размерность: ${state.mode.title}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                GlobalMode.twoDimensional.title,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onTertiaryContainer),
              ),
            ),
            Switch(
              activeColor: colorScheme.tertiary,
              activeTrackColor: colorScheme.onTertiary,
              inactiveThumbColor: colorScheme.tertiary,
              inactiveTrackColor: colorScheme.onTertiary,
              value: state.mode == GlobalMode.threeDimensional,
              onChanged: (value) => context.read<GlobalCubit>().updateMode(
                    value
                        ? GlobalMode.threeDimensional // true
                        : GlobalMode.twoDimensional, // false
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                GlobalMode.threeDimensional.title,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onTertiaryContainer),
              ),
            ),
          ],
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Φ: ${state.angleX.toStringAsFixed(2)}',
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
              context.read<GlobalCubit>().updateAngles(angleX: value),
        ),
        Visibility(
          visible: state.mode == GlobalMode.threeDimensional,
          child: Wrap(
            children: [
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Θ: ${state.angleY.toStringAsFixed(2)}',
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
                    context.read<GlobalCubit>().updateAngles(angleY: value),
              ),
              Divider(color: colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Расстояние от наблюдателя: ${state.distance.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Slider(
                value: state.distance,
                min: 1,
                max: 100,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.onTertiary,
                onChanged: (value) =>
                    context.read<GlobalCubit>().updateDistance(value),
              ),
            ],
          ),
        ),
        Divider(color: colorScheme.tertiary),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Общий масштаб: ${state.scale.toStringAsFixed(2)}',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
          ),
        ),
        Slider(
          value: state.scale,
          min: 1,
          max: 999,
          activeColor: colorScheme.tertiary,
          inactiveColor: colorScheme.onTertiary,
          onChanged: (value) => context.read<GlobalCubit>().updateScale(value),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () => context.read<GlobalCubit>().resetChanges(),
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
