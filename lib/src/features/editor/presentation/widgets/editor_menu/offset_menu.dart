part of editor_menu;

class OffsetMenu extends StatelessWidget {
  const OffsetMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<OffsetCubit>(),
        child: const OffsetMenuForm(),
      );
}

class OffsetMenuForm extends StatefulWidget {
  const OffsetMenuForm({super.key});

  @override
  State<OffsetMenuForm> createState() => _OffsetMenuFormState();
}

class _OffsetMenuFormState extends State<OffsetMenuForm> {
  late final TextEditingController _xController;
  late final TextEditingController _yController;
  late final TextEditingController _zController;

  late final GlobalKey<FormState> _formKey;

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<OffsetCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    final state = BlocProvider.of<OffsetCubit>(context, listen: false).state;

    _xController = TextEditingController(text: state.x.toString());
    _yController = TextEditingController(text: state.y.toString());
    _zController = TextEditingController(text: state.z.toString());
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffsetCubit, OffsetState>(
      builder: builder,
      listener: listener,
    );
  }

  Widget builder(BuildContext context, OffsetState state) {
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
            'Смещение группы',
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            textAlign: TextAlign.center,
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'X: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _xController,
            min: -100,
            max: 100,
            onChanged: (value) => context.read<OffsetCubit>().update(x: value),
          ),
          Slider(
            value: state.x,
            min: -100,
            max: 100,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) => context.read<OffsetCubit>().update(x: value),
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Y: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _yController,
            min: -100,
            max: 100,
            onChanged: (value) => context.read<OffsetCubit>().update(y: value),
          ),
          Slider(
            value: state.y,
            min: -100,
            max: 100,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) => context.read<OffsetCubit>().update(y: value),
          ),
          Visibility(
            visible: mode == GlobalMode.threeDimensional,
            child: Wrap(
              children: [
                Divider(color: colorScheme.tertiary),
                DoubleFormField(
                  padding: const EdgeInsets.all(8.0),
                  title: 'Z: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  controller: _zController,
                  min: -100,
                  max: 100,
                  onChanged: (value) =>
                      context.read<OffsetCubit>().update(z: value),
                ),
                Slider(
                  value: state.z,
                  min: -100,
                  max: 100,
                  activeColor: colorScheme.tertiary,
                  inactiveColor: colorScheme.onTertiary,
                  onChanged: (value) =>
                      context.read<OffsetCubit>().update(z: value),
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
            onPressed: () => context.read<OffsetCubit>().resetChanges(),
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

  void listener(BuildContext context, OffsetState state) {
    if (_xController.text != state.x.toString()) {
      _xController.text = state.x.toString();
    }
    if (_yController.text != state.y.toString()) {
      _yController.text = state.y.toString();
    }
    if (_zController.text != state.z.toString()) {
      _zController.text = state.z.toString();
    }
  }
}
