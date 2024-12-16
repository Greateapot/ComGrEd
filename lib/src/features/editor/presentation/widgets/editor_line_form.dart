import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

class EditorLineForm extends StatefulWidget {
  const EditorLineForm({
    super.key,
    this.line,
    this.onConfirm,
    this.onCancel,
  });

  final Line? line;
  final void Function(Line newLine)? onConfirm;
  final void Function()? onCancel;

  @override
  State<EditorLineForm> createState() => _EditorLineFormState();
}

class _EditorLineFormState extends State<EditorLineForm> {
  late final Line newLine;

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

    return Column(
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
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'X: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.firstPoint.x,
              onQtyChanged: (value) => newLine.firstPoint.x = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'Y: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.firstPoint.y,
              onQtyChanged: (value) => newLine.firstPoint.y = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'Z: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.firstPoint.z,
              onQtyChanged: (value) => newLine.firstPoint.z = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Вторая точка',
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onSecondaryContainer),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'X: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.lastPoint.x,
              onQtyChanged: (value) => newLine.lastPoint.x = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'Y: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.lastPoint.y,
              onQtyChanged: (value) => newLine.lastPoint.y = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(children: [
            Text(
              'Z: ',
              style: textTheme.titleSmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            InputQty.double(
              minVal: -100,
              maxVal: 100,
              initVal: newLine.lastPoint.z,
              onQtyChanged: (value) => newLine.lastPoint.z = value,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => widget.onConfirm != null
                    ? widget.onConfirm!(newLine)
                    : null,
                icon: Icon(
                  Icons.check_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              IconButton(
                onPressed: () =>
                    widget.onCancel != null ? widget.onCancel!() : null,
                icon: Icon(
                  Icons.close_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
