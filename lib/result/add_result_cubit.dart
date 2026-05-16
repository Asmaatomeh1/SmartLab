// // import 'dart:io';
// // import 'package:appwithfirebase/appointment_model.dart';
// // import 'package:appwithfirebase/result_model.dart';
// // //import 'package:appwithfirebase/result_model.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // part 'add_result_state.dart';

// // class AddResultCubit extends Cubit<AddResultState> {
// //   AddResultCubit() : super(AddResultInitial());
// //   ResultModel? currentResult;

// //   // Future<AppointmentModel?> getAppointment(String appointmentId) async {
// //   //   final doc = await FirebaseFirestore.instance
// //   //       .collection('appointments')
// //   //       .doc(appointmentId)
// //   //       .get();
// //   //   if (!doc.exists || doc.data() == null) return null;
// //   //   final data = doc.data()!;
// //   //   data['appointmentId'] = doc.id;
// //   //   return AppointmentModel.fromMap(data);
// //   // }

// //   // ── Load appointment ──────────────────────────────────────────────────────

// //   // Future<void> loadAppointment(String appointmentId) async {
// //   //   emit(AddResultLoading());
// //   //   try {
// //   //     final appointment = await getAppointment(appointmentId);
// //   //     if (appointment == null) {
// //   //       emit(AddResultError('Appointment not found.'));
// //   //       return;
// //   //     }

// //   //     // Build empty maps keyed by testId
// //   //     final localPaths = <String, String?>{
// //   //       for (final t in appointment.selectedTests) t.testId: null,
// //   //     };
// //   //     final progress = <String, double>{
// //   //       for (final t in appointment.selectedTests) t.testId: 0.0,
// //   //     };
// //   //     final urls = <String, String?>{
// //   //       for (final t in appointment.selectedTests) t.testId: null,
// //   //     };

// //   //     emit(
// //   //       AddResultLoaded(
// //   //         appointment: appointment,
// //   //         localFilePaths: localPaths,
// //   //         uploadProgress: progress,
// //   //         uploadedUrls: urls,
// //   //       ),
// //   //     );
// //   //   } catch (e) {
// //   //     emit(AddResultError('Failed to load appointment: ${e.toString()}'));
// //   //   }
// //   // }

// //   // ── Helper: get current loaded data ──────────────────────────────────────

// //   AddResultLoaded? get _current {
// //     final s = state;
// //     if (s is AddResultLoaded) return s;

// //     if (s is AddResultError) return s.data;
// //     return null;
// //   }

// //   // ── Pick file for a specific test ─────────────────────────────────────────
// //   // Call this after file_picker returns a path

// //   // void setLocalFile(String testId, String filePath) {
// //   //   final data = _current;
// //   //   if (data == null) return;

// //   //   final newPaths = Map<String, String?>.from(data.localFilePaths);
// //   //   newPaths[testId] = filePath;

// //   //   // Clear any previously uploaded URL for this test (user re-picked)
// //   //   final newUrls = Map<String, String?>.from(data.uploadedUrls);
// //   //   newUrls[testId] = null;

// //   //   emit(data.copyWith(localFilePaths: newPaths, uploadedUrls: newUrls));
// //   // }

// //   // ── Upload file for one test ──────────────────────────────────────────────

// //   // Future<void> uploadFile(String testId) async {
// //   //   final data = _current;
// //   //   if (data == null) return;

// //   //   final localPath = data.localFilePaths[testId];
// //   //   if (localPath == null) return;

// //   //   emit(AddResultUploading(data, testId));

// //   //   try {
// //   //     final url = await uploadResultFile(
// //   //       file: File(localPath),
// //   //       appointmentId: data.appointment.appointmentId,
// //   //       testId: testId,
// //   //     );

// //   //     final current = _current!;
// //   //     final newUrls = Map<String, String?>.from(current.uploadedUrls);
// //   //     newUrls[testId] = url;

// //   //     final newProgress = Map<String, double>.from(current.uploadProgress);
// //   //     newProgress[testId] = 1.0;

// //   //     emit(current.copyWith(uploadedUrls: newUrls, uploadProgress: newProgress));
// //   //   } catch (e) {
// //   //     final current = _current;
// //   //     emit(AddResultError('Failed to upload file: ${e.toString()}', data: current));
// //   //   }
// //   // }

// //   // ── Upload all files that have been picked ────────────────────────────────

// //   // Future<void> uploadAllFiles() async {
// //   //   final data = _current;
// //   //   if (data == null) return;

// //   //   for (final test in data.appointment.selectedTests) {
// //   //     final current = _current;
// //   //     if (current == null) return;
// //   //     if (current.localFilePaths[test.testId] != null &&
// //   //         current.uploadedUrls[test.testId] == null) {
// //   //       await uploadFile(test.testId);
// //   //     }
// //   //   }
// //   // }

// //   // ── Update notes ──────────────────────────────────────────────────────────

// //   // void updateNotes(String value) {
// //   //   final data = _current;
// //   //   if (data == null) return;
// //   //   emit(data.copyWith(notes: value));
// //   // }

// //   // ── Submit all results to Firestore ──────────────────────────────────────

// //   // Future<void> submitResults() async {
// //   //   final data = _current;
// //   //   if (data == null) return;

// //   //   // Upload any remaining files first
// //   //   // await uploadAllFiles();

// //   //   final latestData = _current;
// //   //   if (latestData == null) return;

// //   //   // if (!latestData.allUploaded) {
// //   //   //   emit(
// //   //   //     AddResultError(
// //   //   //       'Please upload files for all tests before submitting.',
// //   //   //       data: latestData,
// //   //   //     ),
// //   //   //   );
// //   //   //   return;
// //   //   // }

// //   //   //emit(AddResultSubmitting(latestData));

// //   //   try {
// //   //     final resultItems = latestData.appointment.selectedTests.map((test) {
// //   //       return TestResultItem(
// //   //         testId: test.testId,
// //   //         testName: test.testName,
// //   //         resultUrl: latestData.uploadedUrls[test.testId]!,
// //   //       );
// //   //     }).toList();

// //   //     final result = ResultModel(
// //   //       resultId: latestData.appointment.appointmentId,
// //   //       appointmentId: latestData.appointment.appointmentId,
// //   //       patientId: latestData.appointment.patientId,
// //   //       results: resultItems,
// //   //       createdAt: DateTime.now(),
// //   //       status: 'ready',
// //   //       notes: latestData.notes,
// //   //     );

// //   //     // Atomic batch: save result + mark appointment completed
// //   //     await submitResult(result);

// //   //     emit(AddResultSuccess(latestData.appointment.appointmentId));
// //   //   } catch (e) {
// //   //     final current = _current;
// //   //     emit(
// //   //       AddResultError(
// //   //         'Failed to submit results: ${e.toString()}',
// //   //         data: current,
// //   //       ),
// //   //     );
// //   //   }
// //   // }

// //   Future<void> submitResult(ResultModel result) async {
// //     final docRef = FirebaseFirestore.instance.collection('results').doc();
// //     await docRef.set(result.copyWith(resultId: docRef.id).toMap());
// //     print('Result submitted with ID: ${docRef.id}');
// //   }
// //   Future<void> addField(String appointmentId, String note, String url) async {
// //   //  currentResult?.copyWith(notes: note, uploadedUrls: {appointmentId: url});
// //   //  currentResult
// //     emit(AddResultLoaded(appointmentid: appointmentId, uploadedUrls: url));
// //   }

// //   // ── Remove a picked file ──────────────────────────────────────────────────

// //   // void clearFile(String testId) {
// //   //   final data = _current;
// //   //   if (data == null) return;

// //   //   final newPaths = Map<String, String?>.from(data.localFilePaths);
// //   //   final newUrls = Map<String, String?>.from(data.uploadedUrls);
// //   //   final newProgress = Map<String, double>.from(data.uploadProgress);

// //   //   newPaths[testId] = null;
// //   //   newUrls[testId] = null;
// //   //   newProgress[testId] = 0.0;

// //   //   emit(data.copyWith(
// //   //     localFilePaths: newPaths,
// //   //     uploadedUrls: newUrls,
// //   //     uploadProgress: newProgress,
// //   //   ));
// //   // }
// //   // Future<ResultModel?> getResultByAppointment(String appointmentId) async {
// //   //   final doc = await _results.doc(appointmentId).get();
// //   //   if (!doc.exists || doc.data() == null) return null;
// //   //   return ResultModel.fromMap(doc.data()!);
// //   // }
// // }

import 'package:appwithfirebase/result/add_result_state.dart';
import 'package:appwithfirebase/model/result_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class AddResultCubit extends Cubit<AddResultState> {
//   AddResultCubit() : super(AddResultInitial());

//   // void addField(String appointmentId, String note, String url) {
//   //   emit(AddResultLoaded(appointmentid: appointmentId, uploadedUrls: url));
//   // }

//   ResultModel? currentResult;

//   Future<void> loadAppointment(
//     String appointmentId,
//     String note,
//     String url,
//   ) async {
//     emit(AddResultLoading());
//     // Simulate loading appointment data
//     try {
//       if (appointmentId.isEmpty) {
//         emit(AddResultError('Invalid appointment ID.'));
//         return;
//       }
//       if (url.isEmpty) {
//         emit(AddResultError('Result URL cannot be empty.'));
//         return;
//       }
//       final ref = await FirebaseFirestore.instance
//           .collection('appointments')
//           .doc(appointmentId)
//           .get();
//       if (!ref.exists || ref.data() == null) {
//         emit(AddResultError('Appointment not found.'));
//         return;
//       }

//       print('Loaded appointment with ID: $appointmentId');

//       await Future.delayed(const Duration(seconds: 4), () {
//         emit(
//           AddResultLoaded(
//             result: ResultModel(
//               resultId: 'non_existing_id',
//               appointmentId: appointmentId,
//               createdAt: DateTime.now(),
//               notes: note,
//               resultUrl: url,
//             ),
//           ),
//         );
//       });
//       currentResult = ResultModel(
//         resultId: ref.id,
//         appointmentId: appointmentId,
//         createdAt: DateTime.now(),
//         notes: note,
//         resultUrl: url,
//       );
//     } catch (e) {
//       emit(AddResultError('Failed to load appointment eee: ${e.toString()}'));
//     }
//     // return ;
//   }

//   submitResult(String appointmentId) {
//     try {
//       if (appointmentId.isEmpty) {
//         emit(AddResultError('Invalid appointment ID.'));
//         return;
//       }
//       final result = ResultModel(
//         resultId: appointmentId,
//         appointmentId: appointmentId,
//         createdAt: DateTime.now(),
//         notes: currentResult?.notes ?? '',
//         resultUrl: currentResult?.resultUrl ?? '',
//       );

//       final docRef = FirebaseFirestore.instance.collection('results').doc();
//       docRef.set(result.copyWith(resultId: docRef.id).toMap());
//       print('Result submitted with ID: ${docRef.id}');
//     } catch (e) {
//       emit(AddResultError('Failed to submit results: ${e.toString()}'));
//     }

//     emit(AddResultSuccess(appointmentId));
//     print('Result submitted successfully for appointment ID: $appointmentId');
//   }
// }

// class AddResultCubit extends Cubit<AddResultState> {
//   AddResultCubit() : super(AddResultInitial());

//   Future<void> loadAppointment(String id, String note, String url) async {
//     if (id.isEmpty || url.isEmpty) {
//       emit(AddResultError('Please fill in both ID and URL.'));
//       return;
//     }

//     emit(AddResultLoading());

//     try {
//       final doc = await FirebaseFirestore.instance
//           .collection('appointments')
//           .doc(id)
//           .get();

//       if (!doc.exists) {
//         emit(AddResultError('Appointment not found.'));
//         return;
//       }

//       final result = ResultModel(
//         resultId: '', // Will be set by Firestore on submit
//         appointmentId: id,
//         createdAt: DateTime.now(),
//         notes: note,
//         resultUrl: url,
//       );

//       emit(AddResultLoaded(result: result));
//     } catch (e) {
//       emit(AddResultError('Connection error: ${e.toString()}'));
//     }
//   }

//   Future<void> submitResult() async {
//     final currentState = state;
//     if (currentState is! AddResultLoaded) return;

//     emit(AddResultLoading()); // Show spinner during save

//     try {
//       final doc = await FirebaseFirestore.instance
//           .collection('results')
//           .where('appointmentId', isEqualTo: currentState.result.appointmentId)
//           .get();

//       if (doc.docs.isEmpty) {

//         return;
//       }

//       final docRef = FirebaseFirestore.instance.collection('results').doc();

//       final finalResult = currentState.result.copyWith(resultId: docRef.id);

//       await docRef.set(finalResult.toMap());
//       emit(AddResultSuccess(finalResult.appointmentId));
//     } catch (e) {
//       emit(AddResultError('Upload failed: ${e.toString()}'));
//     }
//   }
// }

class AddResultCubit extends Cubit<AddResultState> {
  AddResultCubit() : super(AddResultInitial());

  // ... loadAppointment remains the same ...
  ResultModel? currentResult;

  Future<void> loadAppointment(
    String appointmentId,
    String note,
    String url,
  ) async {
    emit(AddResultLoading());
    // Simulate loading appointment data
    try {
      if (appointmentId.isEmpty) {
        emit(AddResultError('Invalid appointment ID.'));
        return;
      }
      if (url.isEmpty) {
        emit(AddResultError('Result URL cannot be empty.'));
        return;
      }
      final ref = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .get();
      if (!ref.exists || ref.data() == null) {
        emit(AddResultError('Appointment not found.'));
        return;
      }

      print('Loaded appointment with ID: $appointmentId');

      await Future.delayed(const Duration(seconds: 4), () {
        emit(
          AddResultLoaded(
            result: ResultModel(
              resultId: 'non_existing_id',
              appointmentId: appointmentId,
              createdAt: DateTime.now(),
              notes: note,
              resultUrl: url,
            ),
          ),
        );
      });
      currentResult = ResultModel(
        resultId: ref.id,
        appointmentId: appointmentId,
        createdAt: DateTime.now(),
        notes: note,
        resultUrl: url,
      );
    } catch (e) {
      emit(AddResultError('Failed to load appointment eee: ${e.toString()}'));
    }
    // return ;
  }

  Future<void> submitResult() async {
    final currentState = state;
    if (currentState is! AddResultLoaded) return;

    final newResultData = currentState.result;
    emit(AddResultLoading());

    try {
      // 1. Check if a result already exists for this appointment
      final query = await FirebaseFirestore.instance
          .collection('results')
          .where('appointmentId', isEqualTo: newResultData.appointmentId)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        // 2. If exists, emit "AlreadyExists" to trigger the UI Dialog
        emit(
          AddResultAlreadyExists(
            newResult: newResultData,
            existingDocId: query.docs.first.id,
          ),
        );
      } else {
        // 3. If doesn't exist, proceed with normal creation
        await performSaveOrUpdate(newResultData, null);
      }
    } catch (e) {
      emit(AddResultError('Check failed: ${e.toString()}'));
    }
  }

  Future<void> performSaveOrUpdate(
    ResultModel result,
    String? existingId,
  ) async {
    emit(AddResultLoading());
    try {
      final collection = FirebaseFirestore.instance.collection('results');

      if (existingId != null) {
        // Update existing document
        result = result.copyWith(resultId: existingId);
        await collection.doc(existingId).update(result.toMap());
      } else {
        // Create new document
        final docRef = collection.doc();
        await docRef.set(result.copyWith(resultId: docRef.id).toMap());
      }
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(result.appointmentId)
          .update({'status': 'completed'});
      emit(AddResultSuccess(result.appointmentId));
    } catch (e) {
      emit(AddResultError('Save failed: ${e.toString()}'));
    }
  }
}
