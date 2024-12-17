part of editor_menu;

class GlobalMenu extends StatelessWidget {
  const GlobalMenu({super.key});

  @override
  Widget build(BuildContext context) => const GlobalMenuForm();
}

class GlobalMenuForm extends StatefulWidget {
  const GlobalMenuForm({super.key});

  @override
  State<GlobalMenuForm> createState() => _GlobalMenuFormState();
}

class _GlobalMenuFormState extends State<GlobalMenuForm> {
  late final TextEditingController _angleXController;
  late final TextEditingController _angleYController;
  late final TextEditingController _distanceController;
  late final TextEditingController _scaleController;

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    final state = BlocProvider.of<GlobalCubit>(context, listen: false).state;

    _angleXController = TextEditingController(text: state.angleX.toString());
    _angleYController = TextEditingController(text: state.angleY.toString());
    _distanceController =
        TextEditingController(text: state.distance.toString());
    _scaleController = TextEditingController(text: state.scale.toString());
    super.initState();
  }

  @override
  void dispose() {
    _angleXController.dispose();
    _angleYController.dispose();
    _distanceController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: builder,
      listener: listener,
    );
  }

  Widget builder(BuildContext context, GlobalState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: ListView(
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Отображать оси: ',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                ),
              ),
              Switch(
                activeColor: colorScheme.tertiary,
                activeTrackColor: colorScheme.onTertiary,
                inactiveThumbColor: colorScheme.tertiary,
                inactiveTrackColor: colorScheme.onTertiary,
                value: state.showBackgroundLines,
                onChanged: (value) =>
                    context.read<GlobalCubit>().updateShow(value),
              ),
            ],
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            controller: _angleXController,
            padding: const EdgeInsets.all(8.0),
            title: 'Φ: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            min: 0,
            max: 360,
            onChanged: (value) =>
                context.read<GlobalCubit>().updateAngles(angleX: value),
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
                DoubleFormField(
                  controller: _angleYController,
                  padding: const EdgeInsets.all(8.0),
                  title: 'Θ: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  min: 0,
                  max: 360,
                  onChanged: (value) =>
                      context.read<GlobalCubit>().updateAngles(angleY: value),
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
                DoubleFormField(
                  controller: _distanceController,
                  padding: const EdgeInsets.all(8.0),
                  title: 'Расстояние: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  min: 1,
                  max: 100,
                  onChanged: (value) =>
                      context.read<GlobalCubit>().updateDistance(value),
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
          DoubleFormField(
            controller: _scaleController,
            padding: const EdgeInsets.all(8.0),
            title: 'Общий масштаб: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            min: 1,
            max: 999,
            onChanged: (value) =>
                context.read<GlobalCubit>().updateScale(value),
          ),
          Slider(
            value: state.scale,
            min: 1,
            max: 999,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<GlobalCubit>().updateScale(value),
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
      ),
    );
  }

  void listener(BuildContext context, GlobalState state) {
    if (_angleXController.text != state.angleX.toStringAsFixed(3)) {
      _angleXController.text = state.angleX.toStringAsFixed(3);
    }
    if (_angleYController.text != state.angleY.toStringAsFixed(3)) {
      _angleYController.text = state.angleY.toStringAsFixed(3);
    }
    if (_distanceController.text != state.distance.toStringAsFixed(3)) {
      _distanceController.text = state.distance.toStringAsFixed(3);
    }
    if (_scaleController.text != state.scale.toStringAsFixed(3)) {
      _scaleController.text = state.scale.toStringAsFixed(3);
    }
  }
}
