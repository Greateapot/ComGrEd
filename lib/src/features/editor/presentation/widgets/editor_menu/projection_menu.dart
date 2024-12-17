part of editor_menu;

class ProjectionMenu extends StatelessWidget {
  const ProjectionMenu({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<ProjectionCubit>(),
        child: const ProjectionMenuForm(),
      );
}

class ProjectionMenuForm extends StatefulWidget {
  const ProjectionMenuForm({super.key});

  @override
  State<ProjectionMenuForm> createState() => _ProjectionMenuFormState();
}

class _ProjectionMenuFormState extends State<ProjectionMenuForm> {
  late final TextEditingController _pController;
  late final TextEditingController _qController;
  late final TextEditingController _rController;

  late final GlobalKey<FormState> _formKey;

  void applyChanges(BuildContext context) {
    final group = context.read<ProjectBloc>().state.group;
    if (group.isEmpty) return;

    context.read<ProjectionCubit>().applyChanges(group);
    context.read<ProjectBloc>().add(const ProjectRebuildEvent());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    final state =
        BlocProvider.of<ProjectionCubit>(context, listen: false).state;

    _pController = TextEditingController(text: state.p.toString());
    _qController = TextEditingController(text: state.q.toString());
    _rController = TextEditingController(text: state.r.toString());
    super.initState();
  }

  @override
  void dispose() {
    _pController.dispose();
    _qController.dispose();
    _rController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectionCubit, ProjectionState>(
      builder: builder,
      listener: listener,
    );
  }

  Widget builder(BuildContext context, ProjectionState state) {
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
            'Проецирование группы',
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            textAlign: TextAlign.center,
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'P: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _pController,
            min: 0,
            max: 2,
            onChanged: (value) =>
                context.read<ProjectionCubit>().update(p: value),
          ),
          Slider(
            value: state.p,
            min: 0,
            max: 2,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<ProjectionCubit>().update(p: value),
          ),
          Divider(color: colorScheme.tertiary),
          DoubleFormField(
            padding: const EdgeInsets.all(8.0),
            title: 'Q: ',
            titleStyle: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onTertiaryContainer),
            controller: _qController,
            min: 0,
            max: 2,
            onChanged: (value) =>
                context.read<ProjectionCubit>().update(q: value),
          ),
          Slider(
            value: state.q,
            min: 0,
            max: 2,
            activeColor: colorScheme.tertiary,
            inactiveColor: colorScheme.onTertiary,
            onChanged: (value) =>
                context.read<ProjectionCubit>().update(q: value),
          ),
          Visibility(
            visible: mode == GlobalMode.threeDimensional,
            child: Wrap(
              children: [
                Divider(color: colorScheme.tertiary),
                DoubleFormField(
                  padding: const EdgeInsets.all(8.0),
                  title: 'R: ',
                  titleStyle: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onTertiaryContainer),
                  controller: _rController,
                  min: 0,
                  max: 2,
                  onChanged: (value) =>
                      context.read<ProjectionCubit>().update(r: value),
                ),
                Slider(
                  value: state.r,
                  min: 0,
                  max: 2,
                  activeColor: colorScheme.tertiary,
                  inactiveColor: colorScheme.onTertiary,
                  onChanged: (value) =>
                      context.read<ProjectionCubit>().update(r: value),
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
            onPressed: () => context.read<ProjectionCubit>().resetChanges(),
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

  void listener(BuildContext context, ProjectionState state) {
    if (_pController.text != state.p.toStringAsFixed(3)) {
      _pController.text = state.p.toStringAsFixed(3);
    }
    if (_qController.text != state.q.toStringAsFixed(3)) {
      _qController.text = state.q.toStringAsFixed(3);
    }
    if (_rController.text != state.r.toStringAsFixed(3)) {
      _rController.text = state.r.toStringAsFixed(3);
    }
  }
}
