part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

//? ----------- ADD / DELETE / EDIT -----------
final class ProjectAddLineEvent extends ProjectEvent {
  const ProjectAddLineEvent({required this.line});

  final Line line;

  @override
  List<Object?> get props => [line];
}

final class ProjectAddLinesEvent extends ProjectEvent {
  const ProjectAddLinesEvent({required this.lines});

  final List<Line> lines;

  @override
  List<Object?> get props => [lines];
}

final class ProjectEditLineEvent extends ProjectEvent {
  const ProjectEditLineEvent({
    required this.oldLine,
    required this.newLine,
  });

  final Line oldLine;
  final Line newLine;

  @override
  List<Object?> get props => [oldLine, newLine];
}

final class ProjectRemoveLineEvent extends ProjectEvent {
  const ProjectRemoveLineEvent({required this.line});

  final Line line;

  @override
  List<Object?> get props => [line];
}

final class ProjectRemoveLinesEvent extends ProjectEvent {
  const ProjectRemoveLinesEvent();
}

//? ----------- REBUILD -----------

final class ProjectRebuildEvent extends ProjectEvent {
  const ProjectRebuildEvent();
}

//? ----------- SAVE / LOAD / CLOSE -----------

final class ProjectSaveProjectEvent extends ProjectEvent {
  final double distance;
  final double scale;
  final double angleX;
  final double angleY;

  final bool show;
  final bool is2d;

  const ProjectSaveProjectEvent({
    required this.distance,
    required this.scale,
    required this.angleX,
    required this.angleY,
    required this.show,
    required this.is2d,
  });

  @override
  List<Object?> get props => [distance, scale, angleX, angleY, show, is2d];
}

final class ProjectLoadProjectEvent extends ProjectEvent {
  final void Function(
    double distance,
    double scale,
    double angleX,
    double angleY,
    bool show,
    bool is2d,
  )? callback;

  const ProjectLoadProjectEvent({required this.callback});

  @override
  List<Object?> get props => [callback];
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
