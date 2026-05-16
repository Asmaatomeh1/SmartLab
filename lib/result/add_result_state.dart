import 'package:appwithfirebase/model/result_model.dart';

abstract class AddResultState {}

// ── Initial ───────────────────────────────────────────────────────────────────
class AddResultInitial extends AddResultState {}

// ── Loading appointment data ──────────────────────────────────────────────────
class AddResultLoading extends AddResultState {}

// ── Appointment loaded — form is ready ───────────────────────────────────────
class AddResultLoaded extends AddResultState {
  //  final String appointmentid;

  // Map of testId → file path chosen by admin (nullable = not uploaded yet)
  // final Map<String, String?> localFilePaths;

  // Map of testId → upload progress (0.0 to 1.0)
  //  final Map<String, double> uploadProgress;

  // Map of testId → final URL (after upload)
  //final String  uploadedUrls;

  //final String? notes;
  ResultModel result;

  AddResultLoaded({required this.result});

  // How many tests have a file picked
  // int get pickedCount => localFilePaths.values.where((v) => v != null).length;

  // // How many tests have been uploaded
  // int get uploadedCount => uploadedUrls.values.where((v) => v != null).length;

  // // All tests have a URL ready
  // bool get allUploaded =>
  //     appointment.selectedTests.every((t) => uploadedUrls[t.testId] != null);

  // AddResultLoaded copyWith({
  //   String? appointmentid,

  //   String? uploadedUrls,
  //   String? notes,
  // }) =>
  //     AddResultLoaded(
  //       appointmentid: appointmentid ?? this.appointmentid,
  //       uploadedUrls: uploadedUrls ?? this.uploadedUrls,
  //       notes: notes ?? this.notes,
  //     );
}

// ── Uploading a specific file ─────────────────────────────────────────────────

// ── Successfully submitted ────────────────────────────────────────────────────
class AddResultSuccess extends AddResultState {
  final String appointmentId;
  AddResultSuccess(this.appointmentId);
}

// ── Error ─────────────────────────────────────────────────────────────────────
class AddResultError extends AddResultState {
  final String message;
  final AddResultLoaded? data;
  AddResultError(this.message, {this.data});
}

class AddResultAlreadyExists extends AddResultState {
  final ResultModel newResult;
  final String existingDocId;
  AddResultAlreadyExists({
    required this.newResult,
    required this.existingDocId,
  });
}
