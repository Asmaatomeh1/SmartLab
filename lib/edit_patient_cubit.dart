// import 'package:appwithfirebase/edit_patient_state.dart';
// import 'package:appwithfirebase/model/patient_model.dart';
// import 'package:appwithfirebase/model/user_model.dart';
// //import 'package:appwithfirebase/patient_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// //part 'edit_profile_state.dart';

// class EditProfileCubit extends Cubit<EditProfileState> {
//   //  final PatientRepository _repository;

//   EditProfileCubit() : super(EditProfileInitial());

//   // ── Load patient ──────────────────────────────────────────────────────────

//   Future<void> loadPatient(String patientId) async {
//     emit(EditProfileLoading());
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       final patient = await firestore
//           .collection('patients')
//           .doc(patientId)
//           .get();
//       if (!patient.exists) {
//         emit(EditProfileError('Patient not found.'));
//       } else {
//         emit(EditProfileLoaded(PatientModel.fromMap(patient.data()!)));
//       }
//     } catch (e) {
//       emit(EditProfileError('Failed to load profile: ${e.toString()}'));
//     }
//   }

//   // ── Helper: get current patient from state ────────────────────────────────

//   PatientModel? get _currentPatient {
//     final s = state;
//     if (s is EditProfileLoaded) return s.patient;
//     if (s is EditProfileSaving) return s.patient;
//     if (s is EditProfileError) return s.patient;
//     return null;
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // Individual field updaters  (update local state immediately for live UI)
//   // ─────────────────────────────────────────────────────────────────────────

//   void updateFirstName(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     final updated = p.copyWith(
//       user: p.user.copyWith(
//         fullName: FullName(firstName: value, lastName: p.lastName),
//       ),
//     );
//     emit(EditProfileLoaded(updated));
//   }

//   void updateLastName(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     final updated = p.copyWith(
//       user: p.user.copyWith(
//         fullName: FullName(firstName: p.firstName, lastName: value),
//       ),
//     );
//     emit(EditProfileLoaded(updated));
//   }

//   void updateEmail(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(EditProfileLoaded(p.copyWith(user: p.user.copyWith(email: value))));
//   }

//   void updatePhone(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(EditProfileLoaded(p.copyWith(user: p.user.copyWith(phone: value))));
//   }

//   void updateBirthDate(DateTime value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(
//       EditProfileLoaded(p.copyWith(user: p.user.copyWith(birthDate: value))),
//     );
//   }

//   void updateLocation(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(EditProfileLoaded(p.copyWith(location: value)));
//   }

//   void updateBloodType(BloodType value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(EditProfileLoaded(p.copyWith(bloodType: value)));
//   }

//   void updateProfileImage(String imageUrl) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(user: p.user.copyWith(profileImage: imageUrl)),
//       ),
//     );
//   }

//   // ── Allergies ─────────────────────────────────────────────────────────────

//   void addAllergy(String value) {
//     final p = _currentPatient;
//     if (p == null || value.trim().isEmpty) return;
//     if (p.allergies.contains(value.trim())) return;
//     emit(
//       EditProfileLoaded(p.copyWith(allergies: [...p.allergies, value.trim()])),
//     );
//   }

//   void removeAllergy(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(allergies: p.allergies.where((a) => a != value).toList()),
//       ),
//     );
//   }

//   // ── Medications ───────────────────────────────────────────────────────────

//   void addMedication(String value) {
//     final p = _currentPatient;
//     if (p == null || value.trim().isEmpty) return;
//     if (p.medications.contains(value.trim())) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(medications: [...p.medications, value.trim()]),
//       ),
//     );
//   }

//   void removeMedication(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(
//           medications: p.medications.where((m) => m != value).toList(),
//         ),
//       ),
//     );
//   }

//   // ── Conditions ────────────────────────────────────────────────────────────

//   void addCondition(String value) {
//     final p = _currentPatient;
//     if (p == null || value.trim().isEmpty) return;
//     if (p.conditions.contains(value.trim())) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(conditions: [...p.conditions, value.trim()]),
//       ),
//     );
//   }

//   void removeCondition(String value) {
//     final p = _currentPatient;
//     if (p == null) return;
//     emit(
//       EditProfileLoaded(
//         p.copyWith(conditions: p.conditions.where((c) => c != value).toList()),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // Save to Firebase
//   // ─────────────────────────────────────────────────────────────────────────

//   Future<void> saveProfile() async {
//     final p = _currentPatient;
//     if (p == null) return;

//     emit(EditProfileSaving(p));
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       await firestore.collection('patients').doc(p.patientId).set(p.toMap());
//       emit(EditProfileSuccess(p));
//     } catch (e) {
//       emit(
//         EditProfileError('Failed to save profile: ${e.toString()}', patient: p),
//       );
//     }
//   }

//   // ── Save only specific fields (more efficient) ────────────────────────────

//   Future<void> savePersonalInfoOnly() async {
//     final p = _currentPatient;
//     if (p == null) return;

//     emit(EditProfileSaving(p));
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       await firestore.collection('patients').doc(p.patientId).update({
//         'user.fullName': p.user.fullName.toMap(),
//         'user.email': p.email,
//         'user.phone': p.phone,
//         'user.birthDate': p.birthDate.toIso8601String(),
//         'location': p.location,
//       });
//       emit(EditProfileSuccess(p));
//     } catch (e) {
//       emit(EditProfileError('Failed to save: ${e.toString()}', patient: p));
//     }
//   }

//   Future<void> saveMedicalInfoOnly() async {
//     final p = _currentPatient;
//     if (p == null) return;

//     emit(EditProfileSaving(p));
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       await firestore.collection('patients').doc(p.patientId).update({
//         'bloodType': p.bloodType.label,
//         'allergies': p.allergies,
//         'medications': p.medications,
//         'conditions': p.conditions,
//       });
//       emit(EditProfileSuccess(p));
//     } catch (e) {
//       emit(EditProfileError('Failed to save: ${e.toString()}', patient: p));
//     }
//   }

//   // ── Reset to last saved state ─────────────────────────────────────────────

//   Future<void> discardChanges(String patientId) async {
//     await loadPatient(patientId);
//   }
// }
