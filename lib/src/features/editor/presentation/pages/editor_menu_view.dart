import 'package:flutter/material.dart';

class EditorMenuViewData {
  final Icon icon;
  final WidgetBuilder builder;

  EditorMenuViewData({
    required this.icon,
    required this.builder,
  });
}

class EditorMenuView extends StatefulWidget {
  const EditorMenuView({super.key, required this.menus});

  final List<EditorMenuViewData> menus;

  @override
  State<EditorMenuView> createState() => _EditorMenuViewState();
}

class _EditorMenuViewState extends State<EditorMenuView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.menus.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (_tabController.index > 0) {
                  _tabController.animateTo(_tabController.index - 1);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
            Expanded(
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabAlignment: TabAlignment.start,
                tabs: [
                  for (var menu in widget.menus) Tab(icon: menu.icon),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                if (_tabController.index + 1 < _tabController.length) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (var menu in widget.menus) menu.builder(context),
            ],
          ),
        ),
      ],
    );
  }
}
