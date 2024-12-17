part of editor_menu;

class RotationMenu extends StatelessWidget {
  const RotationMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<RotationCubit>(),
        child: const RotationMenuForm(),
      );
}

class RotationMenuForm extends StatefulWidget {
  const RotationMenuForm({super.key});

  @override
  State<RotationMenuForm> createState() => _RotationMenuFormState();
}

class _RotationMenuFormState extends State<RotationMenuForm> {
  late final TextEditingController _angleXController;
  late final TextEditingController _angleYController;
  late final TextEditingController _angleZController;

  late final TextEditingController _pointXController;
  late final TextEditingController _pointYController;
  late final TextEditingController _pointZController;

  late final GlobalKey<FormState> _formKey;

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<RotationCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    final state = BlocProvider.of<RotationCubit>(context, listen: false).state;

    _angleXController = TextEditingController(text: state.angleX.toString());
    _angleYController = TextEditingController(text: state.angleY.toString());
    _angleZController = TextEditingController(text: state.angleZ.toString());

    _pointXController = TextEditingController(text: state.pointX.toString());
    _pointYController = TextEditingController(text: state.pointY.toString());
    _pointZController = TextEditingController(text: state.pointZ.toString());
    super.initState();
  }

  @override
  void dispose() {
    _angleXController.dispose();
    _angleYController.dispose();
    _angleZController.dispose();

    _pointXController.dispose();
    _pointYController.dispose();
    _pointZController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RotationCubit, RotationState>(
      builder: builder,
      listener: listener,
    );
  }

  Widget builder(BuildContext context, RotationState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final GlobalMode mode = context.select<GlobalCubit, GlobalMode>(
      (bloc) => bloc.state.mode,
    );

    return Form(
      key: _formKey,
      child: ListView(
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
                DoubleFormField(
                  padding: const EdgeInsets.all(8.0),
                  title: 'Угол X: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  controller: _angleXController,
                  min: 0,
                  max: 360,
                  onChanged: (value) =>
                      context.read<RotationCubit>().updateAngles(angleX: value),
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
                DoubleFormField(
                  padding: const EdgeInsets.all(8.0),
                  title: 'Угол Y: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  controller: _angleYController,
                  min: 0,
                  max: 360,
                  onChanged: (value) =>
                      context.read<RotationCubit>().updateAngles(angleY: value),
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
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Угол Z: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _angleZController,
            min: 0,
            max: 360,
            onChanged: (value) =>
                context.read<RotationCubit>().updateAngles(angleZ: value),
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
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Точка X: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _pointXController,
            min: -100,
            max: 100,
            onChanged: (value) =>
                context.read<RotationCubit>().updatePoint(pointX: value),
          ),
          Slider(
            value: state.pointX,
            min: -100,
            max: 100,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<RotationCubit>().updatePoint(pointX: value),
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Точка Y: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _pointYController,
            min: -100,
            max: 100,
            onChanged: (value) =>
                context.read<RotationCubit>().updatePoint(pointY: value),
          ),
          Slider(
            value: state.pointY,
            min: -100,
            max: 100,
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
                DoubleFormField(
                  padding: const EdgeInsets.all(8.0),
                  title: 'Точка Z: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  controller: _pointZController,
                  min: -100,
                  max: 100,
                  onChanged: (value) =>
                      context.read<RotationCubit>().updatePoint(pointZ: value),
                ),
                Slider(
                  value: state.pointZ,
                  min: -100,
                  max: 100,
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
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              applyChanges(context);
            },
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
      ),
    );
  }

  void listener(BuildContext context, RotationState state) {
    if (_angleXController.text != state.angleX.toStringAsFixed(3)) {
      _angleXController.text = state.angleX.toStringAsFixed(3);
    }
    if (_angleYController.text != state.angleY.toStringAsFixed(3)) {
      _angleYController.text = state.angleY.toStringAsFixed(3);
    }
    if (_angleZController.text != state.angleZ.toStringAsFixed(3)) {
      _angleZController.text = state.angleZ.toStringAsFixed(3);
    }
    if (_pointXController.text != state.pointX.toStringAsFixed(3)) {
      _pointXController.text = state.pointX.toStringAsFixed(3);
    }
    if (_pointYController.text != state.pointY.toStringAsFixed(3)) {
      _pointYController.text = state.pointY.toStringAsFixed(3);
    }
    if (_pointZController.text != state.pointZ.toStringAsFixed(3)) {
      _pointZController.text = state.pointZ.toStringAsFixed(3);
    }
  }
}
