import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial.defaults()) {
    on<ProjectSaveProjectEvent>(_onProjectSaveProjectEvent);
    on<ProjectLoadProjectEvent>(_onProjectLoadProjectEvent);
    on<ProjectCloseProjectEvent>(_onProjectCloseProjectEvent);
    on<ProjectSelectLineEvent>(_onProjectSelectLineEvent);
    on<ProjectUnselectLineEvent>(_onProjectUnselectLineEvent);
    on<ProjectSelectLinesEvent>(_onProjectSelectLinesEvent);
    on<ProjectUnselectLinesEvent>(_onProjectUnselectLinesEvent);
    on<ProjectRebuildEvent>(_onProjectRebuildEvent);

    on<ProjectAddLineEvent>(_onProjectAddLineEvent);
    on<ProjectAddLinesEvent>(_onProjectAddLinesEvent);
    on<ProjectRemoveLineEvent>(_onProjectRemoveLineEvent);
    on<ProjectRemoveLinesEvent>(_onProjectRemoveLinesEvent);
    on<ProjectEditLineEvent>(_onProjectEditLineEvent);
  }

  void _onProjectAddLineEvent(
    ProjectAddLineEvent event,
    Emitter<ProjectState> emit,
  ) {
    final Line line = Line(
      firstPoint: Point(
        x: event.line.firstPoint.x,
        y: event.line.firstPoint.y,
        z: event.line.firstPoint.z,
      ),
      lastPoint: Point(
        x: event.line.lastPoint.x,
        y: event.line.lastPoint.y,
        z: event.line.lastPoint.z,
      ),
    );

    state.lines.add(line);

    add(const ProjectRebuildEvent());
  }

  void _onProjectAddLinesEvent(
    ProjectAddLinesEvent event,
    Emitter<ProjectState> emit,
  ) {
    state.lines.addAll(event.lines);

    add(const ProjectRebuildEvent());
  }

  void _onProjectRemoveLineEvent(
    ProjectRemoveLineEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (!state.lines.contains(event.line)) return;

    state.lines.remove(event.line);
    add(const ProjectRebuildEvent());
  }

  void _onProjectRemoveLinesEvent(
    ProjectRemoveLinesEvent event,
    Emitter<ProjectState> emit,
  ) {
    for (var line in state.group) {
      state.lines.remove(line);
    }
    state.group.clear();
    add(const ProjectRebuildEvent());
  }

  void _onProjectEditLineEvent(
    ProjectEditLineEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (!state.lines.contains(event.oldLine)) return;

    event.oldLine.firstPoint.x = event.newLine.firstPoint.x;
    event.oldLine.firstPoint.y = event.newLine.firstPoint.y;
    event.oldLine.firstPoint.z = event.newLine.firstPoint.z;
    event.oldLine.lastPoint.x = event.newLine.lastPoint.x;
    event.oldLine.lastPoint.y = event.newLine.lastPoint.y;
    event.oldLine.lastPoint.z = event.newLine.lastPoint.z;

    add(const ProjectRebuildEvent());
  }

  Future<void> _onProjectSaveProjectEvent(
    ProjectSaveProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    final path = await saveFile();
    if (path == null) return;

    final file = File(path);
    final json = state.lines.map((line) => line.toJson()).toList();
    final Map<String, dynamic> data = {
      'lines': json,
      'distance': event.distance,
      'scale': event.scale,
      'angleX': event.angleX,
      'angleY': event.angleY,
      'show': event.show,
      'is2d': event.is2d,
    };
    final string = jsonEncode(data);

    await file.writeAsString(string);
  }

  Future<void> _onProjectLoadProjectEvent(
    ProjectLoadProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    final path = await loadFile();
    if (path == null) return;

    final file = File(path);

    assert(await file.exists());

    final string = await file.readAsString();
    final data = jsonDecode(string) as Map<String, dynamic>;
    final json = data['lines'] as List<dynamic>;
    final lines = json.map((json) => Line.fromJson(json)).toList();

    if (event.callback != null) {
      event.callback!(
        data['angleX'],
        data['angleY'],
        data['distance'],
        data['scale'],
        data['show'],
        data['is2d'],
      );
    }

    emit(ProjectInitial.defaults(
      lines: lines,
      group: List.empty(growable: true),
      version: state.version + 1,
    ));
  }

  void _onProjectCloseProjectEvent(
    ProjectCloseProjectEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (state.lines.isEmpty) return;

    emit(ProjectInitial.defaults(version: state.version + 1));
  }

  void _onProjectSelectLineEvent(
    ProjectSelectLineEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (state.group.contains(event.line)) return;
    state.group.add(event.line);
    emit(state.copyWith(version: state.version + 1));
  }

  void _onProjectUnselectLineEvent(
    ProjectUnselectLineEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (!state.group.contains(event.line)) return;
    state.group.remove(event.line);
    emit(state.copyWith(version: state.version + 1));
  }

  void _onProjectSelectLinesEvent(
    ProjectSelectLinesEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (state.group.length == state.lines.length) return;
    state.group
      ..clear()
      ..addAll(state.lines);

    emit(state.copyWith(version: state.version + 1));
  }

  void _onProjectUnselectLinesEvent(
    ProjectUnselectLinesEvent event,
    Emitter<ProjectState> emit,
  ) {
    if (state.group.isEmpty) return;
    state.group.clear();

    emit(state.copyWith(version: state.version + 1));
  }

  void _onProjectRebuildEvent(
    ProjectRebuildEvent event,
    Emitter<ProjectState> emit,
  ) {
    emit(state.copyWith(version: state.version + 1));
  }

  Future<String?> saveFile() async {
    final initialDirectory = await getApplicationDocumentsDirectory();

    String? result = await FilePicker.platform.saveFile(
      fileName: '${DateTime.now().millisecondsSinceEpoch}.json',
      dialogTitle: 'Please select an output file:',
      type: FileType.custom,
      allowedExtensions: ['json'],
      initialDirectory: initialDirectory.path,
      lockParentWindow: true,
    );

    if (result == null) return null;
    if (!result.endsWith('.json')) result += '.json';
    return result;
  }

  Future<String?> loadFile() async {
    final initialDirectory = await getApplicationDocumentsDirectory();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please select an input file:',
      type: FileType.custom,
      allowedExtensions: ['json'],
      initialDirectory: initialDirectory.path,
      lockParentWindow: true,
    );

    return result?.files.single.path;
  }
}
