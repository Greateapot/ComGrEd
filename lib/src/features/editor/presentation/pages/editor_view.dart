import 'package:comgred/src/features/editor/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  late final MultiSplitViewController _multiSplitViewController;

  @override
  void initState() {
    _multiSplitViewController = MultiSplitViewController(
      areas: [
        Area(flex: 3, min: 3, max: 4, builder: lineListViewBuilder),
        Area(flex: 8, min: 6, max: 8, builder: viewBuilder),
        Area(flex: 3, min: 3, max: 4, builder: menuViewBuilder),
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    _multiSplitViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainters.grooved1(
            color: colorScheme.onPrimaryContainer.withOpacity(0.38),
            highlightedColor: colorScheme.onPrimaryContainer,
          ),
        ),
        child: MultiSplitView(controller: _multiSplitViewController),
      ),
    );
  }

  Widget lineListViewBuilder(BuildContext context, Area area) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: colorScheme.secondaryContainer,
        border: Border.all(color: colorScheme.onSecondaryContainer),
      ),
      child: const EditorLineListView(),
    );
  }

  Widget viewBuilder(BuildContext context, Area area) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: colorScheme.primaryContainer,
        border: Border.all(color: colorScheme.onPrimaryContainer),
      ),
      child: const ClipRect(child: RepaintBoundary(child: EditorPaint())),
    );
  }

  Widget menuViewBuilder(BuildContext context, Area area) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: colorScheme.tertiaryContainer,
        border: Border.all(color: colorScheme.onTertiaryContainer),
      ),
      child: EditorMenuView(
        menus: [
          EditorMenuViewData(
            icon: const Icon(Icons.menu_outlined),
            builder: (context) => const GlobalMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.file_present_outlined),
            builder: (context) => const SaveloadMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.ac_unit_outlined),
            builder: (context) => const RotationMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.ac_unit_outlined),
            builder: (context) => const OffsetMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.ac_unit_outlined),
            builder: (context) => const ScaleMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.ac_unit_outlined),
            builder: (context) => const MirrorMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.ac_unit_outlined),
            builder: (context) => const ProjectionMenu(),
          ),
          EditorMenuViewData(
            icon: const Icon(Icons.star_border_outlined),
            builder: (context) => const LandscapeMenu(),
          ),
        ],
      ),
    );
  }
}
