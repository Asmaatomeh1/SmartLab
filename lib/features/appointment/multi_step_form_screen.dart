// // import 'package:appwithfirebase/appointment.dart';
// // import 'package:appwithfirebase/appointment_cubit.dart';
// // import 'package:appwithfirebase/core/theme/appcolor.dart';
// // import 'package:appwithfirebase/my_text_form_field.dart';
// // import 'package:appwithfirebase/summary_page.dart';
// // import 'package:appwithfirebase/test/test_selection_step.dart';
// // import 'package:appwithfirebase/test/test_cubit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_easy_multi_step_form/flutter_easy_multi_step_form.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class MultiStepFormScreen extends StatefulWidget {
// //   const MultiStepFormScreen({super.key});

// //   @override
// //   State<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
// // }

// // class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
// //   int currentStep = 0;
// //   final TextEditingController firstNameController = TextEditingController();

// //   final TextEditingController lastNameController = TextEditingController();

// //   final TextEditingController emailController = TextEditingController();

// //   final _formKey = GlobalKey<FormState>();

// //   // List<Widget> steps = [
// //   //   TestSelectionStep(),

// //   //   Center(child: Text("Step 2")),

// //   //   Center(child: Text("Step 3")),

// //   //   Center(child: Text("Step 4")),
// //   // ];

// //   @override
// //   Widget build(BuildContext context) {
// //     final testState = context.read<TestCubit>().state;
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: MultiBlocProvider(
// //         providers: [
// //           BlocProvider(create: (_) => TestCubit()..loadTests()),
// //           BlocProvider(create: (_) => AppointmentCubit()..initialize()),
// //         ],
// //         child: Form(
// //           //key: _formKey,
// //           child: Theme(
// //             data: ThemeData(
// //               primarySwatch: Colors.blue,
// //               visualDensity: VisualDensity.adaptivePlatformDensity,
// //               // Use the default Material 3 colors
// //               colorScheme: ColorScheme.fromSwatch().copyWith(
// //                 // primary: AppColors.blue,
// //                 // secondary: AppColors.white,
// //                 // error: AppColors.white,
// //               ),

// //               //useMaterial3: true,
// //             ),
// //             child: MultiStepFormWidget(
// //               onSubmit: () {
// //                 if (_formKey.currentState!.validate()) {

// //                   // Push the tests from Page 1 into the book function of Page 2's Cubit
// //                   context.read<AppointmentCubit>().book(
// //                     selectedTests: testState.selectedTests,
// //                     totalAmount: context.read<TestCubit>().totalPrice,
// //                   );

// //                   print('First Name: ${firstNameController.text}');
// //                   print('Form submitted successfully');
// //                 }
// //               },
// //               steps: [
// //                 // FormStep(
// //                 //   title: 'Select Tests',
// //                 //   fields: [
// //                 // MyTextFormField(
// //                 //   labelText: 'Test Name',
// //                 //   controller: TextEditingController(),
// //                 //   fontSize: 14,
// //                 //   onChanged:
// //                 // ),

// //                 //     ListView.builder(
// //                 //       shrinkWrap: true,
// //                 //       physics: NeverScrollableScrollPhysics(),

// //                 //       itemCount: testModels.length,
// //                 //       itemBuilder: (context, index) {
// //                 //         return ChoiceChip(
// //                 //           label: ListTile(
// //                 //             selectedTileColor: AppColors.blue,

// //                 //             title: Text(testModels[index].name),
// //                 //             subtitle: Text(testModels[index].description),
// //                 //             trailing: Text('\$${testModels[index].price}'),
// //                 //           ),
// //                 //           //selected: true,
// //                 //           selected: selectedIdTests.contains(testModels[index].id),
// //                 //           onSelected: (selected) {
// //                 //             // Handle tap
// //                 //             print('Selected Test: ${testModels[index].toJson()}');
// //                 //             setState(() {
// //                 //               if (selected) {
// //                 //                 selectedIdTests.add(testModels[index].id);
// //                 //               } else {
// //                 //                 selectedIdTests.remove(testModels[index].id);
// //                 //               }
// //                 //             });
// //                 //           },

// //                 //           // child: ListTile(
// //                 //           //   title: Text(testModels[index].name),
// //                 //           //   subtitle: Text(testModels[index].description),
// //                 //           //   trailing: Text('\$${testModels[index].price}'),
// //                 //           // ),
// //                 //           //selectedColor: AppColors.blue,
// //                 //           //selectedShadowColor: AppColors.blue.withOpacity(0.05),
// //                 //           backgroundColor: Colors.white,
// //                 //           color: WidgetStateProperty.resolveWith<Color>((states) {
// //                 //             if (states.contains(WidgetState.selected)) {
// //                 //               return AppColors.blue.withOpacity(0.2);
// //                 //             }
// //                 //             if (states.contains(WidgetState.hovered) ||
// //                 //                 states.contains(WidgetState.focused) ||
// //                 //                 states.contains(WidgetState.pressed)) {
// //                 //               return AppColors.blue.withOpacity(0.1);
// //                 //             }
// //                 //             return Colors
// //                 //                 .white; // Default color when no state is active
// //                 //           }),
// //                 //         );
// //                 //       },
// //                 //     ),
// //                 //   ],
// //                 // ),
// //                 FormStep(
// //                   title: 'Select Tests',
// //                   fields: [
// //                     // Add your test selection fields here
// //                     //TestSelectionStep(),
// //                     Container(
// //                       height: 520.h,
// //                       child: const TestSelectionStep(),
// //                       // color: const Color.fromARGB(255, 164, 29, 29),
// //                       //color: Colors.yellow,
// //                     ),
// //                   ],
// //                 ),
// //                 FormStep(
// //                   title: 'pick Appointment',
// //                   fields: [Container(height: 520.h, child: AppointmentPage())],
// //                 ),
// //                 // FormStep(
// //                 //   title: 'Personal Information',
// //                 //   fields: [
// //                 //     EasyTextFormField(
// //                 //       controller: firstNameController,
// //                 //       label: 'First Name',
// //                 //       validator: (value) =>
// //                 //           value!.isEmpty ? 'First name is required' : null,
// //                 //     ),
// //                 //     TextFormField(
// //                 //       decoration: InputDecoration(labelText: 'Last Name'),
// //                 //     ),
// //                 //   ],
// //                 // ),
// //                 FormStep(
// //                   title: '',
// //                   fields: [Container(height: 520.h, child: SummaryPage())],
// //                 ),
// //               ],
// //               nextButtonColor: AppColors.blue,
// //               prevButtonColor: AppColors.grey,
// //               submitButtonColor: AppColors.blue,
// //               nextButtonTextColor: Colors.white,
// //               prevButtonTextColor: Colors.white,
// //               submitButtonTextColor: Colors.white,
// //               stepIndicatorActiveColor: AppColors.blue,
// //               stepIndicatorDefaultColor: const Color(0xFF757575),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:appwithfirebase/appointment.dart';
// import 'package:appwithfirebase/appointment_cubit.dart';
// import 'package:appwithfirebase/appointment_state.dart';
// import 'package:appwithfirebase/core/theme/appcolor.dart';
// import 'package:appwithfirebase/summary_page.dart';
// import 'package:appwithfirebase/test/test_cubit.dart';
// import 'package:appwithfirebase/test/test_selection_step.dart';

// import 'package:appwithfirebase/test_state.dart';
// import 'package:appwithfirebase/user_page.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easy_multi_step_form/flutter_easy_multi_step_form.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MultiStepFormScreen extends StatefulWidget {
//   const MultiStepFormScreen({super.key});

//   @override
//   State<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
// }

// class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // FIX 1: Wrap everything in the Provider FIRST
//     return Theme(
//       data: Theme.of(context).copyWith(
//         primaryColor: AppColors.blue,
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           secondary: AppColors.blue,
//         ),
//       ),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (_) => TestCubit()..loadTests()),
//           BlocProvider(create: (_) => AppointmentCubit()..initialize()),
//         ],
//         child: BlocListener<AppointmentCubit, AppointmentState>(
//           listener: (context, state) {
//             if (state is AppointmentInitial) {
//               _showErrorDialog(context, "Please select a date and time.");
//             }
//             if (state is AppointmentError) {
//               _showErrorDialog(context, state.message);
//               context.read<AppointmentCubit>().resetSelection();
//             }
//             if (state is AppointmentLoading) {
//               Center(child: CircularProgressIndicator());
//             }
//             if (state is AppointmentBookingSuccess) {
//               _showSuccessDialog(context, "Appointment booked successfully!");
//             }
//           },
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             // FIX 2: Use Builder so 'context' can find the Cubits above
//             body: Builder(
//               builder: (context) {
//                 return Form(
//                   key: _formKey, // Ensure this is active
//                   child: MultiStepFormWidget(
//                     onSubmit: () {
//                       if (_formKey.currentState!.validate()) {
//                         if (context.read<TestCubit>().state is! TestLoaded) {
//                           _showErrorDialog(
//                             context,
//                             "Tests are still loading. Please wait.",
//                           );
//                           return;
//                         }
//                         final testCubit = context.read<TestCubit>();
//                         final apptCubit = context.read<AppointmentCubit>();

//                         // Use the getters you created in the Cubit
//                         // if (testCubit.selectedTests.isEmpty) {
//                         //   _showErrorDialog(
//                         //     context,
//                         //     "Please select at least one test.",
//                         //   );
//                         //   return;
//                         // }

//                         // if (apptCubit.selectedTime == null ||
//                         //     apptCubit.selectedDate == null) {
//                         //   _showErrorDialog(
//                         //     context,
//                         //     "Please pick a date and time.",
//                         //   );
//                         //   return;
//                         // }

//                         // If we reach here, data is valid

//                         apptCubit.book(
//                           selectedTests: testCubit.selectedTests,
//                           totalAmount: testCubit.totalPrice,
//                         );
//                       }
//                     },
//                     steps: [
//                       FormStep(
//                         title: 'Select Tests',
//                         fields: [
//                           SizedBox(
//                             height: 520.h,
//                             child: const TestSelectionStep(),
//                           ),
//                         ],
//                       ),
//                       FormStep(
//                         title: 'Pick Appointment',
//                         fields: [
//                           SizedBox(
//                             height: 520.h,
//                             child: const AppointmentPage(),
//                           ),
//                         ],
//                       ),
//                       FormStep(
//                         title: 'Summary',
//                         fields: [
//                           SizedBox(
//                             height: 520.h,
//                             child: const SummaryPage(),
//                             //   width: 800,
//                           ),
//                         ],
//                       ),
//                     ],
//                     nextButtonColor: AppColors.blue,
//                     nextButtonTextColor: Colors.white,
//                     submitButtonColor: AppColors.blue,
//                     prevButtonColor: Color.fromARGB(
//                       255,
//                       225,
//                       227,
//                       228,
//                     ), // Grey color
//                     prevButtonTextColor: Colors.black,

//                     // ... other styling
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.error,
//       title: 'Error',
//       animType: AnimType.scale,
//       // customHeader: Container(
//       //   padding: const EdgeInsets.all(16),
//       //   decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//       //   child: const Icon(Icons.error_outline, color: Colors.white, size: 40),
//       // ),
//       btnOkOnPress: () {},
//       btnOkColor: AppColors.blue,
//       desc: message,
//     ).show();
//   }

//   void _showSuccessDialog(BuildContext context, String message) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.success,
//       title: 'Success',
//       animType: AnimType.scale,
//       // customHeader: Container(
//       //   padding: const EdgeInsets.all(16),
//       //   decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
//       //   child: const Icon(
//       //     Icons.check_circle_outline,
//       //     color: Colors.white,
//       //     size: 40,
//       //   ),
//       // ),
//       btnOkOnPress: () {},
//       btnOkColor: AppColors.blue,
//       desc: message,
//     ).show();
//   }
// }

// multi_step_form_screen.dart
import 'package:appwithfirebase/features/appointment/appointment.dart';
import 'package:appwithfirebase/features/appointment/appointment_cubit.dart';
import 'package:appwithfirebase/features/appointment/appointment_state.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/features/appointment/summary_page.dart';
import 'package:appwithfirebase/features/test/test_cubit.dart';
import 'package:appwithfirebase/features/test/test_selection_step.dart';
import 'package:appwithfirebase/test_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_multi_step_form/flutter_easy_multi_step_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiStepFormScreen extends StatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  State<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TestCubit()..loadTests()),
        BlocProvider(create: (_) => AppointmentCubit()..initialize()),
      ],
      child: BlocListener<AppointmentCubit, AppointmentState>(
        listener: _appointmentListener,
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: AppColors.blue,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppColors.blue,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: MultiStepFormWidget(
                  steps: _buildSteps(),
                  onSubmit: () => _onSubmit(context),
                  nextButtonColor: AppColors.blue,
                  nextButtonTextColor: Colors.white,
                  submitButtonColor: AppColors.blue,
                  prevButtonColor: const Color(0xFFE1E3E4),
                  prevButtonTextColor: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<FormStep> _buildSteps() => [
    FormStep(
      title: 'Select Tests',
      fields: [SizedBox(height: 520.h, child: const TestSelectionStep())],
    ),
    FormStep(
      title: 'Pick Appointment',
      fields: [SizedBox(height: 520.h, child: const AppointmentPage())],
    ),
    FormStep(
      title: 'Summary',
      fields: [SizedBox(height: 520.h, child: const SummaryPage())],
    ),
  ];

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final testCubit = context.read<TestCubit>();
    final apptCubit = context.read<AppointmentCubit>();

    if (testCubit.state is! TestLoaded) {
      _showErrorDialog(context, 'Tests are still loading. Please wait.');
      return;
    }
    if ((testCubit.state as TestLoaded).selectedTests.isEmpty) {
      _showErrorDialog(context, 'Please select at least one test.');
      return;
    }
    if (apptCubit.selectedTime == null) {
      _showErrorDialog(context, 'Please pick a date and time.');
      return;
    }

    apptCubit.book(
      selectedTests: testCubit.selectedTests,
      totalAmount: testCubit.totalPrice,
    );
  }

  void _appointmentListener(BuildContext context, AppointmentState state) {
    if (state is AppointmentBookingSuccess) {
      _showSuccessDialog(context, 'Appointment booked successfully!');
    } else if (state is AppointmentError) {
      _showErrorDialog(context, state.message);
      context.read<AppointmentCubit>().resetSelection();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,

      desc: message,
      btnOkOnPress: () {},
      btnOkColor: AppColors.blue,
    ).show();
  }

  void _showSuccessDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      desc: message,
      btnOkOnPress: () {
        Navigator.of(context).pop();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserPage()));
      },
      btnOkColor: AppColors.blue,
    ).show();
  }
}
