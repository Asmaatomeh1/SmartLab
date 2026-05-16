//  import 'dart:developer';

// import 'package:appwithfirebase/model/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PatientModel extends UserModel{

//   String bloodType;
//   List<String> allergies;
//   List<String> medications;
//   List<String> conditions;

//   final Map<String, dynamic> _medicalInfo = {
//     'Blood Type': 'O+',
//     'Allergies': ['Penicillin', 'Latex'],
//     'Medications': ['Metformin', 'Vitamin D'],
//     'Conditions': ['Type 2 Diabetes', 'Hypertension'],
//   };

//   PatientModel({
//     required String id,
//     required super.email,
//     required String firstName,
//     required String lastName,
//     required super.password,
//     required super.phone,
//     required super.birthDate,
//     required super.role,
//     required String bloodType,
//     required List<String> allergies,
//     required List<String> medications,
//     required List<String> conditions,
//   }) : super(
//           fullName: FullName(firstName: firstName, lastName: lastName),
//           profileImage: '',
//         );
// }

// ── Reuse FullName & UserModel from your existing code ───────────────────────
// Make sure to import your user_model.dart file

import 'user_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BloodType Enum
// ─────────────────────────────────────────────────────────────────────────────

enum BloodType { aPos, aNeg, bPos, bNeg, abPos, abNeg, oPos, oNeg, unknown }

extension BloodTypeExtension on BloodType {
  String get label {
    switch (this) {
      case BloodType.aPos:
        return 'A+';
      case BloodType.aNeg:
        return 'A-';
      case BloodType.bPos:
        return 'B+';
      case BloodType.bNeg:
        return 'B-';
      case BloodType.abPos:
        return 'AB+';
      case BloodType.abNeg:
        return 'AB-';
      case BloodType.oPos:
        return 'O+';
      case BloodType.oNeg:
        return 'O-';
      case BloodType.unknown:
        return 'Unknown';
    }
  }

  static BloodType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'A+':
        return BloodType.aPos;
      case 'A-':
        return BloodType.aNeg;
      case 'B+':
        return BloodType.bPos;
      case 'B-':
        return BloodType.bNeg;
      case 'AB+':
        return BloodType.abPos;
      case 'AB-':
        return BloodType.abNeg;
      case 'O+':
        return BloodType.oPos;
      case 'O-':
        return BloodType.oNeg;
      default:
        return BloodType.unknown;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PatientModel
// ─────────────────────────────────────────────────────────────────────────────

class PatientModel {
  final String patientId; // e.g. SL-2024-00847
  final UserModel user; // full user info (name, email, phone, etc.)
  final String location;
  final BloodType bloodType;
  final List<String> allergies;
  final List<String> medications;
  final List<String> conditions;

  PatientModel({
    required this.patientId,
    required this.user,
    required this.location,
    required this.bloodType,
    required this.allergies,
    required this.medications,
    required this.conditions,
  });

  // ── Convenience getters (delegate to UserModel) ───────────────────────────

  String get firstName => user.firstName;
  String get lastName => user.lastName;
  String get fullNameText => user.fullNameText;
  String get email => user.email;
  String get phone => user.phone;
  String get profileImage => user.profileImage;
  DateTime get birthDate => user.birthDate;
  int get age => user.age;
  String get role => user.role;

  // ── toMap ─────────────────────────────────────────────────────────────────

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'user': user.toMap(),
      'location': location,
      'bloodType': bloodType.label,
      'allergies': allergies,
      'medications': medications,
      'conditions': conditions,
    };
  }

  // ── fromMap ───────────────────────────────────────────────────────────────

  // factory PatientModel.fromMap(Map<String, dynamic> map) {
  //   return PatientModel(
  //     patientId: map['patientId'] ?? '',
  //     user: UserModel.fromMap(map['user'] ?? {}),
  //     location: map['location'] ?? '',
  //     bloodType: BloodTypeExtension.fromString(map['bloodType'] ?? ''),
  //     allergies: List<String>.from(map['allergies'] ?? []),
  //     medications: List<String>.from(map['medications'] ?? []),
  //     conditions: List<String>.from(map['conditions'] ?? []),
  //   );
  // }
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      patientId: map['patientId'] ?? '',
      // If the user fields are in the same document:
      user: UserModel.fromMap(map),
      location: map['location'] ?? '',
      bloodType: BloodTypeExtension.fromString(map['bloodType'] ?? ''),
      allergies: List<String>.from(map['allergies'] ?? []),
      medications: List<String>.from(map['medications'] ?? []),
      conditions: List<String>.from(map['conditions'] ?? []),
    );
  }
  // ── copyWith ──────────────────────────────────────────────────────────────

  PatientModel copyWith({
    String? patientId,
    UserModel? user,
    String? location,
    BloodType? bloodType,
    List<String>? allergies,
    List<String>? medications,
    List<String>? conditions,
  }) {
    return PatientModel(
      patientId: patientId ?? this.patientId,
      user: user ?? this.user,
      location: location ?? this.location,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      medications: medications ?? this.medications,
      conditions: conditions ?? this.conditions,
    );
  }

  // ── toString ──────────────────────────────────────────────────────────────

  @override
  String toString() {
    return 'PatientModel{ '
        'patientId: $patientId, '
        'user: $user, '
        'location: $location, '
        'bloodType: ${bloodType.label}, '
        'allergies: $allergies, '
        'medications: $medications, '
        'conditions: $conditions'
        ' }';
  }
}
