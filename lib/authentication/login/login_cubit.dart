import 'package:appwithfirebase/authentication/auth.dart';
import 'package:appwithfirebase/authentication/login/login_status.dart';
import 'package:appwithfirebase/proflie/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // Future<void> login(String email, String password, String selectedRole) async {
  //   emit(LoginLoading());

  //   try {
  //     // 1. Firebase Auth
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);

  //     // 2. Fetch Role from Firestore
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userCredential.user!.uid)
  //         .get();

  //     if (userDoc.exists) {
  //       String firestoreRole = userDoc.get('role');

  //       if (firestoreRole == selectedRole) {
  //         emit(LoginSuccess(firestoreRole));
  //       } else {
  //         emit(LoginError("Access Denied: You are not an $selectedRole"));
  //       }
  //     } else {
  //       emit(LoginError("User data not found."));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     emit(LoginError(e.message ?? "Authentication failed"));
  //   } catch (e) {
  //     emit(LoginError("An unexpected error occurred"));
  //   }
  // }

  // login_cubit.dart

  //   Future<void> login(String email, String password, String selectedRole) async {
  //     emit(LoginLoading());

  //     try {
  //       // 1. Log in with the password the user just entered (the new one)
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);

  //       if (userCredential.user != null) {
  //         // 2. Fetch the user's document from Firestore
  //         DocumentReference userRef = FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(userCredential.user!.uid);

  //         DocumentSnapshot doc = await userRef.get();

  //         if (doc.exists) {
  //           String dbPassword = doc.get('password');
  //           String dbRole = doc.get('role');

  //           // 3. Verify Role
  //           if (dbRole != selectedRole) {
  //             emit(LoginError("Unauthorized: Role mismatch."));
  //             return;
  //           }

  //           // 4. THE SYNC: If the password in the table is old, update it!
  //           if (dbPassword != password) {
  //             await userRef.update({'password': password});
  //             print("Database password synced with Firebase Auth.");
  //           }
  //           // Inside your LoginCubit or Login Logic

  //           await AppAuth().refreshCurrentUser(); // Get the table data now
  //           //emit(LoginSuccess(AppAuth.currentUser!.role));

  //           emit(LoginSuccess(dbRole));
  //         }
  //       } else
  //         emit(LoginError("User not found."));
  //     } on FirebaseAuthException catch (e) {
  //       emit(LoginError(e.message ?? "Login failed."));
  //     } catch (e) {
  //       emit(LoginError("An unexpected error occurred."));
  //     }
  //   }

  Future<void> login(String email, String password, String selectedRole) async {
    emit(LoginLoading());

    try {
      // 1. Sign in with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        // --- START VERIFICATION CHECK ---
        if (!user.emailVerified) {
          // Optional: Send the email again so they don't get stuck
          await user.sendEmailVerification();

          // Sign them out immediately so they aren't "partially" logged in
          await FirebaseAuth.instance.signOut();

          emit(
            LoginError(
              "Email not verified. A new link has been sent to your inbox.",
            ),
          );
          return;
        }
        // --- END VERIFICATION CHECK ---

        // 2. Fetch the user's document from Firestore
        DocumentReference userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);

        DocumentSnapshot doc = await userRef.get();

        if (doc.exists) {
          String dbPassword = doc.get('password');
          String dbRole = doc.get('role');

          // 3. Verify Role
          if (dbRole != selectedRole) {
            await FirebaseAuth.instance
                .signOut(); // Security: log out if role doesn't match
            emit(LoginError("Unauthorized: Role mismatch."));
            return;
          }

          // 4. THE SYNC: Update password if it changed via Reset Link
          if (dbPassword != password) {
            await userRef.update({'password': password});
          }

          // 5. Hydrate the AppAuth.currentUser global variable
          await AppAuth().refreshCurrentUser();
          await Profile().getCurrentProfile();

          emit(LoginSuccess(dbRole));
        } else {
          emit(LoginError("User record not found in database."));
        }
      } else {
        emit(LoginError("User not found."));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? "Login failed."));
    } catch (e) {
      print(e);
      emit(LoginError("An unexpected error occurred."));
    }
  }
}
