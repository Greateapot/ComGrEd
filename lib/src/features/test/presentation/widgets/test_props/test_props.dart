import 'package:comgred/src/features/test/presentation/bloc/test_project_bloc/test_project_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

part 'saveload_test_prop.dart';

class TestPropData {
  final Icon icon;
  final WidgetBuilder builder;

  TestPropData({
    required this.icon,
    required this.builder,
  });
}

class TestProps extends StatefulWidget {
  const TestProps({super.key, required this.props});

  final List<TestPropData> props;

  @override
  State<TestProps> createState() => _TestPropsState();
}

class _TestPropsState extends State<TestProps> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.props.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            for (var prop in widget.props) Tab(icon: prop.icon),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (var prop in widget.props) prop.builder(context),
            ],
          ),
        ),
      ],
    );
  }
}
