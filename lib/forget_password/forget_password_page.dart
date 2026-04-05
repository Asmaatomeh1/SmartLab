import 'package:appwithfirebase/forget_password/forget_password_cubit.dart';
import 'package:appwithfirebase/forget_password/forget_password_status.dart';
import 'package:appwithfirebase/my_text_form_field.dart';
import 'package:flutter/material.dart';

// class ForgetPasswordPage extends StatelessWidget {
//   ForgetPasswordPage({super.key});
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Forgot Password')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Enter your email to receive a password reset link.',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             MyTextFormField(
//               controller: emailController,
//               labelText: 'Email',

//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Handle password reset
//                 String? errorMessage;
//                 try {
//                   await FirebaseAuth.instance.sendPasswordResetEmail(
//                     email: emailController.text.trim(),
//                   );
//                 } on FirebaseAuthException catch (e) {
//                   errorMessage = e.message;
//                 }

//                 if (errorMessage != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(errorMessage)),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Password reset link sent!')),
//                   );
//                 }
//               },
//               child: const Text('Send Reset Link'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
// Import your cubit and state files here

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ForgetPasswordCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Forgot Password')),
          body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordError) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: 'Error',
                  desc: state.errorMessage,
                ).show();
              }
              if (state is ForgetPasswordSuccess) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'Success',
                  desc: state.message,
                  btnOkOnPress: () =>
                      Navigator.pop(context), // Go back to Login
                ).show();
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter your email to receive a password reset link.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    MyTextFormField(
                      controller: emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    state is ForgetPasswordLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .sendResetEmail(emailController.text);
                            },
                            child: const Text('Send Reset Link'),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
