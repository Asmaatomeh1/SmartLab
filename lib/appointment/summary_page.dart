// import 'package:appwithfirebase/appointment_cubit.dart';
// import 'package:appwithfirebase/test/test_cubit.dart';
// import 'package:appwithfirebase/test/test_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SummaryPage extends StatelessWidget {
//   const SummaryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 1. Get the selected tests from Page 1
//     final testState = context.watch<TestCubit>().state;
//     // 2. Get the selected date/time from Page 2
//     final apptState = context.watch<AppointmentCubit>().state;

//     if (testState is! TestLoaded || apptState is! AppointmentSlotsLoaded) {
//       return const Scaffold(body: Center(child: Text("Data missing...")));
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Confirm Appointment")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Your Selected Tests:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             ...testState.selectedTests.map(
//               (t) => Text("- ${t.name} (${t.price} ₪)"),
//             ),

//             const Divider(height: 40),

//             const Text(
//               "Appointment Details:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text("Date: ${apptState.selectedDate.toString().substring(0, 10)}"),
//             Text("Time: ${apptState.selectedTime}"),

//             const Divider(height: 40),

//             Text(
//               "Total Amount: ${context.read<TestCubit>().totalPrice} ₪",
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.blue,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const Spacer(),

//             // THE FINAL BOOKING BUTTON
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:appwithfirebase/appointment/appointment_cubit.dart';
import 'package:appwithfirebase/appointment/appointment_state.dart';
// Ensure your AppColors are imported
import 'package:appwithfirebase/test/test_cubit.dart';

import 'package:appwithfirebase/test_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final testState = context.watch<TestCubit>().state;
    final apptState = context.watch<AppointmentCubit>().state;

    if (testState is! TestLoaded || apptState is! AppointmentSlotsLoaded) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for contrast
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Review Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Please confirm your selection before booking",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 25),

            // --- DATE & TIME CARD ---
            _buildInfoCard(
              title: "Appointment Schedule",
              icon: Icons.calendar_month_rounded,
              child: Row(
                children: [
                  _buildDetailItem(
                    "Date",
                    apptState.selectedDate.toString().substring(0, 10),
                    Icons.event,
                  ),
                  const SizedBox(width: 40),
                  _buildDetailItem(
                    "Time",
                    apptState.selectedTime ?? "--:--",
                    Icons.access_time_filled,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- TESTS LIST CARD ---
            _buildInfoCard(
              title: "Selected Tests",
              icon: Icons.biotech_rounded,
              child: Column(
                children: [
                  ...testState.selectedTests.map(
                    (t) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "${t.price} ₪",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${context.read<TestCubit>().totalPrice} ₪",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Note: The "Book" button is handled by your MultiStepFormWidget's onSubmit,
            // but if you want a visual reminder here, you can add a "Total" summary bar.
          ],
        ),
      ),
    );
  }

  // Reusable card container
  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  // Small detail item for date/time
  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.black54),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
