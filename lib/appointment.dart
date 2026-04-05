// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class Appointment extends StatefulWidget {
// //   const Appointment({super.key});
// //   @override
// //   State<Appointment> createState() => _AppointmentState();
// // }

// // class _AppointmentState extends State<Appointment> {
// //   List<DateTime> days = [];
// //   DateTime? selectedDate;
// //   List<String> availableSlots = [];
// //   String? selectedTime;
// //   bool isLoading = false;

// //   final String testId = "example_test_id";

// //   @override
// //   void initState() {
// //     super.initState();
// //     days = getNext7Days();
// //     if (days.isNotEmpty) {
// //       // Pre-select today and fetch available slots.
// //       _onDateSelected(days.first);
// //     }
// //   }

// //   void _onDateSelected(DateTime day) async {
// //     setState(() {
// //       selectedDate = day;
// //       selectedTime = null; // Reset time selection when date changes
// //       isLoading = true;
// //       availableSlots = [];
// //     });

// //     if (day == null) {
// //       return; // Should not happen if days is not empty
// //     }

// //     final slots = await getAvailableSlots(day);

// //     if (mounted) {
// //       setState(() {
// //         availableSlots = slots;
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   List<DateTime> getNext7Days() {
// //     return List.generate(
// //       7,
// //       (index) => DateTime.now().add(Duration(days: index)),
// //     );
// //   }

// //   List<String> generateSlots(DateTime forDate) {
// //     List<String> allSlots = [];
// //     // Generate slots from 8:00 AM to 4:30 PM
// //     for (int h = 8; h < 17; h++) {
// //       allSlots.add("$h:00");
// //       allSlots.add("$h:30");
// //     }

// //     final now = DateTime.now();
// //     // Check if the date we are generating slots for is today
// //     final isToday =
// //         forDate.year == now.year &&
// //         forDate.month == now.month &&
// //         forDate.day == now.day;

// //     if (!isToday) {
// //       return allSlots; // For any future date, return all slots
// //     }

// //     // If it is today, filter out slots that are in the past
// //     return allSlots.where((slot) {
// //       final parts = slot.split(':');
// //       final hour = int.parse(parts[0]);
// //       final minute = int.parse(parts[1]);

// //       // Keep the slot if its hour is later than the current hour,
// //       // or if it's in the same hour but a later minute.
// //       return hour > now.hour || (hour == now.hour && minute > now.minute);
// //     }).toList();
// //   }

// //   Future<List<String>> getAvailableSlots(DateTime date) async {
// //     try {
// //       final dateString = date.toString().substring(0, 10);
// //       final snapshot = await FirebaseFirestore.instance
// //           .collection("appointments")
// //           .where("date", isEqualTo: dateString)
// //           .get();

// //       Map<String, int> counts = {};
// //       for (var doc in snapshot.docs) {
// //         String time = doc["time"];
// //         counts[time] = (counts[time] ?? 0) + 1;
// //       }

// //       List<String> slots = generateSlots(date);
// //       int capacity = 10; // Max 10 appointments per slot

// //       return slots.where((slot) {
// //         return (counts[slot] ?? 0) < capacity;
// //       }).toList();
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text("Error fetching slots: $e")));
// //       }
// //       return [];
// //     }
// //   }

// //   Future<void> bookAppointment() async {
// //     // Get the current user ID at the moment of booking
// //     final String? patientId = FirebaseAuth.instance.currentUser?.uid;

// //     if (selectedDate == null || selectedTime == null || patientId == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please select a date and time to book.")),
// //         //const SnackBar(content: Text("Please select a date, time, and ensure you are logged in.")),
// //       );
// //       return;
// //     }

// //     setState(() => isLoading = true);

// //     try {
// //       await FirebaseFirestore.instance.collection("appointments").add({
// //         "patientId": patientId,
// //         "testId": testId,
// //         "date": selectedDate!.toString().substring(0, 10),
// //         "time": selectedTime,
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });

// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Appointment booked successfully!")),
// //         );
// //         // Refresh slots and reset time selection
// //         _onDateSelected(selectedDate!);
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Failed to book appointment: $e")),
// //         );
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() => isLoading = false);
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Home"),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout),
// //             onPressed: () {
// //               FirebaseAuth.instance.signOut();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "Select a Date",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(
// //               height: 80,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: days.length,
// //                 itemBuilder: (context, index) {
// //                   DateTime day = days[index];
// //                   bool isSelected =
// //                       selectedDate?.day == day.day &&
// //                       selectedDate?.month == day.month &&
// //                       selectedDate?.year == day.year;
// //                   return GestureDetector(
// //                     onTap: () => _onDateSelected(day),
// //                     child: Container(
// //                       width: 60,
// //                       margin: const EdgeInsets.symmetric(
// //                         vertical: 8,
// //                         horizontal: 4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: isSelected ? Colors.blue : Colors.grey[300],
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Center(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Text(
// //                               "${day.day}",
// //                               style: TextStyle(
// //                                 color: isSelected ? Colors.white : Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             Text(
// //                               "${day.weekday == 1
// //                                   ? 'Mon'
// //                                   : day.weekday == 2
// //                                   ? 'Tue'
// //                                   : day.weekday == 3
// //                                   ? 'Wed'
// //                                   : day.weekday == 4
// //                                   ? 'Thu'
// //                                   : day.weekday == 5
// //                                   ? 'Fri'
// //                                   : day.weekday == 6
// //                                   ? 'Sat'
// //                                   : 'Sun'}",
// //                               style: TextStyle(
// //                                 color: isSelected ? Colors.white : Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Select a Time Slot",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 10),
// //             if (isLoading)
// //               const Center(child: CircularProgressIndicator())
// //             else if (availableSlots.isEmpty)
// //               const Center(child: Text("No available slots for this day."))
// //             else
// //               Wrap(
// //                 spacing: 10,
// //                 runSpacing: 10,
// //                 children: availableSlots.map((time) {
// //                   return GestureDetector(
// //                     onTap: () {
// //                       setState(() {
// //                         selectedTime = time;
// //                       });
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 12,
// //                         vertical: 8,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: selectedTime == time
// //                             ? Colors.blue
// //                             : Colors.grey[300],
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Text(
// //                         time,
// //                         style: TextStyle(
// //                           color: selectedTime == time
// //                               ? Colors.white
// //                               : Colors.black,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             const Spacer(),
// //             SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 onPressed: (selectedTime == null || isLoading)
// //                     ? null
// //                     : bookAppointment,
// //                 child: const Text("Book Appointment"),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // add cubit

// import 'package:appwithfirebase/appointment_cubit.dart';
// import 'package:appwithfirebase/appointment_state.dart' hide AppointmentInitial;
// import 'package:appwithfirebase/button1.dart';
// import 'package:appwithfirebase/core/theme/appcolor.dart';
// import 'package:appwithfirebase/core/theme/appfont.dart';
// import 'package:appwithfirebase/model/test_model.dart';
// import 'package:appwithfirebase/routes.dart';
// import 'package:appwithfirebase/test/test_cubit.dart';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // class AppointmentPage extends StatelessWidget {
// //   const AppointmentPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => AppointmentCubit()..initialize(),
// //       child: Scaffold(
// //         appBar: AppBar(title: const Text("Book Appointment")),
// //         body: BlocConsumer<AppointmentCubit, AppointmentState>(
// //           listener: (context, state) {
// //             if (state is AppointmentBookingSuccess) {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text("Booked Successfully!")),
// //               );
// //             }
// //           },
// //           builder: (context, state) {
// //             if (state is AppointmentLoading)
// //               return const Center(child: CircularProgressIndicator());
// //             if (state is AppointmentError)
// //               return Center(child: Text(state.message));

// //             if (state is AppointmentSlotsLoaded) {
// //               return Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   children: [
// //                     // --- Date Selection ---
// //                     _DateList(state: state),
// //                     const SizedBox(height: 20),
// //                     // --- Time Slots ---
// //                     _TimeGrid(state: state),
// //                     const Spacer(),
// //                     // --- Book Button ---
// //                     // SizedBox(
// //                     //   width: double.infinity,
// //                     //   child: ElevatedButton(
// //                     //     onPressed: state.selectedTime == null
// //                     //         ? null
// //                     //         : () => context.read<AppointmentCubit>().book(
// //                     //             "example_id",
// //                     //           ),
// //                     //     child: const Text("Book Now"),
// //                     //   ),
// //                     // ),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       child: Button1(
// //                         onPressed: () {
// //                           if (state.selectedTime != null) {
// //                             context.read<AppointmentCubit>().book("example_id");
// //                           }
// //                         },
// //                         text: "Book Now",
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             }
// //             return const SizedBox();
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _DateList extends StatelessWidget {
// //   final AppointmentSlotsLoaded state;
// //   const _DateList({required this.state});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 90,
// //       child: ListView.builder(
// //         scrollDirection: Axis.horizontal,
// //         itemCount: state.days.length,
// //         itemBuilder: (context, index) {
// //           DateTime day = state.days[index];
// //           bool isSelected = state.selectedDate.day == day.day;

// //           return GestureDetector(
// //             onTap: () => context.read<AppointmentCubit>().selectDate(day),
// //             child: Container(
// //               width: 60,
// //               margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
// //               decoration: BoxDecoration(
// //                 color: isSelected ? Colors.blue : Colors.grey[200],
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: isSelected
// //                     ? [
// //                         BoxShadow(
// //                           color: Colors.blue.withOpacity(0.3),
// //                           blurRadius: 5,
// //                         ),
// //                       ]
// //                     : null,
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     "${day.day}",
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: isSelected ? Colors.white : Colors.black,
// //                     ),
// //                   ),
// //                   Text(
// //                     _getWeekdayName(day.weekday),
// //                     style: TextStyle(
// //                       color: isSelected ? Colors.white70 : Colors.grey[600],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   String _getWeekdayName(int weekday) {
// //     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
// //     return days[weekday - 1];
// //   }
// // }

// // class _TimeGrid extends StatelessWidget {
// //   final AppointmentSlotsLoaded state;
// //   const _TimeGrid({required this.state});

// //   @override
// //   Widget build(BuildContext context) {
// //     if (state.availableSlots.isEmpty) {
// //       return const Center(child: Text("No slots available for this date."));
// //     }

// //     return Wrap(
// //       spacing: 12,
// //       runSpacing: 12,
// //       children: state.availableSlots.map((time) {
// //         bool isSelected = state.selectedTime == time;
// //         return GestureDetector(
// //           onTap: () => context.read<AppointmentCubit>().selectTime(time),
// //           child: Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //             decoration: BoxDecoration(
// //               color: isSelected
// //                   ? AppColors.blue
// //                   : AppColors.blue.withOpacity(0.1),
// //               // border: Border.all(
// //               //   //color: isSelected ? Colors.blue : Colors.grey[300]!,
// //               // ),
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Text(
// //               time,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: isSelected ? Colors.white : AppColors.blue,
// //               ),
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// //import 'appointment_cubit.dart'
// // hide
// //     AppointmentError,
// //     AppointmentBookingSuccess,
// //     AppointmentState,
// //     AppointmentLoading,
// //     AppointmentSlotsLoaded,
// //     AppointmentInitial;

// class AppointmentPage extends StatelessWidget {
//   const AppointmentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Book Appointment"), centerTitle: true),
//       body: BlocConsumer<AppointmentCubit, AppointmentState>(
//         listener: (context, state) {
//           if (state is AppointmentBookingSuccess) {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.success,
//               title: 'Confirmed!',
//               desc: 'Your appointment has been successfully booked.',
//               btnOkOnPress: () {},
//             ).show();
//           }
//           if (state is AppointmentError) {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.error,
//               title: 'Booking Failed',
//               desc: 'Booking failed. Please try again later.',
//               btnOkOnPress: () {
//                 Navigator.pushReplacement(
//                   context,
//                   CupertinoPageRoute(builder: (context) => AppointmentPage()),
//                 );
//               },
//             ).show();
//           }
//         },
//         builder: (context, state) {
//           if (state is AppointmentLoading)
//             return const Center(child: CircularProgressIndicator());
//           if (state is AppointmentError) {
//             context.read<AppointmentCubit>().initialize();
//           }
//           if (state is AppointmentSlotsLoaded) {
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Select Date",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   _DateList(state: state),
//                   const SizedBox(height: 30),
//                   const Text(
//                     "Select Time",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   _TimeGrid(state: state),
//                   const Spacer(),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }

// class _DateList extends StatelessWidget {
//   final AppointmentSlotsLoaded state;
//   const _DateList({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: state.days.length,
//         itemBuilder: (context, index) {
//           DateTime day = state.days[index];
//           bool isSelected = state.selectedDate.day == day.day;
//           return GestureDetector(
//             onTap: () => context.read<AppointmentCubit>().selectDate(day),
//             child: Container(
//               width: 60,
//               margin: const EdgeInsets.only(right: 12),
//               decoration: BoxDecoration(
//                 color: isSelected ? AppColors.blue : Colors.grey[100],
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: isSelected ? Colors.blue : Colors.transparent,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${day.day}",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isSelected ? Colors.white : AppColors.black,
//                     ),
//                   ),
//                   Text(
//                     [
//                       "Sun",
//                       "Mon",
//                       "Tue",
//                       "Wed",
//                       "Thu",
//                       "Fri",
//                       "Sat",
//                     ][day.weekday % 7],
//                     style: TextStyle(
//                       color: isSelected ? Colors.white70 : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _TimeGrid extends StatelessWidget {
//   final AppointmentSlotsLoaded state;
//   const _TimeGrid({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     if (state.availableSlots.isEmpty)
//       return const Text("No available slots for this day.");

//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: state.availableSlots.map((time) {
//         bool isSelected = state.selectedTime == time;
//         return GestureDetector(
//           onTap: () => context.read<AppointmentCubit>().selectTime(time),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? AppColors.blue
//                   : AppColors.blue.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               // border: Border.all(
//               //   color: isSelected ? Colors.blue : Colors.grey[300]!,
//               // ),
//             ),
//             child: Text(
//               time,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : AppColors.blue,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

// appointment.dart
import 'package:appwithfirebase/appointment_cubit.dart';
import 'package:appwithfirebase/appointment_state.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      // FIX: listener handles side-effects only; never mutates state inside builder.
      listener: (context, state) {
        if (state is AppointmentError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            desc: state.message,
            btnOkOnPress: () => context.read<AppointmentCubit>().initialize(),
          ).show();
        }
      },
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentSlotsLoaded) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _DateList(state: state),
                const SizedBox(height: 28),
                const Text(
                  'Select Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(child: _TimeGrid(state: state)),
              ],
            ),
          );
        }

        // AppointmentInitial or AppointmentError (shown via dialog above)
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// ─── Date List ───────────────────────────────────────────────────────────────

class _DateList extends StatelessWidget {
  final AppointmentSlotsLoaded state;
  const _DateList({required this.state});

  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.days.length,
        itemBuilder: (context, index) {
          final day = state.days[index];
          final isSelected = _isSameDay(state.selectedDate, day);

          return GestureDetector(
            onTap: () => context.read<AppointmentCubit>().selectDate(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.blue : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.black,
                    ),
                  ),
                  Text(
                    _weekdays[day.weekday % 7],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ─── Time Grid ───────────────────────────────────────────────────────────────

class _TimeGrid extends StatelessWidget {
  final AppointmentSlotsLoaded state;
  const _TimeGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.availableSlots.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'No available slots for this day.',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: state.availableSlots.map((time) {
          final isSelected = state.selectedTime == time;
          return GestureDetector(
            onTap: () => context.read<AppointmentCubit>().selectTime(time),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.blue
                    : AppColors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.blue
                      : AppColors.blue.withOpacity(0.2),
                ),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.blue,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
