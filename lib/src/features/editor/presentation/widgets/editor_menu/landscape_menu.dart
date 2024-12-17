part of editor_menu;

class LandscapeMenu extends StatelessWidget {
  const LandscapeMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<LandscapeCubit>(),
        child: const LandscapeMenuForm(),
      );
}

class LandscapeMenuForm extends StatefulWidget {
  const LandscapeMenuForm({super.key});

  @override
  State<LandscapeMenuForm> createState() => _LandscapeMenuFormState();
}

class _LandscapeMenuFormState extends State<LandscapeMenuForm> {
  late final TextEditingController _squareSizeController;
  late final TextEditingController _randomnessController;
  late final TextEditingController _depthController;

  late final GlobalKey<FormState> _formKey;

  void applyChanges(BuildContext context) {
    context.read<ProjectBloc>().add(const ProjectCloseProjectEvent());
    context.read<LandscapeCubit>().applyChanges((lines) {
      context.read<GlobalCubit>().updateShow(false);
      context.read<GlobalCubit>().updateAngles(angleX: 30, angleY: 225);
      context.read<GlobalCubit>().updateDistance(20);
      context.read<GlobalCubit>().updateScale(600);
      context.read<ProjectBloc>().add(ProjectAddLinesEvent(lines: lines));
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    final state = BlocProvider.of<LandscapeCubit>(context, listen: false).state;

    _squareSizeController =
        TextEditingController(text: state.squareSize.toString());
    _randomnessController =
        TextEditingController(text: state.randomness.toString());
    _depthController = TextEditingController(text: state.depth.toString());
    super.initState();
  }

  @override
  void dispose() {
    _squareSizeController.dispose();
    _randomnessController.dispose();
    _depthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandscapeCubit, LandscapeState>(
      builder: builder,
      listener: listener,
    );
  }

  Widget builder(BuildContext context, LandscapeState state) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Divider(color: colorScheme.tertiary),
          Text(
            'Генерация ландшафта',
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            textAlign: TextAlign.center,
          ),
          Divider(color: colorScheme.tertiary),
          IntFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Глубина: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _depthController,
            min: 1,
            max: 6,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateDepth(value),
          ),
          Slider(
            value: state.depth.toDouble(),
            min: 1,
            max: 6,
            divisions: 6 - 1,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateDepth(value.toInt()),
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Случайность: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _randomnessController,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateRandomness(value),
          ),
          Slider(
            value: state.randomness,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateRandomness(value),
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Размер квадрата: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _squareSizeController,
            min: 5,
            max: 20,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateSquareSize(value),
          ),
          Slider(
            value: state.squareSize,
            min: 5,
            max: 20,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<LandscapeCubit>().updateSquareSize(value),
          ),
          Divider(color: colorScheme.tertiary),
          MaterialButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              applyChanges(context);
            },
            child: Text(
              'Сгенерировать',
              style: textTheme.bodyMedium,
            ),
          ),
          Divider(color: colorScheme.tertiary),
          MaterialButton(
            onPressed: () => context.read<LandscapeCubit>().resetChanges(),
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

  void listener(BuildContext context, LandscapeState state) {
    if (_squareSizeController.text != state.squareSize.toString()) {
      _squareSizeController.text = state.squareSize.toString();
    }
    if (_randomnessController.text != state.randomness.toString()) {
      _randomnessController.text = state.randomness.toString();
    }
    if (_depthController.text != state.depth.toString()) {
      _depthController.text = state.depth.toString();
    }
  }
}
