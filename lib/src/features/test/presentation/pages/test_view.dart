import 'package:comgred/src/features/test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  late final MultiSplitViewController _multiSplitViewController;

  @override
  void initState() {
    _multiSplitViewController = MultiSplitViewController(
      areas: [
        Area(flex: 3, min: 2, max: 3, builder: lineListViewBuilder),
        Area(flex: 7, min: 6, max: 8, builder: viewBuilder),
        Area(flex: 2, min: 2, max: 3, builder: propsBuilder),
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
      child: const TestLineListView(),
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
      child: RepaintBoundary(child: TestPaint()),
    );
  }

  Widget propsBuilder(BuildContext context, Area area) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: colorScheme.tertiaryContainer,
        border: Border.all(color: colorScheme.onTertiaryContainer),
      ),
      child: TestProps(
        props: [
          TestPropData(
            icon: const Icon(Icons.file_present_outlined),
            builder: (context) => const SaveloadTestProp(),
          ),
        ],
      ),
    );
  }
}
