// import 'package:appwithfirebase/Auth.dart';
// import 'package:appwithfirebase/model/patient_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// class Profile {
//   static PatientModel? currentProfileModel;
//   Future<void> getCurrentProfile() async {
//     // await FirebaseFirestore.instance
//     //     .collection('patients')
//     //     .doc(FirebaseAuth.instance.currentUser?.uid)
//     //     .get()
//     //     .then((doc) {
//     //       if (doc.exists) {
//     //         currentProfileModel = PatientModel.fromMap(
//     //           doc.data() as Map<String, dynamic>,
//     //         );
//     //       }
//     //     });
//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('patients')
//           .doc(firebaseUser.uid)
//           .get();

//       if (doc.exists) {
//         currentProfileModel = PatientModel(
//           patientId: doc.id,
//           user: firebaseUser,
//           location: doc.data['location'] ?? '',
//           bloodType: doc.data()?['bloodType'] ?? '',
//           allergies: List<String>.from(doc.data()?['allergies'] ?? []),
//           medications: List<String>.from(doc.data()?['medications'] ?? []),
//           conditions: List<String>.from(doc.data()?['conditions'] ?? []),
//         );
//       }
//     }
//   }

// }
import 'package:appwithfirebase/model/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  static PatientModel? currentProfileModel;

  Future<void> getCurrentProfile() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('patients')
            .doc(firebaseUser.uid)
            .get();

        if (doc.exists) {
          // Use the existing fromMap factory to handle all conversions
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // CRITICAL: Ensure the 'user' key exists in the Firestore document
          // If it doesn't, you'll need to fetch the user data separately
          // or merge it here.
          currentProfileModel = PatientModel.fromMap(data);
        }
      } catch (e) {
        print("Error fetching profile: $e");
      }
    }
  }
}
