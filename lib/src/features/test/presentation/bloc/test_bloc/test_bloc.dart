import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(const TestInitial()) {
    on<TestEvent>(_onTestEvent);
  }

  void _onTestEvent(TestEvent event, Emitter<TestState> emit) {}
}
