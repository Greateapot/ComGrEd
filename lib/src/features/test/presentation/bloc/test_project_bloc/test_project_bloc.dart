import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/test/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'test_project_event.dart';
part 'test_project_state.dart';

class TestProjectBloc extends Bloc<TestProjectEvent, TestProjectState> {
  TestProjectBloc() : super(TestProjectInitial.defaults()) {
    on<TestProjectSaveProjectEvent>(_onTestProjectSaveProjectEvent);
    on<TestProjectLoadProjectEvent>(_onTestProjectLoadProjectEvent);
    on<TestProjectCloseProjectEvent>(_onTestProjectCloseProjectEvent);
    on<TestProjectSelectLineEvent>(_onTestProjectSelectLineEvent);
    on<TestProjectUnselectLineEvent>(_onTestProjectUnselectLineEvent);
    on<TestProjectSelectLinesEvent>(_onTestProjectSelectLinesEvent);
    on<TestProjectUnselectLinesEvent>(_onTestProjectUnselectLinesEvent);
  }

  Future<void> _onTestProjectSaveProjectEvent(
    TestProjectSaveProjectEvent event,
    Emitter<TestProjectState> emit,
  ) async {
    final file = File(event.path);
    final json = state.lines.map((line) => line.toJson()).toList();
    final string = jsonEncode(json);

    await file.writeAsString(string);
  }

  Future<void> _onTestProjectLoadProjectEvent(
    TestProjectLoadProjectEvent event,
    Emitter<TestProjectState> emit,
  ) async {
    final file = File(event.path);

    assert(await file.exists());

    final string = await file.readAsString();
    final json = jsonDecode(string) as List<dynamic>;
    final lines = json.map((json) => Line.fromJson(json)).toList();

    emit(TestProjectInitial.defaults(
      lines: lines,
      selectedLineIds: List.empty(growable: true),
      version: state.version + 1,
    ));
  }

  void _onTestProjectCloseProjectEvent(
    TestProjectCloseProjectEvent event,
    Emitter<TestProjectState> emit,
  ) {
    if (state.lines.isEmpty) return;

    emit(TestProjectInitial.defaults(version: state.version + 1));
  }

  void _onTestProjectSelectLineEvent(
    TestProjectSelectLineEvent event,
    Emitter<TestProjectState> emit,
  ) {
    if (state.selectedLineIds.contains(event.lineId)) return;
    state.selectedLineIds.add(event.lineId);
    emit(state.copyWith(version: state.version + 1));
  }

  void _onTestProjectUnselectLineEvent(
    TestProjectUnselectLineEvent event,
    Emitter<TestProjectState> emit,
  ) {
    if (!state.selectedLineIds.contains(event.lineId)) return;
    state.selectedLineIds.remove(event.lineId);
    emit(state.copyWith(version: state.version + 1));
  }

  void _onTestProjectSelectLinesEvent(
    TestProjectSelectLinesEvent event,
    Emitter<TestProjectState> emit,
  ) {
    if (state.selectedLineIds.length == state.lines.length) return;
    state.selectedLineIds
      ..clear()
      ..addAll(state.lines.map((line) => line.id));

    emit(state.copyWith(version: state.version + 1));
  }

  void _onTestProjectUnselectLinesEvent(
    TestProjectUnselectLinesEvent event,
    Emitter<TestProjectState> emit,
  ) {
    if (state.selectedLineIds.isEmpty) return;
    state.selectedLineIds.clear();

    emit(state.copyWith(version: state.version + 1));
  }
}
