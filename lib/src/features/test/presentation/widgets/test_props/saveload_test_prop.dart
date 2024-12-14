part of 'test_props.dart';

class SaveloadTestProp extends StatelessWidget {
  const SaveloadTestProp({super.key});

  Future<String?> saveFile() async {
    final initialDirectory = await getApplicationDocumentsDirectory();

    String? result = await FilePicker.platform.saveFile(
      // TODO: readable filename
      fileName: '${DateTime.now().millisecondsSinceEpoch}.json',
      dialogTitle: 'Please select an output file:',
      type: FileType.custom,
      allowedExtensions: ['json'],
      initialDirectory: initialDirectory.path,
      lockParentWindow: true,
    );

    if (result == null) return null;
    if (!result.endsWith('.json')) result += '.json';
    return result;
  }

  Future<String?> loadFile() async {
    final initialDirectory = await getApplicationDocumentsDirectory();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please select an input file:',
      type: FileType.custom,
      allowedExtensions: ['json'],
      initialDirectory: initialDirectory.path,
      lockParentWindow: true,
    );

    return result?.files.single.path;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MaterialButton(
          onPressed: () async {
            final path = await saveFile();
            if (path == null) return;

            context
                .read<TestProjectBloc>()
                .add(TestProjectSaveProjectEvent(path: path));
          },
          child: Text(
            'Сохранить проект',
            style: textTheme.bodyMedium,
          ),
        ),
        MaterialButton(
          onPressed: () async {
            final path = await loadFile();
            if (path == null) return;

            context
                .read<TestProjectBloc>()
                .add(TestProjectLoadProjectEvent(path: path));
          },
          child: Text(
            'Загрузить проект',
            style: textTheme.bodyMedium,
          ),
        ),
        MaterialButton(
          onPressed: () async {
            context
                .read<TestProjectBloc>()
                .add(const TestProjectCloseProjectEvent());
          },
          child: Text(
            'Закрыть проект',
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
