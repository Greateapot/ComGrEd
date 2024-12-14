part of 'test_project_bloc.dart';

sealed class TestProjectEvent extends Equatable {
  const TestProjectEvent();

  @override
  List<Object?> get props => [];
}

//? ----------- SAVE / LOAD / CLOSE -----------

final class TestProjectSaveProjectEvent extends TestProjectEvent {
  final String path;

  const TestProjectSaveProjectEvent({required this.path});

  @override
  List<Object?> get props => [path];
}

final class TestProjectLoadProjectEvent extends TestProjectEvent {
  final String path;

  const TestProjectLoadProjectEvent({required this.path});

  @override
  List<Object?> get props => [path];
}

final class TestProjectCloseProjectEvent extends TestProjectEvent {
  const TestProjectCloseProjectEvent();

  @override
  List<Object?> get props => [];
}

//? ----------- SELECT / UNSELECT (+ALL) -----------

final class TestProjectSelectLineEvent extends TestProjectEvent {
  const TestProjectSelectLineEvent({required this.lineId});

  final String lineId;

  @override
  List<Object?> get props => [lineId];
}

final class TestProjectUnselectLineEvent extends TestProjectEvent {
  const TestProjectUnselectLineEvent({required this.lineId});

  final String lineId;

  @override
  List<Object?> get props => [lineId];
}

final class TestProjectSelectLinesEvent extends TestProjectEvent {
  const TestProjectSelectLinesEvent();

  @override
  List<Object?> get props => [];
}

final class TestProjectUnselectLinesEvent extends TestProjectEvent {
  const TestProjectUnselectLinesEvent();

  @override
  List<Object?> get props => [];
}
