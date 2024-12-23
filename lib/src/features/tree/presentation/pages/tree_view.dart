import 'package:comgred/src/features/tree/presentation/widgets/widgets.dart';
import 'package:comgred/src/routes/app_route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_split_view/multi_split_view.dart';

class TreeView extends StatefulWidget {
  const TreeView({super.key});

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late final MultiSplitViewController _multiSplitViewController;

  @override
  void initState() {
    _multiSplitViewController = MultiSplitViewController(
      areas: [
        Area(
          flex: 7,
          min: 7,
          max: 8,
          builder: treeAreaBuilder,
        ),
        Area(
          flex: 2,
          min: 1,
          max: 2,
          builder: treeParametersFormAreabuilder,
        ),
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.secondaryContainer,
        title: Text(
          'Fractal Tree',
          style: textTheme.titleMedium,
        ),
        leading: IconButton.outlined(
          onPressed: () => context.goNamed(AppRoute.editor.name),
          icon: Icon(
            Icons.swap_horiz_outlined,
            color: colorScheme.primary,
          ),
        ),
      ),
      body: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainters.grooved1(
            color: colorScheme.primary,
            highlightedColor: colorScheme.primary,
            backgroundColor: colorScheme.secondaryContainer,
          ),
        ),
        child: MultiSplitView(controller: _multiSplitViewController),
      ),
    );
  }

  Widget treeAreaBuilder(
    BuildContext context,
    Area area,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colorScheme.primaryContainer,
        border: Border.all(
          color: colorScheme.primary,
          width: 1,
        ),
      ),
      child: const TreePaint(),
    );
  }

  Widget treeParametersFormAreabuilder(
    BuildContext context,
    Area area,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colorScheme.primaryContainer,
        border: Border.all(
          color: colorScheme.primary,
          width: 1,
        ),
      ),
      child: const TreeParametersForm(),
    );
  }
}
