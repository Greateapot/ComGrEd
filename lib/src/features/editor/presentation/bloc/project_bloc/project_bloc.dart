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
  }

  Future<void> _onProjectSaveProjectEvent(
    ProjectSaveProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    final path = await saveFile();
    if (path == null) return;

    final file = File(path);
    final json = state.lines.map((line) => line.toJson()).toList();
    final string = jsonEncode(json);

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
    final json = jsonDecode(string) as List<dynamic>;
    final lines = json.map((json) => Line.fromJson(json)).toList();

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