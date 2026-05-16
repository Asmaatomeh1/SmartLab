import 'package:appwithfirebase/features/authentication/forget_password/forget_password_status.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> sendResetEmail(String email) async {
    if (email.isEmpty) {
      emit(ForgetPasswordError("Please enter your email address."));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      emit(
        ForgetPasswordSuccess("Password reset link sent! Check your inbox."),
      );
    } on FirebaseAuthException catch (e) {
      emit(ForgetPasswordError(e.message ?? "An error occurred."));
    } catch (e) {
      emit(ForgetPasswordError("Something went wrong. Please try again."));
    }
  }
}
