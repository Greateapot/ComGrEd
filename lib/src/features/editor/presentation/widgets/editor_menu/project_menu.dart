part of editor_menu;

class SaveloadMenu extends StatelessWidget {
  const SaveloadMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(builder: builder);
  }

  Widget builder(BuildContext context, GlobalState state) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView(
      children: [
        Divider(color: colorScheme.tertiary),
        Text(
          'Проект',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onTertiaryContainer),
          textAlign: TextAlign.center,
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () =>
              context.read<ProjectBloc>().add(ProjectSaveProjectEvent(
                    distance: state.distance,
                    scale: state.scale,
                    angleX: state.angleX,
                    angleY: state.angleY,
                    show: state.showBackgroundLines,
                    is2d: state.mode == GlobalMode.twoDimensional,
                  )),
          child: Text(
            'Сохранить проект',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () =>
              context.read<ProjectBloc>().add(ProjectLoadProjectEvent(
            callback: (angleX, angleY, distance, scale, show, is2d) {
              final cubit = context.read<GlobalCubit>();
              cubit.updateAngles(angleX: angleX, angleY: angleY);
              cubit.updateDistance(distance);
              cubit.updateScale(scale);
              cubit.updateMode(
                is2d ? GlobalMode.twoDimensional : GlobalMode.threeDimensional,
              );
              cubit.updateShow(show);
            },
          )),
          child: Text(
            'Загрузить проект',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () =>
              context.read<ProjectBloc>().add(const ProjectCloseProjectEvent()),
          child: Text(
            'Закрыть проект',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
      ],
    );
  }
}
