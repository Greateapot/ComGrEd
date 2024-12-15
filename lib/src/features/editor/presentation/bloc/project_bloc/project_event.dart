part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

//? ----------- REBUILD -----------

final class ProjectRebuildEvent extends ProjectEvent {
  const ProjectRebuildEvent();
}

//? ----------- SAVE / LOAD / CLOSE -----------

final class ProjectSaveProjectEvent extends ProjectEvent {
  const ProjectSaveProjectEvent();
}

final class ProjectLoadProjectEvent extends ProjectEvent {
  const ProjectLoadProjectEvent();
}

final class ProjectCloseProjectEvent extends ProjectEvent {
  const ProjectCloseProjectEvent();
}

//? ----------- SELECT / UNSELECT (+ALL) -----------

final class ProjectSelectLineEvent extends ProjectEvent {
  const ProjectSelectLineEvent({required this.line});

  final Line line;

  @override
  List<Object?> get props => [line];
}

final class ProjectUnselectLineEvent extends ProjectEvent {
  const ProjectUnselectLineEvent({required this.line});

  final Line line;

  @override
  List<Object?> get props => [line];
}

final class ProjectSelectLinesEvent extends ProjectEvent {
  const ProjectSelectLinesEvent();
}

final class ProjectUnselectLinesEvent extends ProjectEvent {
  const ProjectUnselectLinesEvent();
}
