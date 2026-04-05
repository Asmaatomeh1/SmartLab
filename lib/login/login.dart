import 'package:appwithfirebase/auth.dart';
import 'package:appwithfirebase/button2.dart';
import 'package:appwithfirebase/admin_page.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:appwithfirebase/forget_password/forget_password_page.dart';
import 'package:appwithfirebase/login/login_cubit.dart';
import 'package:appwithfirebase/login/login_status.dart';
import 'package:appwithfirebase/my_text_form_field.dart';
import 'package:appwithfirebase/signup.dart';
import 'package:appwithfirebase/user_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Login extends StatelessWidget {
//   Login({super.key});
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 hintText: 'Enter your email',
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 hintText: 'Enter your password',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _login(context),
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _login(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       if (context.mounted) {
//         Navigator.pushNamed(context, '/home');
//       }
//     } on FirebaseAuthException catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(e.message ?? 'Login failed. Please try again.'),
//           ),
//         );
//       }
//     }
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Login extends StatelessWidget {
//   Login({super.key});

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),

//             const SizedBox(height: 10),

//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () => login(context),
//               child: const Text("Login"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future login(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'signup.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final email = TextEditingController();
//   final password = TextEditingController();

//   Future signIn() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email.text.trim(),
//       password: password.text.trim(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: email,
//               decoration: const InputDecoration(labelText: "Email"),
//             ),

//             const SizedBox(height: 10),

//             TextField(
//               controller: password,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: "Password"),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton(onPressed: signIn, child: const Text("Sign In")),

//             const SizedBox(height: 20),

//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Signup()),
//                 );
//               },
//               child: const Text("Create Account"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Login extends StatelessWidget {
//   Login({super.key});
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 250),
//                 Text(" Email", style: AppFonts.subtitleBlackMedium),
//                 const SizedBox(height: 8),
//                 MyTextFormField(
//                   controller: emailController,
//                   labelText: "Email",
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your email";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Text(" Password", style: AppFonts.subtitleBlackMedium),
//                 const SizedBox(height: 8),
//                 MyTextFormField(
//                   controller: passwordController,
//                   labelText: "Password",
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your password";
//                     }
//                     return null;
//                   },
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text("Forgot Password?"),
//                 ),
//                 SizedBox(height: 100),
//                 Center(
//                   child: Button2(
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         // Process the login
//                         // final email = emailController.text.trim();
//                         // final password = passwordController.text.trim();
//                         // print("Email: $email, Password: $password");

//                         // Perform login with Firebase

//                         //  User? user= await AppAuth().signInWithEmailPassword(email, password);

//                         // if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                         //   Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => StartScreen(),
//                         //     ),
//                         //   );
//                         // }

//                         _login(context);
//                       }
//                     },
//                     text: 'Login',
//                   ),
//                 ),
//                 if (AppAuth.role == 'user')
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to the signup screen
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => Signup()),
//                       );
//                     },
//                     child: const Text("Create Account"),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _login(BuildContext context) async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     User? user = await AppAuth().signInWithEmailPassword(email, password);

//     if (user != null) {
//       // Navigate to the home screen
//       final fireStoreUser = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (fireStoreUser.exists) {
//         String role = fireStoreUser.get('role');
//         if (role == AppAuth.role) {
//           if (role == 'user') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => UserPage()),
//             );
//           } else if (role == 'admin') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AdminPage()),
//             );

//             print("User role matches: $role");
//           }
//         } else {
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.error,
//             animType: AnimType.scale,
//             title: 'Login Failed',
//             desc: 'User role does not match',
//             // btnCancelOnPress: () {},
//             btnOkOnPress: () {},
//             btnCancelColor: AppColors.grey,
//             btnOkColor: AppColors.blue,
//             customHeader: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.error_outline,
//                 color: Colors.white,
//                 size: 40,
//               ),
//             ),
//           ).show();
//           print("User role does not match: $role");
//         }
//         //  print( "in fire store User role: $role");
//       } else {
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           animType: AnimType.scale,
//           title: 'Login Failed',
//           // desc: 'No such user in Firestore',
//           // btnCancelOnPress: () {},
//           btnOkOnPress: () {},
//           btnCancelColor: AppColors.grey,
//           btnOkColor: AppColors.blue,
//           customHeader: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.error_outline,
//               color: Colors.white,
//               size: 40,
//             ),
//           ),
//         ).show();
//         print("No such user in Firestore");
//       }
//     } else {
//       // Show error
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.scale,
//         title: 'Login Failed',
//         desc: 'Invalid email or password',
//         // btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//         btnCancelColor: AppColors.grey,
//         btnOkColor: AppColors.blue,
//         customHeader: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//           child: const Icon(Icons.error_outline, color: Colors.white, size: 40),
//         ),
//       ).show();
//       print("Login failed");
//     }
//   }
// }

// add cubit

class Login extends StatelessWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Scaffold(
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: 'Error',
                  animType: AnimType.scale,
                  customHeader: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  btnOkOnPress: () {},
                  btnOkColor: AppColors.blue,
                  desc: state.message,
                ).show();
              }
              if (state is LoginSuccess) {
                if (state.role == 'admin') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const UserPage()),
                  );
                }
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // ... Your TextFields here ...
                        SizedBox(height: 200.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Email",
                              style: AppFonts.subtitleBlackMedium.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            const SizedBox(height: 8),
                            MyTextFormField(
                              controller: emailController,
                              labelText: "Email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              " Password",
                              style: AppFonts.subtitleBlackMedium.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            const SizedBox(height: 8),
                            MyTextFormField(
                              controller: passwordController,
                              labelText: "Password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),

                        //Text('Forgot Password?', style: AppFonts.subtitleBlackMedium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: AppFonts.subtitleGreyMedium.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        state is LoginLoading
                            ? const CircularProgressIndicator()
                            : Button2(
                                text: "Login",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                      AppAuth.role,
                                    );
                                  }
                                },
                              ),
                        const SizedBox(height: 20),
                        AppAuth.role == 'user'
                            ? Center(
                                child: Text.rich(
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Sign up",
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Signup(),
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //   _forgotPassword(BuildContext context) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Forgot Password'),
  //           content: const Text('Please enter your email to reset your password.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 // Handle password reset
  //               },
  //               child: const Text('Submit'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
}
