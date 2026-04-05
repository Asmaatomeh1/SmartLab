// abstract class AppointmentState {}

// class AppointmentInitial extends AppointmentState {}

// class AppointmentLoading extends AppointmentState {}

// class AppointmentSlotsLoaded extends AppointmentState {
//   final List<DateTime> days;
//   final DateTime selectedDate;
//   final List<String> availableSlots;
//   final String? selectedTime;

//   AppointmentSlotsLoaded({
//     required this.days,
//     required this.selectedDate,
//     required this.availableSlots,
//     this.selectedTime,
//   });
// }

// // class AppointmentAdd extends AppointmentState {}

// class AppointmentEdit extends AppointmentState {
//   final String appointmentId;
//   AppointmentEdit(this.appointmentId);
// }

// class AppointmentBookingSuccess extends AppointmentState {}

// class AppointmentDeleteSuccess extends AppointmentState {}

// class AppointmentError extends AppointmentState {
//   final String message;
//   AppointmentError(this.message);
// }

// appointment_state.dart
abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSlotsLoaded extends AppointmentState {
  final List<DateTime> days;
  final DateTime selectedDate;
  final List<String> availableSlots;
  final String? selectedTime;

  AppointmentSlotsLoaded({
    required this.days,
    required this.selectedDate,
    required this.availableSlots,
    this.selectedTime,
  });
}

class AppointmentEdit extends AppointmentState {
  final String appointmentId;
  AppointmentEdit(this.appointmentId);
}

class AppointmentBookingSuccess extends AppointmentState {}

class AppointmentDeleteSuccess extends AppointmentState {}

class AppointmentError extends AppointmentState {
  final String message;
  AppointmentError(this.message);
}
