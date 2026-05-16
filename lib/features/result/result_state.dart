abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultError extends ResultState {
  final String message;
  ResultError(this.message);
}

class ResultLoaded extends ResultState {
  final List<Map<String, dynamic>> pending;
  final List<Map<String, dynamic>> completed;
  final List<Map<String, dynamic>> missed; // Did not come

  ResultLoaded({
    required this.pending,
    required this.completed,
    required this.missed,
  });
}
