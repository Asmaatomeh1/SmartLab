// import 'dart:math';

// import 'package:appwithfirebase/appointment_state.dart';
// import 'package:appwithfirebase/model/test_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // class AppointmentCubit extends Cubit<AppointmentState> {
// //   AppointmentCubit() : super(AppointmentInitial());

// //   List<DateTime> _days = [];
// //   DateTime? _selectedDate;
// //   String? _selectedTime;

// //   void initialize() {
// //     _days = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
// //     _selectedDate = _days.first;
// //     fetchSlots(_selectedDate!);
// //   }

// //   void selectDate(DateTime date) {
// //     _selectedDate = date;
// //     _selectedTime = null;
// //     fetchSlots(date);
// //   }

// //   void selectTime(String time) {
// //     if (state is AppointmentSlotsLoaded) {
// //       _selectedTime = time;
// //       final curr = state as AppointmentSlotsLoaded;
// //       emit(
// //         AppointmentSlotsLoaded(
// //           days: _days,
// //           selectedDate: _selectedDate!,
// //           availableSlots: curr.availableSlots,
// //           selectedTime: time,
// //         ),
// //       );
// //     }
// //   }

// //   Future<void> fetchSlots(DateTime date) async {
// //     emit(AppointmentLoading());
// //     try {
// //       final dateString = date.toString().substring(0, 10);
// //       final snapshot = await FirebaseFirestore.instance
// //           .collection("appointments")
// //           .where("date", isEqualTo: dateString)
// //           .get();

// //       Map<String, int> counts = {};
// //       for (var doc in snapshot.docs) {
// //         String time = doc["time"];
// //         counts[time] = (counts[time] ?? 0) + 1;
// //       }

// //       List<String> allSlots = _generateSlots(date);
// //       int capacity = 10;

// //       final available = allSlots
// //           .where((s) => (counts[s] ?? 0) < capacity)
// //           .toList();

// //       emit(
// //         AppointmentSlotsLoaded(
// //           days: _days,
// //           selectedDate: _selectedDate!,
// //           availableSlots: available,
// //           selectedTime: _selectedTime,
// //         ),
// //       );
// //     } catch (e) {
// //       emit(AppointmentError("Failed to load slots"));
// //     }
// //   }

// //   List<String> _generateSlots(DateTime forDate) {
// //     List<String> allSlots = [];
// //     for (int h = 8; h < 17; h++) {
// //       allSlots.add("$h:00");
// //       allSlots.add("$h:30");
// //     }
// //     final now = DateTime.now();
// //     if (forDate.day != now.day) return allSlots;

// //     return allSlots.where((slot) {
// //       final parts = slot.split(':');
// //       final hour = int.parse(parts[0]);
// //       return hour > now.hour;
// //     }).toList();
// //   }

// //   Future<void> book(String testId) async {
// //     final uid = FirebaseAuth.instance.currentUser?.uid;
// //     if (uid == null || _selectedDate == null || _selectedTime == null) return;

// //     emit(AppointmentLoading());
// //     try {
// //       await FirebaseFirestore.instance.collection("appointments").add({
// //         "patientId": uid,
// //         "testId": testId,
// //         "date": _selectedDate!.toString().substring(0, 10),
// //         "time": _selectedTime,
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });
// //       emit(AppointmentBookingSuccess());
// //       // Refresh after booking
// //       fetchSlots(_selectedDate!);
// //     } catch (e) {
// //       emit(AppointmentError("Booking failed"));
// //     }
// //   }
// // }

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // --- States ---
// // abstract class AppointmentState {}

// // class AppointmentInitial extends AppointmentState {}

// // class AppointmentLoading extends AppointmentState {}

// // class AppointmentBookingSuccess extends AppointmentState {}

// // class AppointmentError extends AppointmentState {
// //   final String message;
// //   AppointmentError(this.message);
// // }

// // class AppointmentSlotsLoaded extends AppointmentState {
// //   final List<DateTime> days;
// //   final DateTime selectedDate;
// //   final List<String> availableSlots;
// //   final String? selectedTime;

// //   AppointmentSlotsLoaded({
// //     required this.days,
// //     required this.selectedDate,
// //     required this.availableSlots,
// //     this.selectedTime,
// //   });
// // }

// // --- Cubit ---
// class AppointmentCubit extends Cubit<AppointmentState> {
//   AppointmentCubit() : super(AppointmentInitial());

//   List<DateTime> _days = [];
//   DateTime? _selectedDate;
//   String? _selectedTime;
//   //String? _appointmentId; // For editing existing appointments
//   get selectedDate => _selectedDate;
//   get selectedTime => _selectedTime;

//   void initialize() {
//     _days = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
//     _selectedDate = _days.first;
//     fetchSlots(_selectedDate!);
//   }

//   void selectDate(DateTime date) {
//     _selectedDate = date;
//     _selectedTime = null;
//     fetchSlots(date);
//   }

//   void selectTime(String time) {
//     if (state is AppointmentSlotsLoaded) {
//       _selectedTime = time;
//       final curr = state as AppointmentSlotsLoaded;
//       emit(
//         AppointmentSlotsLoaded(
//           days: _days,
//           selectedDate: _selectedDate!,
//           availableSlots: curr.availableSlots,
//           selectedTime: time,
//         ),
//       );
//     }
//   }

//   Future<void> fetchSlots(DateTime date) async {
//     emit(AppointmentLoading());
//     try {
//       final dateString = date.toString().substring(0, 10);
//       final snapshot = await FirebaseFirestore.instance
//           .collection("appointments")
//           .where("date", isEqualTo: dateString)
//           .get();

//       Map<String, int> counts = {};
//       for (var doc in snapshot.docs) {
//         String time = doc["time"];
//         counts[time] = (counts[time] ?? 0) + 1;
//       }

//       List<String> allSlots = _generateSlots(date);
//       // Only show slots that have less than 10 people
//       final available = allSlots.where((s) => (counts[s] ?? 0) < 10).toList();

//       emit(
//         AppointmentSlotsLoaded(
//           days: _days,
//           selectedDate: _selectedDate!,
//           availableSlots: available,
//           selectedTime: _selectedTime,
//         ),
//       );
//     } catch (e) {
//       emit(AppointmentError("Failed to load slots: $e"));
//     }
//   }

//   List<String> _generateSlots(DateTime forDate) {
//     List<String> slots = [];
//     for (int h = 8; h < 17; h++) {
//       slots.add("$h:00");
//       slots.add("$h:30");
//     }
//     final now = DateTime.now();
//     if (forDate.day == now.day) {
//       return slots.where((s) => int.parse(s.split(':')[0]) > now.hour).toList();
//     }
//     return slots;
//   }

//   // TRANSACTION LOGIC HERE
//   // Future<void> book(String testId) async {
//   //   final uid = FirebaseAuth.instance.currentUser?.uid;
//   //   if (uid == null || _selectedDate == null || _selectedTime == null) return;

//   //   emit(AppointmentLoading());
//   //   try {
//   //     final String dateStr = _selectedDate!.toString().substring(0, 10);
//   //     final String timeStr = _selectedTime!;

//   //     await FirebaseFirestore.instance.runTransaction((transaction) async {
//   //       // Query current count for this specific slot
//   //       QuerySnapshot currentUsage = await FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .where("date", isEqualTo: dateStr)
//   //           .where("time", isEqualTo: timeStr)
//   //           .get();

//   //       if (currentUsage.docs.length >= 10) {
//   //         throw Exception("SLOT_FULL");
//   //       }

//   //       DocumentReference newDoc = FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .doc();
//   //       transaction.set(newDoc, {
//   //         "patientId": uid,
//   //         "testId": testId,
//   //         "date": dateStr,
//   //         "time": timeStr,
//   //         "createdAt": FieldValue.serverTimestamp(),
//   //       });
//   //     });

//   //     emit(AppointmentBookingSuccess());
//   //     fetchSlots(_selectedDate!);
//   //   } catch (e) {
//   //     if (e.toString().contains("SLOT_FULL")) {
//   //       emit(
//   //         AppointmentError(
//   //           "Sorry, this slot just reached its limit of 10 people!",
//   //         ),
//   //       );
//   //     } else {
//   //       emit(AppointmentError("Booking error: ${e.toString()}"));
//   //     }
//   //   }
//   // }
//   // Inside AppointmentCubit

//   Future<void> book({
//     required List<TestModel> selectedTests,
//     required double totalAmount,
//   }) async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null || _selectedDate == null || _selectedTime == null) {
//       emit(
//         AppointmentError(
//           "User not authenticated or appointment details missing",
//         ),
//       );
//       return;
//     }
//     if (selectedTests.isEmpty) {
//       emit(AppointmentError("Please select at least one test before booking."));
//       return;
//     }
//     // print(
//     //   "Attempting to book appointment for user $appointmentId on ${_selectedDate.toString().substring(0, 10)} at ${_selectedTime}",
//     // );
//     emit(AppointmentLoading());

//     try {
//       final String dateStr = _selectedDate!.toString().substring(0, 10);
//       final String timeStr = _selectedTime!;

//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         // 1. Check Capacity (The 10-person limit)
//         QuerySnapshot currentUsage = await FirebaseFirestore.instance
//             .collection("appointments")
//             .where("date", isEqualTo: dateStr)
//             .where("time", isEqualTo: timeStr)
//             .get();

//         if (currentUsage.docs.length >= 10) {
//           throw Exception("SLOT_FULL");
//         }

//         // 2. Prepare the list of tests to store as a "Sub-list"
//         List<Map<String, dynamic>> testDataList = selectedTests
//             .map(
//               (test) => {
//                 "testId": test.id,
//                 "testName": test.name,
//                 "priceAtBooking": test.price,
//               },
//             )
//             .toList();

//         // 3. Create the Appointment Document
//         DocumentReference apptRef = FirebaseFirestore.instance
//             .collection("appointments")
//             .doc();

//         transaction.set(apptRef, {
//           "appointmentId": apptRef.id,
//           // Use provided ID or auto-generated one
//           "patientId": uid,
//           "totalPrice": totalAmount,
//           "date": dateStr,
//           "time": timeStr,
//           "status": "pending",
//           "selectedTests":
//               testDataList, // <--- This is your "Sub-list" of tests
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//       });

//       emit(AppointmentBookingSuccess());
//       fetchSlots(_selectedDate!); // Refresh slots after booking
//     } catch (e) {
//       if (e.toString().contains("SLOT_FULL")) {
//         emit(
//           AppointmentError(
//             "Sorry, this slot just reached its limit of 10 people!",
//           ),
//         );
//       } else {
//         emit(AppointmentError("Booking error: ${e.toString()}"));
//       }
//     }
//   }

//   setInitialSelection(String appointmentId) {
//     FirebaseFirestore.instance
//         .collection("appointments")
//         .doc(appointmentId)
//         .get()
//         .then((doc) {
//           if (doc.exists) {
//             final data = doc.data()!;
//             _selectedDate = DateTime.parse(data['date']);
//             _selectedTime = data['time'];
//             fetchSlots(_selectedDate!);
//           }
//         });
//   }

//   Future<void> editAppointment({
//     required String appointmentId,
//     required List<TestModel> selectedTests,
//     required double totalAmount,
//   }) async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null || _selectedDate == null || _selectedTime == null) {
//       emit(
//         AppointmentError(
//           "User not authenticated or appointment details missing",
//         ),
//       );
//       return;
//     }
//     if (selectedTests.isEmpty) {
//       emit(AppointmentError("Please select at least one test before booking."));
//       return;
//     }
//     // print(
//     //   "Attempting to book appointment for user $appointmentId on ${_selectedDate.toString().substring(0, 10)} at ${_selectedTime}",
//     // );
//     emit(AppointmentLoading());

//     try {
//       final String dateStr = _selectedDate!.toString().substring(0, 10);
//       final String timeStr = _selectedTime!;

//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         // 1. Check Capacity (The 10-person limit)
//         QuerySnapshot currentUsage = await FirebaseFirestore.instance
//             .collection("appointments")
//             .where("date", isEqualTo: dateStr)
//             .where("time", isEqualTo: timeStr)
//             .get();

//         if (currentUsage.docs.length >= 10) {
//           throw Exception("SLOT_FULL");
//         }

//         // 2. Prepare the list of tests to store as a "Sub-list"
//         List<Map<String, dynamic>> testDataList = selectedTests
//             .map(
//               (test) => {
//                 "testId": test.id,
//                 "testName": test.name,
//                 "priceAtBooking": test.price,
//               },
//             )
//             .toList();

//         // 3. Create the Appointment Document
//         FirebaseFirestore.instance
//             .collection("appointments")
//             .doc(appointmentId)
//             .update({
//               "patientId": uid,
//               "totalPrice": totalAmount,
//               "date": dateStr,
//               "time": timeStr,
//               "status": "pending",
//               "selectedTests":
//                   testDataList, // <--- This is your "Sub-list" of tests
//               "createdAt": FieldValue.serverTimestamp(),
//             });
//       });

//       emit(AppointmentBookingSuccess());
//       fetchSlots(_selectedDate!); // Refresh slots after booking
//     } catch (e) {
//       if (e.toString().contains("SLOT_FULL")) {
//         emit(
//           AppointmentError(
//             "Sorry, this slot just reached its limit of 10 people!",
//           ),
//         );
//       } else {
//         emit(AppointmentError("Booking error: ${e.toString()}"));
//       }
//     }
//   }

//   // editAppointment({
//   //   required String appointmentId,
//   //   required List<TestModel> selectedTests,
//   //   required double totalAmount,
//   // }) async {
//   //   final uid = FirebaseAuth.instance.currentUser?.uid;
//   //   if (uid == null || _selectedDate == null || _selectedTime == null) {
//   //     emit(
//   //       AppointmentError(
//   //         "User not authenticated or appointment details missing",
//   //       ),
//   //     );
//   //     return;
//   //   }
//   //   if (selectedTests.isEmpty) {
//   //     emit(AppointmentError("Please select at least one test before booking."));
//   //     return;
//   //   }

//   //   emit(AppointmentLoading());

//   //   try {
//   //     final String dateStr = _selectedDate!.toString().substring(0, 10);
//   //     final String timeStr = _selectedTime!;

//   //     await FirebaseFirestore.instance.((transaction) async {
//   //       // 1. Check Capacity (The 10-person limit)
//   //       QuerySnapshot currentUsage = await FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .where("date", isEqualTo: dateStr)
//   //           .where("time", isEqualTo: timeStr)
//   //           .get();

//   //       if (currentUsage.docs.length >= 10) {
//   //         throw Exception("SLOT_FULL");
//   //       }

//   //       // 2. Prepare the list of tests to store as a "Sub-list"
//   //       List<Map<String, dynamic>> testDataList = selectedTests
//   //           .map(
//   //             (test) => {
//   //               "testId": test.id,
//   //               "testName": test.name,
//   //               "priceAtBooking": test.price,
//   //             },
//   //           )
//   //           .toList();

//   //       // 3. Create the Appointment Document
//   //       print("Editing appointment with ID: $appointmentId");
//   //       DocumentReference apptRef = FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .doc(appointmentId);
//   //       apptRef.update({
//   //         "patientId": uid,
//   //         "totalPrice": totalAmount,
//   //         "date": dateStr,
//   //         "time": timeStr,
//   //         "status": "pending",
//   //         "selectedTests":
//   //             testDataList, // <--- This is your "Sub-list" of tests
//   //         "createdAt": FieldValue.serverTimestamp(),
//   //       });
//   //     });

//   //     emit(AppointmentBookingSuccess());
//   //     fetchSlots(_selectedDate!); // Refresh slots after booking
//   //   } catch (e) {
//   //     if (e.toString().contains("SLOT_FULL")) {
//   //       emit(
//   //         AppointmentError(
//   //           "Sorry, this slot just reached its limit of 10 people!",
//   //         ),
//   //       );
//   //     } else {
//   //       emit(AppointmentError("Booking error: ${e.toString()}"));
//   //     }
//   //   }
//   // }

//   // Future<void> editAppointment({

//   // }) async {
//   //   // _appointmentId = AppointmentEdit().appointmentId;
//   //   print('sdfghjkliuytrewertyuioiuyfdsdfghjkl;');
//   //   var uid = FirebaseAuth.instance.currentUser?.uid;

//   //   // Basic Validation
//   //   if (uid == null || _selectedDate == null || _selectedTime == null) {
//   //     // uid = appointmentId;
//   //     // _selectedDate = selectedDate;
//   //     // _selectedTime = selectedTime;
//   //     emit(
//   //       AppointmentError(
//   //         "User not authenticated or appointment details missing",
//   //       ),
//   //     );

//   //     return;
//   //   }
//   //   if (selectedTests.isEmpty) {
//   //     emit(AppointmentError("Please select at least one test."));
//   //     return;
//   //   }

//   //   emit(AppointmentLoading());
//   //   print(
//   //     "Attempting to edit appointment $appointmentId for user $uid on ${_selectedDate.toString().substring(0, 10)} at ${_selectedTime}",
//   //   );
//   //   try {
//   //     final String dateStr = _selectedDate!.toString().substring(0, 10);
//   //     final String timeStr = _selectedTime!;

//   //     await FirebaseFirestore.instance.runTransaction((transaction) async {
//   //       // 1. Check Capacity (Excluding the current appointment)
//   //       QuerySnapshot currentUsage = await FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .where("date", isEqualTo: dateStr)
//   //           .where("time", isEqualTo: timeStr)
//   //           .get();

//   //       // Filter out the appointment we are currently editing from the count
//   //       int participants = currentUsage.docs
//   //           .where((doc) => doc.id != appointmentId)
//   //           .length;

//   //       if (participants >= 10) {
//   //         throw Exception("SLOT_FULL");
//   //       }

//   //       // 2. Prepare the test sub-list
//   //       List<Map<String, dynamic>> testDataList = selectedTests
//   //           .map(
//   //             (test) => {
//   //               "testId": test.id,
//   //               "testName": test.name,
//   //               "priceAtBooking": test.price,
//   //             },
//   //           )
//   //           .toList();

//   //       // 3. Update the Document within the transaction
//   //       DocumentReference apptRef = FirebaseFirestore.instance
//   //           .collection("appointments")
//   //           .doc(appointmentId);

//   //       transaction.update(apptRef, {
//   //         "totalPrice": totalAmount,
//   //         "date": dateStr,
//   //         "time": timeStr,
//   //         "status": "pending", // Reset status to pending if it was missed
//   //         "selectedTests": testDataList,
//   //         "lastModifiedAt":
//   //             FieldValue.serverTimestamp(), // Better for tracking edits
//   //       });
//   //     });

//   //     emit(AppointmentBookingSuccess());
//   //     fetchSlots(_selectedDate!);
//   //   } catch (e) {
//   //     if (e.toString().contains("SLOT_FULL")) {
//   //       emit(AppointmentError("Sorry, this slot is now full (10 people max)."));
//   //     } else {
//   //       emit(AppointmentError("Edit failed: ${e.toString()}"));
//   //     }
//   //   }
//   // }

//   Future<void> deleteAppointment(String appointmentId) async {
//     emit(AppointmentLoading());
//     try {
//       await FirebaseFirestore.instance
//           .collection("appointments")
//           .doc(appointmentId)
//           .delete();
//       emit(AppointmentDeleteSuccess());
//     } catch (e) {
//       emit(AppointmentError("Delete failed: ${e.toString()}"));
//     }
//   }
//   // // initializeForEdit({
//   //   required String appointmentId,
//   //   required List<TestModel> selectedTests,
//   //   required double totalAmount,
//   //   required DateTime selectedDate,
//   //   required String selectedTime,
//   // }) {
//   //   _appointmentId = appointmentId;
//   //   _selectedDate = selectedDate;
//   //   _selectedTime = selectedTime;
//   //   _selectedTests = selectedTests;
//   //   _totalAmount = totalAmount;
//   //   emit(AppointmentSlotsLoaded(days: [], selectedDate: selectedDate, availableSlots: []));
//   // }
//   // Future<void> startAddAppointment() async {
//   //   // _selectedDate = null;
//   //   // _selectedTime = null;
//   //   //initialize();
//   //   emit(AppointmentAdd());
//   // }

//   Future<void> startEditAppointment(String appointmentId) async {
//     // _selectedDate = null;
//     // _selectedTime = null;
//     // initialize();
//     // _appointmentId = appointmentId;
//     emit(AppointmentEdit(appointmentId));
//   }

//   resetSelection() {
//     _selectedDate = null;
//     _selectedTime = null;
//     //initialize();
//   }
// }

// appointment_cubit.dart
import 'package:appwithfirebase/appointment/appointment_state.dart';
import 'package:appwithfirebase/model/test_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  List<DateTime> _days = [];
  DateTime? _selectedDate;
  String? _selectedTime;

  DateTime? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;

  // ─── Initialization ──────────────────────────────────────────────────────────

  void initialize() {
    _days = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
    _selectedDate = _days.first;
    fetchSlots(_selectedDate!);
  }

  /// Load existing appointment data into the cubit for editing.
  Future<void> setInitialSelection(String appointmentId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final date = DateTime.parse(data['date'] as String);
        _selectedDate = date;
        _selectedTime = data['time'] as String?;
        // Re-generate the 7-day window anchored to the appointment date
        // so the selected date is always visible in the list.
        _days = List.generate(7, (i) => date.add(Duration(days: i - 0)));
        await fetchSlots(_selectedDate!);
      }
    } catch (e) {
      emit(AppointmentError('Failed to load appointment: $e'));
    }
  }

  // ─── Date / Time Selection ───────────────────────────────────────────────────

  void selectDate(DateTime date) {
    _selectedDate = date;
    _selectedTime = null;
    fetchSlots(date);
  }

  void selectTime(String time) {
    if (state is AppointmentSlotsLoaded) {
      _selectedTime = time;
      final curr = state as AppointmentSlotsLoaded;
      emit(
        AppointmentSlotsLoaded(
          days: _days,
          selectedDate: _selectedDate!,
          availableSlots: curr.availableSlots,
          selectedTime: time,
        ),
      );
    }
  }

  void resetSelection() {
    _selectedDate = null;
    _selectedTime = null;
  }

  // ─── Slot Fetching ───────────────────────────────────────────────────────────

  Future<void> fetchSlots(DateTime date) async {
    emit(AppointmentLoading());
    try {
      final dateString = _dateString(date);
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('date', isEqualTo: dateString)
          .get();

      final Map<String, int> counts = {};
      for (final doc in snapshot.docs) {
        final time = doc['time'] as String;
        counts[time] = (counts[time] ?? 0) + 1;
      }

      final available = _generateSlots(
        date,
      ).where((s) => (counts[s] ?? 0) < 10).toList();

      emit(
        AppointmentSlotsLoaded(
          days: _days,
          selectedDate: _selectedDate!,
          availableSlots: available,
          selectedTime: _selectedTime,
        ),
      );
    } catch (e) {
      emit(AppointmentError('Failed to load slots: $e'));
    }
  }

  /// FIX: Filter by both hour AND minute so slots in the current hour
  /// that are still in the future are included.
  List<String> _generateSlots(DateTime forDate) {
    final slots = <String>[];
    for (int h = 8; h < 17; h++) {
      slots.add('$h:00');
      slots.add('$h:30');
    }

    final now = DateTime.now();
    final isToday =
        forDate.year == now.year &&
        forDate.month == now.month &&
        forDate.day == now.day;

    if (!isToday) return slots;

    return slots.where((slot) {
      final parts = slot.split(':');
      final h = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      return h > now.hour || (h == now.hour && m > now.minute);
    }).toList();
  }

  // ─── Book (New Appointment) ──────────────────────────────────────────────────

  Future<void> book({
    required List<TestModel> selectedTests,
    required double totalAmount,
  }) async {
    if (!_validateBeforeWrite(selectedTests)) return;

    emit(AppointmentLoading());

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final dateStr = _dateString(_selectedDate!);
    final timeStr = _selectedTime!;

    try {
      await FirebaseFirestore.instance.runTransaction((tx) async {
        final usage = await _slotUsage(dateStr, timeStr);
        if (usage >= 10) throw Exception('SLOT_FULL');

        final ref = FirebaseFirestore.instance.collection('appointments').doc();

        tx.set(ref, {
          'appointmentId': ref.id,
          'patientId': uid,
          'totalPrice': totalAmount,
          'date': dateStr,
          'time': timeStr,
          'status': 'pending',
          'selectedTests': _testDataList(selectedTests),
          'createdAt': FieldValue.serverTimestamp(),
        });
      });

      emit(AppointmentBookingSuccess());
      fetchSlots(_selectedDate!);
    } catch (e) {
      emit(AppointmentError(_friendlyError(e)));
    }
  }

  // ─── Edit (Existing Appointment) ────────────────────────────────────────────

  /// FIX: Uses transaction.update so the write is atomic.
  /// FIX: Excludes the current appointment from the capacity check.
  Future<void> editAppointment({
    required String appointmentId,
    required List<TestModel> selectedTests,
    required double totalAmount,
  }) async {
    if (!_validateBeforeWrite(selectedTests)) return;

    emit(AppointmentLoading());

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final dateStr = _dateString(_selectedDate!);
    final timeStr = _selectedTime!;

    try {
      await FirebaseFirestore.instance.runTransaction((tx) async {
        // Exclude this appointment from the capacity count so editing to the
        // same slot doesn't falsely hit the limit.
        final usage = await _slotUsage(
          dateStr,
          timeStr,
          excludeId: appointmentId,
        );
        if (usage >= 10) throw Exception('SLOT_FULL');

        final ref = FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointmentId);

        tx.update(ref, {
          'patientId': uid,
          'totalPrice': totalAmount,
          'date': dateStr,
          'time': timeStr,
          'status': 'pending',
          'selectedTests': _testDataList(selectedTests),
          'lastModifiedAt': FieldValue.serverTimestamp(),
        });
      });

      emit(AppointmentBookingSuccess());
      fetchSlots(_selectedDate!);
    } catch (e) {
      emit(AppointmentError(_friendlyError(e)));
    }
  }

  // ─── Delete ──────────────────────────────────────────────────────────────────

  Future<void> deleteAppointment(String appointmentId) async {
    emit(AppointmentLoading());
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .delete();
      emit(AppointmentDeleteSuccess());
    } catch (e) {
      emit(AppointmentError('Delete failed: $e'));
    }
  }

  Future<void> startEditAppointment(String appointmentId) async {
    emit(AppointmentEdit(appointmentId));
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────────

  bool _validateBeforeWrite(List<TestModel> selectedTests) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || _selectedDate == null || _selectedTime == null) {
      emit(
        AppointmentError(
          'User not authenticated or appointment details missing.',
        ),
      );
      return false;
    }
    if (selectedTests.isEmpty) {
      emit(AppointmentError('Please select at least one test before booking.'));
      return false;
    }
    return true;
  }

  Future<int> _slotUsage(
    String dateStr,
    String timeStr, {
    String? excludeId,
  }) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: dateStr)
        .where('time', isEqualTo: timeStr)
        .get();

    if (excludeId == null) return snapshot.docs.length;
    return snapshot.docs.where((d) => d.id != excludeId).length;
  }

  List<Map<String, dynamic>> _testDataList(List<TestModel> tests) => tests
      .map(
        (t) => {'testId': t.id, 'testName': t.name, 'priceAtBooking': t.price},
      )
      .toList();

  String _dateString(DateTime d) => d.toIso8601String().substring(0, 10);

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('SLOT_FULL')) {
      return 'Sorry, this slot just reached its limit of 10 people!';
    }
    return 'Operation failed: $msg';
  }
}
