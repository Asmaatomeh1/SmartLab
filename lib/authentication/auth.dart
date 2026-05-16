// import 'package:appwithfirebase/model/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AppAuth {
//   // Sign in with email and password
//   static late String role;
//   Future<User?> signInWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       if (userCredential.user?.emailVerified == true) {
//         return userCredential.user;
//       }
//       return null;
//     } catch (e) {
//       print("Error signing in: $e");
//       return null;
//     }
//   }

//   // Sign up with email and password
//   // Future<User?> signUpWithEmailPassword(String email, String password) async {
//   //   try {
//   //     UserCredential userCredential = await FirebaseAuth.instance
//   //         .createUserWithEmailAndPassword(email: email, password: password);
//   //     FirebaseFirestore.instance
//   //         .collection('users')
//   //         .doc(userCredential.user?.uid)
//   //         .set({'email': email, 'password': password, 'role': role});
//   //     if (userCredential.user != null) {
//   //       await userCredential.user!.sendEmailVerification();
//   //     }

//   //     return userCredential.user;
//   //   } catch (e) {
//   //     print("Error signing up: $e");
//   //     return null;
//   //   }
//   // }

//   // Sign up with full User Model
//   Future<User?> signUpWithEmailPassword(UserModel userModel) async {
//     try {
//       // 1. Create the user in Firebase Auth
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: userModel.email,
//             password: userModel.password,
//           );

//       if (userCredential.user != null) {
//         // 2. Prepare the data with the actual UID from Firebase
//         final finalUser = userModel.copyWith(id: userCredential.user!.uid);

//         // 3. Save to Firestore using your toMap() method
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .set(finalUser.toMap());

//         // 4. Send verification email
//         await userCredential.user!.sendEmailVerification();
//       }

//       return userCredential.user;
//     } catch (e) {
//       print("Error signing up: $e");
//       return null;
//     }
//   }

//   // ... rest of your class (signIn, signOut)

//   // Sign out
//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//   }

// }

// ignore_for_file: file_names

//import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:appwithfirebase/model/patient_model.dart';
import 'package:appwithfirebase/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuth {
  static String role = 'user'; // Default value

  Future<User?> signUpWithEmailPassword(UserModel userModel) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );

      if (userCredential.user != null) {
        // We add the role here to the model before saving
        // final finalUser = userModel.copyWith(
        //   id: userCredential.user!.uid,
        //   role: AppAuth.role, // <--- Crucial: Injecting the role here
        // );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());
        if (AppAuth.role == 'patient') {
          await FirebaseFirestore.instance
              .collection('patients')
              .doc(userCredential.user!.uid)
              .set(
                PatientModel(
                  patientId: userCredential.user!.uid,
                  user: userModel,
                  location: '',
                  bloodType: BloodType.unknown,
                  allergies: [],
                  medications: [],
                  conditions: [],
                ).toMap(),
              );
        }
        // log(userCredential.user!.uid);

        await userCredential.user!.sendEmailVerification();
      }
      return userCredential.user;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  // This is the "Live" storage for the current user
  static UserModel? currentUser;

  // Method to fetch the data and "fill the box"
  Future<void> refreshCurrentUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists) {
        currentUser = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
  }
}
