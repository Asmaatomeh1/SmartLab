// import 'package:appwithfirebase/result_state.dart';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ResultCubit extends Cubit<ResultState> {
//   ResultCubit() : super(ResultInitial());

//   Future<void> fetchUserResults() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     print("Fetching results for user $uid");
//     if (uid == null) {
//       emit(ResultError("User not logged in"));
//       return;
//     }

//     emit(ResultLoading());

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection("appointments")
//           .where("patientId", isEqualTo: uid)
//           .get();
//       print("Fetched ${snapshot.docs.length} appointments for user $uid");

//       List<Map<String, dynamic>> pending = [];
//       List<Map<String, dynamic>> completed = [];
//       List<Map<String, dynamic>> missed = [];

//       final now = DateTime.now();

//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         final String status = data['status'] ?? 'pending';
//         final DateTime apptDate = DateTime.parse(data['date']);

//         // Logic for categorization
//         if (status == 'completed') {
//           completed.add(data);
//         } else if (apptDate.isBefore(now) && status == 'pending') {
//           missed.add(data); // Date passed but still pending = No show
//         } else {
//           pending.add(data);
//         }
//       }

//       emit(
//         ResultLoaded(pending: pending, completed: completed, missed: missed),
//       );
//     } catch (e) {
//       emit(ResultError("Failed to load results: ${e.toString()}"));
//     }
//   }
// }

//after add file result

// result_cubit.dart

import 'package:appwithfirebase/result_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());

  Future<void> fetchUserResults() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // log("Fetching results for user $uid");
    if (uid == null) {
      emit(ResultError("User not logged in"));
      return;
    }

    emit(ResultLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("appointments")
          .where("patientId", isEqualTo: uid)
          .get();
      //log("Fetched ${snapshot.docs.length} appointments for user $uid");

      List<Map<String, dynamic>> pending = [];
      List<Map<String, dynamic>> completed = [];
      List<Map<String, dynamic>> missed = [];

      final now = DateTime.now();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final String status = data['status'] ?? 'pending';
        final DateTime apptDate = DateTime.parse(data['date']);

        // Logic for categorization
        if (status == 'completed') {
          completed.add(data);
        } else if (apptDate.isBefore(now) && status == 'pending') {
          missed.add(data); // Date passed but still pending = No show
        } else {
          pending.add(data);
        }
      }

      emit(
        ResultLoaded(pending: pending, completed: completed, missed: missed),
      );
    } catch (e) {
      emit(ResultError("Failed to load results: ${e.toString()}"));
    }
  }

  // ─── Fetch Result File URL ───────────────────────────────────────────────

  /// Fetches the result document for the given appointment from Firestore.
  /// Returns the result data map if found, or null if no result has been uploaded yet.
  Future<Map<String, dynamic>?> fetchResultForAppointment(
    String appointmentId,
  ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('results')
          .where('appointmentId', isEqualTo: appointmentId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        // log("No result found for appointment: $appointmentId");
        return null;
      }

      final data = snapshot.docs.first.data();
      // log("Result found: ${data['fileName']}");
      return data;
    } catch (e) {
      // log("Error fetching result: $e");
      return null;
    }
  }
}
