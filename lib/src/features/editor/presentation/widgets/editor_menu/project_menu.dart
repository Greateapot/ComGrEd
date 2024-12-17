part of editor_menu;

class SaveloadMenu extends StatelessWidget {
  const SaveloadMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
              context.read<ProjectBloc>().add(const ProjectSaveProjectEvent()),
          child: Text(
            'Сохранить проект',
            style: textTheme.bodyMedium,
          ),
        ),
        Divider(color: colorScheme.tertiary),
        MaterialButton(
          onPressed: () =>
              context.read<ProjectBloc>().add(const ProjectLoadProjectEvent()),
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
