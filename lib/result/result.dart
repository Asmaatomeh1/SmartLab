// import 'package:appwithfirebase/appointment_cubit.dart';
// import 'package:appwithfirebase/appointment_state.dart';
// import 'package:appwithfirebase/model/test_model.dart';
// import 'package:appwithfirebase/multi_step_form_screen.dart';
// import 'package:appwithfirebase/multi_step_form_screen_for_edit.dart';
// import 'package:appwithfirebase/result_cubit.dart';
// import 'package:appwithfirebase/result_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ResultsScreen extends StatelessWidget {
//   const ResultsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ResultCubit()..fetchUserResults()),
//         //BlocProvider(create: (context) => AppointmentCubit()..initialize()),
//       ],
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text("My Test Results"),
//             bottom: const TabBar(
//               tabs: [
//                 Tab(text: "Pending"),
//                 Tab(text: "Completed"),
//                 Tab(text: "Missed"),
//               ],
//             ),
//           ),
//           body: BlocConsumer<ResultCubit, ResultState>(
//             listener: (context, state) {
//               if (state is ResultError) {
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text(state.message)));
//               }
//               // if (state is AppointmentDeleteSuccess) {
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(content: Text("Appointment deleted")),
//               //   );
//               // }
//               // if (state is AppointmentEdit) {
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(content: Text("Editing appointment...")),
//               //   );
//               // }
//               // // if (state is AppointmentInitial) {
//               // //   ScaffoldMessenger.of(context).showSnackBar(

//               // //   );
//               // // }
//               // if (state is AppointmentLoading) {
//               //   ScaffoldMessenger.of(
//               //     context,
//               //   ).showSnackBar(const SnackBar(content: Text("Loading...")));
//               // }
//             },
//             builder: (context, state) {
//               if (state is ResultLoading)
//                 return const Center(child: CircularProgressIndicator());

//               if (state is ResultError) {
//                 return Center(
//                   child: Text(
//                     state.message,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 );
//               }

//               if (state is ResultLoaded) {
//                 return TabBarView(
//                   children: [
//                     _ResultList(items: state.pending, color: Colors.orange),
//                     _ResultList(
//                       items: state.completed,
//                       color: Colors.green,
//                       isCompleted: true,
//                     ),
//                     _ResultList(items: state.missed, color: Colors.red),
//                   ],
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ResultList extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//   final Color color;
//   final bool isCompleted;

//   const _ResultList({
//     required this.items,
//     required this.color,
//     this.isCompleted = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) return const Center(child: Text("No records found."));

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return Card(
//           elevation: 2,
//           margin: const EdgeInsets.only(bottom: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: color.withOpacity(0.1),
//                   child: Icon(Icons.biotech, color: color),
//                 ),
//                 title: Text("Date: ${item['date']} at ${item['time']}"),
//                 subtitle: Text(
//                   "Tests: ${(item['selectedTests'] as List).length}",
//                 ),
//                 trailing: isCompleted
//                     ? ElevatedButton(
//                         onPressed: () {
//                           /* logic to open PDF/Result */
//                         },
//                         child: const Text("View Result"),
//                       )
//                     : Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: color,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           isCompleted
//                               ? "Done"
//                               : (color == Colors.red ? "Missed" : "Pending"),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // await context.read<AppointmentCubit>().startEditAppointment(
//                   //   item['appointmentId'],
//                   // );
//                   print(
//                     "Starting edit for appointment ${item['appointmentId']} with selected tests: ${item['selectedTests']} and total amount: ${item['totalAmount']}",
//                   );
//                   // print(context.read<AppointmentCubit>().state);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MultiStepFormScreenForEdit(
//                         appointmentId: item['appointmentId'],
//                         // initialTests: (List<TestModel>.from(
//                         //   (item['selectedTests'] as List).map(
//                         //     (t) => TestModel(
//                         //       id: t['testId'] ?? '',
//                         //       name: t['testName'] ?? '',
//                         //       price: (t['priceAtBooking'] ?? 0).toDouble(),
//                         //       description: '',
//                         //     ),
//                         //   ),
//                         // )),
//                       ),
//                     ),
//                   );
//                   // context.read<AppointmentCubit>().editAppointment(
//                   //   selectedTests: item['selectedTests'],
//                   //   totalAmount: item['totalAmount'],
//                   //   appointmentId: item['appointmentId'],
//                   // );
//                   // context.read<AppointmentCubit>().
//                 },
//                 child: const Text("Edit"),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: () {
//                   // Logic to delete the appointment
//                   context.read<AppointmentCubit>().deleteAppointment(
//                     item['appointmentId'],
//                   );
//                   print("Deleting appointment ${item['appointmentId']}");
//                 },
//                 child: const Text("Delete"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//results_screen.dart
import 'package:appwithfirebase/appointment/appointment_cubit.dart';
import 'package:appwithfirebase/shared_widget/button1.dart';
import 'package:appwithfirebase/shared_widget/button2.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:appwithfirebase/appointment/multi_step_form_screen_for_edit.dart';
import 'package:appwithfirebase/result/pdf_view_screen.dart';
import 'package:appwithfirebase/result/result_cubit.dart';
import 'package:appwithfirebase/result/result_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      child: BlocProvider(
        create: (_) => ResultCubit()..fetchUserResults(),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Missed'),
                ],
              ),
            ),
            body: BlocConsumer<ResultCubit, ResultState>(
              listener: (context, state) {
                if (state is ResultError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is ResultLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ResultError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is ResultLoaded) {
                  return TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          context.read<ResultCubit>().fetchUserResults();
                        },
                        child: _ResultList(
                          items: state.pending,
                          status: 'pending',
                        ),
                      ),

                      RefreshIndicator(
                        onRefresh: () async {
                          context.read<ResultCubit>().fetchUserResults();
                        },
                        child: _ResultList(
                          items: state.completed,
                          status: 'completed',
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          context.read<ResultCubit>().fetchUserResults();
                        },
                        child: _ResultList(
                          items: state.missed,
                          status: 'missed',
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Result List ─────────────────────────────────────────────────────────────

class _ResultList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String status; // 'pending' | 'completed' | 'missed'

  const _ResultList({required this.items, required this.status});

  Color get _statusColor {
    return switch (status) {
      // ignore: deprecated_member_use
      'completed' => Colors.green.withOpacity(0.12),
      'missed' => Colors.red.withOpacity(0.12),
      _ => const Color(0xFFFFF2E0),
    };
  }

  Color get _statusColorText {
    return switch (status) {
      // ignore: deprecated_member_use
      'completed' => Colors.green,
      'missed' => Colors.red,
      _ => const Color(0xFFD97706),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No records found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _AppointmentCard(
          item: item,
          statusColor: _statusColor,
          status: status,
          textColor: _statusColorText,
        );
      },
    );
  }
}

// ─── Appointment Card ─────────────────────────────────────────────────────────

class _AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Color statusColor;
  final String status;
  final Color textColor;

  const _AppointmentCard({
    required this.item,
    required this.statusColor,
    required this.status,
    required this.textColor,
  });

  String get _appointmentId => item['appointmentId'] as String? ?? '';

  @override
  Widget build(BuildContext context) {
    final tests = item['selectedTests'] as List? ?? [];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: CircleAvatar(
                // ignore: deprecated_member_use
                backgroundColor: AppColors.blue.withOpacity(0.12),
                child: const Icon(Icons.biotech, color: AppColors.blue),
              ),
              title: Text(
                '${item['date']}  at  ${item['time']}',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 18,
                  //fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              subtitle: Text(
                '${tests.length} test${tests.length == 1 ? '' : 's'}'
                '  |  Total: ${item['totalPrice'] ?? '—'} ₪',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              ),
              trailing: _StatusBadge(
                status: status,
                color: statusColor,
                onViewResult: status == 'completed'
                    ? () => _onViewResult(context, _appointmentId)
                    : null,
                textColor: textColor,
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 8),
            // Show test names
            if (tests.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tests.map((t) {
                    final name = t['testName'] as String? ?? 'Test';
                    return Chip(
                      label: Text(
                        name,
                        style: AppFonts.subtitle.copyWith(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 42, 85, 179),
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: const Color.fromARGB(154, 211, 224, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 10),
            if (status == 'completed')
              SizedBox(
                width: 0,
                // height: 56,
                child: Button2(
                  onPressed: () => _onViewResult(context, _appointmentId),
                  text: 'View Result',
                  size: Size(10, 18),
                  width: 5,
                  height: 5,
                ),
              ),
            if (status != 'completed')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onEdit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          foregroundColor: Colors.blue.shade50,
                        ),
                        child: Text(
                          'Edit Test',
                          style: AppFonts.subtitle.copyWith(
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 42,
                        // width: 1,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade700),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: () => _confirmDelete(context),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red.shade700,
                          ),
                          child: Text(
                            'Delete Test',
                            style: AppFonts.subtitle.copyWith(
                              color: Colors.red.shade700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            MultiStepFormScreenForEdit(appointmentId: _appointmentId),
      ),
    );
  }

  void _onViewResult(BuildContext context, String appointmentId) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserViewPage(appointmentId: appointmentId),
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening result...')));
  }

  // FIX: Use a locally created AppointmentCubit so we don't rely on
  // an ancestor provider that may not exist.
  void _confirmDelete(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      desc: 'This action cannot be undone.',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // Create a one-shot cubit for the delete operation.
        AppointmentCubit().deleteAppointment(_appointmentId).then((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment deleted.')),
            );
            // Refresh the results list
            context.read<ResultCubit>().fetchUserResults();
          }
        });
      },
      btnOkText: 'Delete',
      btnOkColor: Colors.red,
    ).show();
  }
}

// ─── Status Badge ────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  final VoidCallback? onViewResult;
  final Color textColor;

  const _StatusBadge({
    required this.textColor,
    required this.status,
    required this.color,
    this.onViewResult,
  });

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      'missed' => 'Missed',
      'completed' => 'Completed',
      'pending' => 'Pending',
      // TODO: Handle this case.
      _ => 'Unknown',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// results_screen.dart
// import 'package:appwithfirebase/appointment_cubit.dart';
// import 'package:appwithfirebase/appointment_state.dart';
// import 'package:appwithfirebase/core/theme/appcolor.dart';
// import 'package:appwithfirebase/core/theme/appfont.dart';
// import 'package:appwithfirebase/multi_step_form_screen_for_edit.dart';
// import 'package:appwithfirebase/result_cubit.dart';
// import 'package:appwithfirebase/result_state.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ResultsScreen extends StatelessWidget {
//   const ResultsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         primaryColor: Colors.blue,
//         colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
//       ),
//       child: BlocProvider(
//         create: (_) => ResultCubit()..fetchUserResults(),
//         child: DefaultTabController(
//           length: 3,
//           child: Scaffold(
//             appBar: AppBar(
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(text: 'Pending'),
//                   Tab(text: 'Completed'),
//                   Tab(text: 'Missed'),
//                 ],
//               ),
//             ),
//             body: BlocConsumer<ResultCubit, ResultState>(
//               listener: (context, state) {
//                 if (state is ResultError) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(state.message)));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ResultLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (state is ResultError) {
//                   return Center(
//                     child: Text(
//                       state.message,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }
//                 if (state is ResultLoaded) {
//                   return TabBarView(
//                     children: [
//                       RefreshIndicator(
//                         onRefresh: () async {
//                           context.read<ResultCubit>().fetchUserResults();
//                         },
//                         child: _ResultList(
//                           items: state.pending,
//                           status: 'pending',
//                         ),
//                       ),
//                       RefreshIndicator(
//                         onRefresh: () async {
//                           context.read<ResultCubit>().fetchUserResults();
//                         },
//                         child: _ResultList(
//                           items: state.completed,
//                           status: 'completed',
//                         ),
//                       ),
//                       RefreshIndicator(
//                         onRefresh: () async {
//                           context.read<ResultCubit>().fetchUserResults();
//                         },
//                         child: _ResultList(
//                           items: state.missed,
//                           status: 'missed',
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─── Result List ─────────────────────────────────────────────────────────────

// class _ResultList extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//   final String status; // 'pending' | 'completed' | 'missed'

//   const _ResultList({required this.items, required this.status});

//   Color get _statusColor {
//     return switch (status) {
//       'completed' => AppColors.blue.withOpacity(0.12),
//       'missed' => Colors.red,
//       _ => const Color(0xFFFFF2E0),
//     };
//   }

//   Color get _statusColorText {
//     return switch (status) {
//       'completed' => AppColors.blue,
//       'missed' => Colors.red,
//       _ => const Color(0xFFD97706),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) {
//       return const Center(child: Text('No records found.'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return _AppointmentCard(
//           item: item,
//           statusColor: _statusColor,
//           status: status,
//           textColor: _statusColorText,
//         );
//       },
//     );
//   }
// }

// // ─── Appointment Card ─────────────────────────────────────────────────────────

// class _AppointmentCard extends StatelessWidget {
//   final Map<String, dynamic> item;
//   final Color statusColor;
//   final String status;
//   final Color textColor;

//   const _AppointmentCard({
//     required this.item,
//     required this.statusColor,
//     required this.status,
//     required this.textColor,
//   });

//   String get _appointmentId => item['appointmentId'] as String? ?? '';

//   @override
//   Widget build(BuildContext context) {
//     final tests = item['selectedTests'] as List? ?? [];

//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: AppColors.blue.withOpacity(0.12),
//                 child: Icon(Icons.biotech, color: AppColors.blue),
//               ),
//               title: Text(
//                 '${item['date']}  at  ${item['time']}',
//                 style: AppFonts.subtitle.copyWith(
//                   fontSize: 18,
//                   color: AppColors.black,
//                 ),
//               ),
//               subtitle: Text(
//                 '${tests.length} test${tests.length == 1 ? '' : 's'}'
//                 '  |  Total: ${item['totalPrice'] ?? '—'} ₪',
//                 style: AppFonts.subtitle.copyWith(
//                   fontSize: 12,
//                   color: AppColors.grey,
//                 ),
//               ),
//               trailing: _StatusBadge(
//                 status: status,
//                 color: statusColor,
//                 onViewResult: status == 'completed'
//                     ? () => _onViewResult(context)
//                     : null,
//                 textColor: textColor,
//               ),
//             ),
//             const Divider(height: 1),
//             const SizedBox(height: 8),
//             // Show test names
//             if (tests.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Wrap(
//                   spacing: 6,
//                   runSpacing: 4,
//                   children: tests.map((t) {
//                     final name = t['testName'] as String? ?? 'Test';
//                     return Chip(
//                       label: Text(
//                         name,
//                         style: AppFonts.subtitle.copyWith(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 42, 85, 179),
//                         ),
//                       ),
//                       visualDensity: VisualDensity.compact,
//                       backgroundColor: const Color.fromARGB(154, 211, 224, 253),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             const SizedBox(height: 10),
//             if (status != 'completed')
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => _onEdit(context),
//                         child: Text(
//                           'Edit Test',
//                           style: AppFonts.subtitle.copyWith(
//                             fontSize: 18,
//                             color: AppColors.white,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.blue,
//                           foregroundColor: Colors.blue.shade50,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Container(
//                         height: 42,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.red.shade700),
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: TextButton(
//                           onPressed: () => _confirmDelete(context),
//                           child: Text(
//                             'Delete Test',
//                             style: AppFonts.subtitle.copyWith(
//                               color: Colors.red.shade700,
//                               fontSize: 18,
//                             ),
//                           ),
//                           style: TextButton.styleFrom(
//                             foregroundColor: Colors.red.shade700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ────────────────────────────────────────────────────────────────────────
//   // ──── OPEN RESULT FILE FROM FIRESTORE ────────────────────────────────────
//   // ────────────────────────────────────────────────────────────────────────
//   //
//   // Flow:
//   //   1. Show loading indicator
//   //   2. Query `results` collection where appointmentId == this appointment
//   //   3. Get the `fileUrl` field (Firebase Storage download URL)
//   //   4. Launch it with url_launcher
//   //
//   Future<void> _onViewResult(BuildContext context) async {
//     // ── Step 1: Show loading snackbar ──
//     final messenger = ScaffoldMessenger.of(context);
//     messenger.showSnackBar(
//       const SnackBar(
//         content: Row(
//           children: [
//             SizedBox(
//               width: 18,
//               height: 18,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             ),
//             SizedBox(width: 14),
//             Text('Loading result...'),
//           ],
//         ),
//         duration: Duration(seconds: 10),
//       ),
//     );

//     try {
//       // ── Step 2: Fetch result document using ResultCubit method ──
//       final resultCubit = context.read<ResultCubit>();
//       final result = await resultCubit.fetchResultForAppointment(
//         _appointmentId,
//       );

//       messenger.hideCurrentSnackBar();

//       // ── Step 3: Guard - no result uploaded yet ──
//       if (result == null) {
//         _showNoResultDialog(context);
//         return;
//       }

//       final fileUrl = result['fileUrl'] as String?;
//       if (fileUrl == null || fileUrl.isEmpty) {
//         _showNoResultDialog(context);
//         return;
//       }

//       // ── Step 4: Launch the URL ──
//       final uri = Uri.parse(fileUrl);
//       final canOpen = await canLaunchUrl(uri);

//       if (!canOpen) {
//         if (context.mounted) {
//           _showErrorLaunchDialog(context);
//         }
//         return;
//       }

//       // Launch in external application (browser / PDF viewer)
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       messenger.hideCurrentSnackBar();
//       if (context.mounted) {
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           title: 'Error',
//           desc: 'Failed to load result: ${e.toString()}',
//           btnOkOnPress: () {},
//           btnOkColor: AppColors.blue,
//         ).show();
//       }
//     }
//   }

//   void _showNoResultDialog(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.info,
//       title: 'Not Available',
//       desc:
//           'Your result file has not been uploaded yet.\n'
//           'Please check back later.',
//       btnOkOnPress: () {},
//       btnOkColor: AppColors.blue,
//     ).show();
//   }

//   void _showErrorLaunchDialog(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.error,
//       title: 'Error',
//       desc:
//           'No application found to open this file.\n'
//           'Please install a PDF viewer.',
//       btnOkOnPress: () {},
//       btnOkColor: AppColors.blue,
//     ).show();
//   }

//   // ────────────────────────────────────────────────────────────────────────

//   void _onEdit(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) =>
//             MultiStepFormScreenForEdit(appointmentId: _appointmentId),
//       ),
//     );
//   }

//   void _confirmDelete(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.warning,
//       title: 'Delete Appointment',
//       desc: 'This action cannot be undone.',
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         AppointmentCubit().deleteAppointment(_appointmentId).then((_) {
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Appointment deleted.')),
//             );
//             context.read<ResultCubit>().fetchUserResults();
//           }
//         });
//       },
//       btnOkText: 'Delete',
//       btnOkColor: Colors.red,
//     ).show();
//   }
// }

// // ─── Status Badge ────────────────────────────────────────────────────────────

// class _StatusBadge extends StatelessWidget {
//   final String status;
//   final Color color;
//   final VoidCallback? onViewResult;
//   final Color textColor;

//   const _StatusBadge({
//     required this.textColor,
//     required this.status,
//     required this.color,
//     this.onViewResult,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (onViewResult != null) {
//       return TextButton.icon(
//         onPressed: onViewResult,
//         icon: const Icon(Icons.picture_as_pdf, size: 18),
//         label: const Text('View Result'),
//         style: TextButton.styleFrom(
//           foregroundColor: Colors.green.shade700,
//           textStyle: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//       );
//     }

//     final label = switch (status) {
//       'missed' => 'Missed',
//       _ => 'Pending',
//     };

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
