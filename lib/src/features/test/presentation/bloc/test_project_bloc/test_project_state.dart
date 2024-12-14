part of 'test_project_bloc.dart';

sealed class TestProjectState extends Equatable {
  /// lines
  final List<Line> lines;

  /// ids of selected lines (group)
  final List<String> selectedLineIds;

  /// state version
  final int version;

  const TestProjectState({
    required this.lines,
    required this.version,
    required this.selectedLineIds,
  });

  TestProjectState copyWith({
    List<Line>? lines,
    List<String>? selectedLineIds,
    int? version,
  });

  @override
  List<Object> get props => [lines, selectedLineIds, version];
}

final class TestProjectInitial extends TestProjectState {
  const TestProjectInitial({
    required super.lines,
    required super.selectedLineIds,
    required super.version,
  });

  factory TestProjectInitial.defaults({
    List<Line>? lines,
    List<String>? selectedLineIds,
    int? version,
  }) =>
      TestProjectInitial(
        lines: lines ?? List.empty(growable: true),
        selectedLineIds: selectedLineIds ?? List.empty(growable: true),
        version: version ?? -1,
      );

  @override
  TestProjectInitial copyWith({
    List<Line>? lines,
    List<String>? selectedLineIds,
    int? version,
  }) =>
      TestProjectInitial(
        lines: lines ?? this.lines,
        selectedLineIds: selectedLineIds ?? this.selectedLineIds,
        version: version ?? this.version,
      );
}
