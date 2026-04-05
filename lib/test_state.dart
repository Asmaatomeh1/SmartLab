import 'package:appwithfirebase/model/test_model.dart';

abstract class TestState {}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestLoaded extends TestState {
  final List<TestModel> allTests;
  final List<TestModel> filteredTests;
  final List<TestModel> selectedTests;

  TestLoaded({
    required this.allTests,
    required this.filteredTests,
    required this.selectedTests,
  });
}

class TestError extends TestState {
  final String message;

  TestError(this.message);
}
