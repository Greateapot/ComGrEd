import 'package:comgred/src/core/widgets/widgets.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';

class EditorLineForm extends StatefulWidget {
  const EditorLineForm({
    super.key,
    this.line,
    required this.onConfirm,
    required this.onCancel,
  });

  final Line? line;
  final void Function(Line newLine) onConfirm;
  final void Function() onCancel;

  @override
  State<EditorLineForm> createState() => _EditorLineFormState();
}

class _EditorLineFormState extends State<EditorLineForm> {
  late final Line newLine;

  final _formKey = GlobalKey<FormState>();

  void reset() {
    if (widget.line == null) return;
    newLine.firstPoint.x = widget.line!.firstPoint.x;
    newLine.firstPoint.y = widget.line!.firstPoint.y;
    newLine.firstPoint.z = widget.line!.firstPoint.z;
    newLine.lastPoint.x = widget.line!.lastPoint.x;
    newLine.lastPoint.y = widget.line!.lastPoint.y;
    newLine.lastPoint.z = widget.line!.lastPoint.z;
  }

  @override
  void initState() {
    newLine = Line(
      firstPoint: Point(x: 0, y: 0, z: 0),
      lastPoint: Point(x: 0, y: 0, z: 0),
    );
    reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Первая точка',
              style: textTheme.titleMedium
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
            ),
          ),
          DoubleFormField(
            title: 'X:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.firstPoint.x,
            onChanged: (value) => newLine.firstPoint.x = value,
            min: -100,
            max: 100,
          ),
          DoubleFormField(
            title: 'Y:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.firstPoint.y,
            onChanged: (value) => newLine.firstPoint.y = value,
            min: -100,
            max: 100,
          ),
          DoubleFormField(
            title: 'Z:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.firstPoint.z,
            onChanged: (value) => newLine.firstPoint.z = value,
            min: -100,
            max: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Вторая точка',
              style: textTheme.titleMedium
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
            ),
          ),
          DoubleFormField(
            title: 'X:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.lastPoint.x,
            onChanged: (value) => newLine.lastPoint.x = value,
            min: -100,
            max: 100,
          ),
          DoubleFormField(
            title: 'Y:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.lastPoint.y,
            onChanged: (value) => newLine.lastPoint.y = value,
            min: -100,
            max: 100,
          ),
          DoubleFormField(
            title: 'Z:',
            titleStyle: textTheme.titleSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            initialValue: newLine.lastPoint.z,
            onChanged: (value) => newLine.lastPoint.z = value,
            min: -100,
            max: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    widget.onConfirm(newLine);
                  },
                  icon: Icon(
                    Icons.check_outlined,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                IconButton(
                  onPressed: () => widget.onCancel(),
                  icon: Icon(
                    Icons.close_outlined,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
