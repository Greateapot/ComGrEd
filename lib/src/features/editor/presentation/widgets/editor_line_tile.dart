import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:comgred/src/features/editor/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorLineTile extends StatefulWidget {
  const EditorLineTile({
    super.key,
    this.line,
    this.isSelected = false,
    this.isAdd = false,
  });

  final Line? line;
  final bool isSelected;
  final bool isAdd;

  @override
  State<EditorLineTile> createState() => _EditorLineTileState();
}

class _EditorLineTileState extends State<EditorLineTile> {
  late final ExpansionTileController _controller;

  @override
  void initState() {
    _controller = ExpansionTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: _controller,
      leading: widget.isAdd
          ? null
          : Checkbox(
              value: widget.isSelected,
              onChanged: (value) {
                if (value == null) return;
                context.read<ProjectBloc>().add(
                      value
                          ? ProjectSelectLineEvent(line: widget.line!)
                          : ProjectUnselectLineEvent(line: widget.line!),
                    );
              },
            ),
      title: widget.isAdd
          ? const Text('Добавить линию...')
          : Text('Линия №$hashCode'),
      trailing: widget.isAdd
          ? null
          : IconButton(
              onPressed: () {
                if (_controller.isExpanded) _controller.collapse();
                context
                    .read<ProjectBloc>()
                    .add(ProjectRemoveLineEvent(line: widget.line!));
              },
              icon: const Icon(Icons.delete_outlined),
            ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EditorLineForm(
            line: widget.line,
            onConfirm: (newLine) {
              if (_controller.isExpanded) _controller.collapse();
              context.read<ProjectBloc>().add(
                    widget.isAdd
                        ? ProjectAddLineEvent(line: newLine)
                        : ProjectEditLineEvent(
                            oldLine: widget.line!,
                            newLine: newLine,
                          ),
                  );
            },
            onCancel: () {
              if (_controller.isExpanded) _controller.collapse();
            },
          ),
        ),
      ],
    );
  }
}
