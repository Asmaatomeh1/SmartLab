// //part of 'edit_profile_cubit.dart';

// import 'package:appwithfirebase/model/patient_model.dart';

// abstract class EditProfileState {}

// // ── Initial ───────────────────────────────────────────────────────────────────
// class EditProfileInitial extends EditProfileState {}

// // ── Loading patient data ──────────────────────────────────────────────────────
// class EditProfileLoading extends EditProfileState {}

// // ── Patient loaded — form is ready ───────────────────────────────────────────
// class EditProfileLoaded extends EditProfileState {
//   final PatientModel patient;
//   EditProfileLoaded(this.patient);
// }

// // ── Saving in progress ────────────────────────────────────────────────────────
// class EditProfileSaving extends EditProfileState {
//   final PatientModel patient; // keep current data visible while saving
//   EditProfileSaving(this.patient);
// }

// // ── Save succeeded ────────────────────────────────────────────────────────────
// class EditProfileSuccess extends EditProfileState {
//   final PatientModel updatedPatient;
//   EditProfileSuccess(this.updatedPatient);
// }

// // ── Any error ─────────────────────────────────────────────────────────────────
// class EditProfileError extends EditProfileState {
//   final String message;
//   final PatientModel? patient; // keep data so form doesn't disappear
//   EditProfileError(this.message, {this.patient});
// }
