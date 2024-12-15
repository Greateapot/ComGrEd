part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {
  /// lines
  final List<Line> lines;

  /// group of selected lines
  final List<Line> group;

  /// state version
  final int version;

  const ProjectState({
    required this.lines,
    required this.group,
    required this.version,
  });

  ProjectState copyWith({
    List<Line>? lines,
    List<Line>? group,
    int? version,
  });

  @override
  List<Object> get props => [lines, group, version];
}

final class ProjectInitial extends ProjectState {
  const ProjectInitial({
    required super.lines,
    required super.group,
    required super.version,
  });

  factory ProjectInitial.defaults({
    List<Line>? lines,
    List<Line>? group,
    int? version,
  }) =>
      ProjectInitial(
        lines: lines ?? List.empty(growable: true),
        group: group ?? List.empty(growable: true),
        version: version ?? -1,
      );

  @override
  ProjectInitial copyWith({
    List<Line>? lines,
    List<Line>? group,
    int? version,
  }) =>
      ProjectInitial(
        lines: lines ?? this.lines,
        group: group ?? this.group,
        version: version ?? this.version,
      );
}
