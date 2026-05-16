import 'package:appwithfirebase/authentication/auth.dart';
import 'package:appwithfirebase/shared_widget/button2.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/authentication/login/login.dart';
import 'package:appwithfirebase/model/user_model.dart';
import 'package:appwithfirebase/shared_widget/my_text_form_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class Signup extends StatefulWidget {
// //   const Signup({super.key});

// //   @override
// //   State<Signup> createState() => _SignupState();
// // }

// // class _SignupState extends State<Signup> {
// //   final email = TextEditingController();
// //   final password = TextEditingController();

// //   Future signUp() async {
// //     final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //       email: email.text.trim(),
// //       password: password.text.trim(),
// //     );

// //     await user.user!.sendEmailVerification();

// //     Navigator.pop(context);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Create Account")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: email,
// //               decoration: const InputDecoration(labelText: "Email"),
// //             ),

// //             const SizedBox(height: 10),

// //             TextField(
// //               controller: password,
// //               obscureText: true,
// //               decoration: const InputDecoration(labelText: "Password"),
// //             ),

// //             const SizedBox(height: 20),

// //             ElevatedButton(onPressed: signUp, child: const Text("Sign Up")),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class Signup extends StatelessWidget {
// //   Signup({super.key});
// //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //   final firstNameController = TextEditingController();
// //   final lastNameController = TextEditingController();
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final confirmPasswordController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Create Account")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Form(
// //           key: formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(height: 150),
// //               Row(
// //                 children: [
// //                   SizedBox(
// //                     width: 165.w,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           " First Name",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         SizedBox(height: 10.h),
// //                         MyTextFormField(
// //                           controller: firstNameController,
// //                           labelText: "First Name",
// //                           validator: (value) {
// //                             if (value == null || value.isEmpty) {
// //                               return "Please enter your first name";
// //                             }
// //                             return null;
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(width: 10),
// //                   SizedBox(
// //                     width: 165.w,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           " Last Name",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         SizedBox(height: 10.h),
// //                         MyTextFormField(
// //                           controller: lastNameController,
// //                           labelText: "Last Name",
// //                           validator: (value) {
// //                             if (value == null || value.isEmpty) {
// //                               return "Please enter your last name";
// //                             }
// //                             return null;
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 20),

// //               Text(
// //                 " Email",
// //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //               ),
// //               const SizedBox(height: 8),
// //               MyTextFormField(
// //                 controller: emailController,
// //                 labelText: "Email",
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter your email";
// //                   } else if (!RegExp(
// //                     r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
// //                   ).hasMatch(value)) {
// //                     return "Please enter a valid email address";
// //                   }
// //                   return null;
// //                 },
// //               ),

// //               const SizedBox(height: 20),
// //               const Text(
// //                 " Password",
// //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //               ),
// //               const SizedBox(height: 8),
// //               MyTextFormField(
// //                 controller: passwordController,
// //                 labelText: "Password",

// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter your password";
// //                   }
// //                   if (value.length < 6) {
// //                     return "Password must be at least 6 characters";
// //                   }
// //                   return null;
// //                 },
// //               ),

// //               const SizedBox(height: 20),
// //               Text(
// //                 " Confirm Password",
// //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //               ),
// //               const SizedBox(height: 8),
// //               MyTextFormField(
// //                 controller: confirmPasswordController,
// //                 labelText: "Confirm Password",
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please confirm your password";
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 100),
// //               Center(
// //                 child: Button2(
// //                   onPressed: () {
// //                     if (formKey.currentState!.validate()) {
// //                       // Process the signup
// //                       final email = emailController.text.trim();
// //                       final password = passwordController.text.trim();
// //                       final confirmPassword = confirmPasswordController.text
// //                           .trim();
// //                       print(
// //                         "Email: $email, Password: $password, Confirm Password: $confirmPassword",
// //                       );

// //                       if (password == confirmPassword) {
// //                         // Proceed with signup
// //                         AppAuth().signUpWithEmailPassword(email, password);

// //                         AwesomeDialog(
// //                           context: context,
// //                           dialogType: DialogType.info,
// //                           animType: AnimType.rightSlide,
// //                           title: 'Signup Successful',
// //                           desc:
// //                               'You have successfully signed up! Please verify your email before logging in.',
// //                           btnCancelOnPress: () {
// //                             Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(builder: (context) => Login()),
// //                             );
// //                           },
// //                           btnOkOnPress: () {
// //                             Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(builder: (context) => Login()),
// //                             );
// //                           },
// //                           btnCancelColor: AppColors.grey,
// //                           btnOkColor: AppColors.blue,
// //                           customHeader: Container(
// //                             padding: const EdgeInsets.all(16),
// //                             decoration: BoxDecoration(
// //                               color: Colors.green,
// //                               shape: BoxShape.circle,
// //                             ),
// //                             child: const Icon(
// //                               Icons.check_circle_outline,
// //                               color: Colors.white,
// //                               size: 40,
// //                             ),
// //                           ),
// //                         ).show();

// //                         print("Signup successful");
// //                       } else {
// //                         AwesomeDialog(
// //                           context: context,
// //                           dialogType: DialogType.error,
// //                           animType: AnimType.scale,
// //                           title: 'Signup Failed',
// //                           desc: 'Passwords do not match',
// //                           // btnCancelOnPress: () {},
// //                           btnOkOnPress: () {},
// //                           btnCancelColor: AppColors.grey,
// //                           btnOkColor: AppColors.blue,
// //                           customHeader: Container(
// //                             padding: const EdgeInsets.all(16),
// //                             decoration: BoxDecoration(
// //                               color: Colors.red,
// //                               shape: BoxShape.circle,
// //                             ),
// //                             child: const Icon(
// //                               Icons.error_outline,
// //                               color: Colors.white,
// //                               size: 40,
// //                             ),
// //                           ),
// //                         ).show();
// //                         print("Passwords do not match");
// //                       }
// //                     }
// //                   },
// //                   text: 'Sign Up',
// //                 ),
// //               ),
// //               Text.rich(
// //                 TextSpan(
// //                   text: "Already have an account? ",
// //                   style: TextStyle(fontSize: 14, color: Colors.grey),
// //                   children: [
// //                     TextSpan(
// //                       text: "Login",
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Colors.blue,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                       recognizer: TapGestureRecognizer()
// //                         ..onTap = () {
// //                           Navigator.pushReplacement(
// //                             context,
// //                             MaterialPageRoute(builder: (context) => Login()),
// //                           );
// //                         },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // after add the name and phone number and date fields

// Ensure these imports match your project structure
// import 'package:appwithfirebase/core/theme/appcolor.dart';
// import 'package:appwithfirebase/app_auth.dart';
// import 'package:appwithfirebase/login.dart';
// import 'package:appwithfirebase/button2.dart';
// import 'package:appwithfirebase/my_text_form_field.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   // Controllers
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final birthdateController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up controllers when the widget is removed
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     birthdateController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   // Function to show Date Picker
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().subtract(
//         const Duration(days: 6570),
//       ), // Default 18 years ago
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         birthdateController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard on tap
//       child: Scaffold(
//         backgroundColor: Colors.white,

//         appBar: AppBar(
//           title: const Text("Create Account"),
//           scrolledUnderElevation: 0,
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           // Added scroll to prevent overflow with keyboard
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),

//                 // Name Row (First & Last)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildFieldLabel(
//                       "First Name",
//                       width: 165.w,
//                       controller: firstNameController,
//                     ),
//                     _buildFieldLabel(
//                       "Last Name",
//                       width: 165.w,
//                       controller: lastNameController,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),
//                 _buildLabel("Email"),
//                 MyTextFormField(
//                   controller: emailController,
//                   labelText: "Email",
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return "Please enter email";
//                     if (!RegExp(
//                       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                     ).hasMatch(value))
//                       return "Invalid email";
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 20),
//                 _buildLabel("Phone Number"),
//                 MyTextFormField(
//                   controller: phoneController,
//                   labelText: "Phone Number",
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return "Please enter phone number";
//                     else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value))
//                       return "Invalid phone number";
//                     else
//                       return null;
//                   },
//                 ),

//                 const SizedBox(height: 20),
//                 _buildLabel("Birthdate"),
//                 GestureDetector(
//                   onTap: () => _selectDate(context),
//                   child: AbsorbPointer(
//                     // Prevents keyboard from opening
//                     child: MyTextFormField(
//                       controller: birthdateController,
//                       labelText: "YYYY-MM-DD",
//                       validator: (value) => (value == null || value.isEmpty)
//                           ? "Select birthdate"
//                           : null,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//                 _buildLabel("Password"),
//                 MyTextFormField(
//                   controller: passwordController,
//                   labelText: "Password",
//                   obscureText: true,
//                   validator: (value) => (value != null && value.length < 6)
//                       ? "Min 6 characters"
//                       : null,
//                 ),

//                 const SizedBox(height: 20),
//                 _buildLabel("Confirm Password"),
//                 MyTextFormField(
//                   controller: confirmPasswordController,
//                   labelText: "Confirm Password",
//                   obscureText: true,
//                   validator: (value) {
//                     if (value != passwordController.text)
//                       return "Passwords do not match";
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 40),
//                 Center(
//                   child: Button2(
//                     text: 'Sign Up',
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         _handleSignup(context);
//                       }
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       text: "Already have an account? ",
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                       children: [
//                         TextSpan(
//                           text: "Login",
//                           style: const TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Login(),
//                                 ),
//                               );
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget for Labels
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, left: 4),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//     );
//   }

//   // Helper widget for the Name Row fields
//   Widget _buildFieldLabel(
//     String label, {
//     required double width,
//     required TextEditingController controller,
//   }) {
//     return SizedBox(
//       width: width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildLabel(label),
//           MyTextFormField(
//             controller: controller,
//             labelText: label,
//             validator: (value) =>
//                 (value == null || value.isEmpty) ? "Required" : null,
//           ),
//         ],
//       ),
//     );
//   }

//   void _handleSignup(BuildContext context) async {
//     // 1. Create the UserModel from the controllers
//     final newUser = UserModel(
//       id: '', // ID will be set inside AppAuth using the Firebase UID
//       fullName: FullName(
//         firstName: firstNameController.text.trim(),
//         lastName: lastNameController.text.trim(),
//       ),
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//       phone: phoneController.text.trim(),
//       profileImage: '', // Default empty
//       birthDate: DateTime.tryParse(birthdateController.text) ?? DateTime.now(),
//     );

//     // 2. Call the updated AppAuth method
//     User? firebaseUser = await AppAuth().signUpWithEmailPassword(newUser);

//     if (firebaseUser != null) {
//       // Success Dialog
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         animType: AnimType.scale,
//         customHeader: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
//           child: const Icon(Icons.check_circle_outline,
//               color: Colors.white, size: 40),
//         ),
//         title: 'Signup Successful',
//         desc: 'Please check your email to verify your account.',
//         btnOkOnPress: () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => Login()),
//           );
//         },
//       ).show();
//     } else {
//       // Error Dialog
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.scale,
//         customHeader: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//           child: const Icon(Icons.error_outline, color: Colors.white, size: 40),
//         ),
//         title: 'Signup Failed',
//         desc: 'Something went wrong. Please try again.',
//         btnOkOnPress: () {},
//       ).show();
//     }
//   }
// }

// add loading

// --- Ensure these paths match your folder structure exactly ---
// import 'package:appwithfirebase/models/user_model.dart';
// import 'package:appwithfirebase/services/app_auth.dart';
// import 'package:appwithfirebase/screens/login.dart';
// import 'package:appwithfirebase/widgets/button2.dart';
// import 'package:appwithfirebase/widgets/my_text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false; // Tracking the loading state

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthdateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Show Date Picker for Birthday
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 6570),
      ), // ~18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthdateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  // Handle the Signup Logic
  void _handleSignup(BuildContext context) async {
    // 1. Show Loading
    setState(() => isLoading = true);

    try {
      // 2. Prepare the User Model
      final newUser = UserModel(
        //  id: '', // Set by Firebase UID inside AppAuth
        fullName: FullName(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
        ),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: '',
        birthDate:
            DateTime.tryParse(birthdateController.text) ?? DateTime.now(),
        role: AppAuth.role,
      );

      // 3. Call Firebase Service
      User? firebaseUser = await AppAuth().signUpWithEmailPassword(newUser);

      if (firebaseUser != null) {
        if (!mounted) return;
        // Success Message
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          customHeader: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 40,
            ),
          ),
          title: 'Signup Successful',
          desc: 'Verification email sent to ${newUser.email}.',
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          btnOkColor: AppColors.blue,
        ).show();
      } else {
        throw Exception("Signup failed: User was null");
      }
    } catch (e) {
      if (!mounted) return;
      // Error Message
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        customHeader: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline, color: Colors.white, size: 40),
        ),
        title: 'Signup Error',
        desc: 'Could not create account. Please try again later.',
        btnOkOnPress: () {},
        btnOkColor: AppColors.blue,
      ).show();
    } finally {
      // 4. Stop Loading
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text("Create Account"),
        //   scrolledUnderElevation: 0,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFieldLabel(
                            "First Name",
                            width: 165.w,
                            controller: firstNameController,
                          ),
                          _buildFieldLabel(
                            "Last Name",
                            width: 165.w,
                            controller: lastNameController,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Email"),
                      MyTextFormField(
                        controller: emailController,
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Phone Number"),
                      MyTextFormField(
                        controller: phoneController,
                        labelText: "Phone Number",
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required";
                          } else if (!RegExp(
                            r'^\+?[0-9]{7,15}$',
                          ).hasMatch(value))
                            // ignore: curly_braces_in_flow_control_structures
                            return "Enter a valid phone number";
                          else
                            // ignore: curly_braces_in_flow_control_structures
                            return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Birthdate"),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: MyTextFormField(
                            controller: birthdateController,
                            labelText: "Select your birthday",
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? "Date is required"
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Password"),
                      MyTextFormField(
                        controller: passwordController,
                        labelText: "Password",
                        obscureText: true,
                        validator: (value) =>
                            (value != null && value.length < 6)
                            ? "Min 6 characters"
                            : null,
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Confirm Password"),
                      MyTextFormField(
                        controller: confirmPasswordController,
                        labelText: "Confirm Password",
                        obscureText: true,
                        validator: (value) => (value != passwordController.text)
                            ? "Passwords don't match"
                            : null,
                      ),
                      SizedBox(height: 40.h),
                      Center(
                        child: Button2(
                          text: 'Sign Up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _handleSignup(context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Optional: Overlay loader that prevents any clicking
              if (isLoading)
                Container(
                  color: Colors.black12,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildFieldLabel(
    String label, {
    required double width,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label),
          MyTextFormField(
            controller: controller,
            labelText: label,
            validator: (value) =>
                (value == null || value.isEmpty) ? "Required" : null,
          ),
        ],
      ),
    );
  }
}
