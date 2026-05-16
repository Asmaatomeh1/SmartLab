// import 'package:appwithfirebase/add_result_cubit.dart';

// import 'package:appwithfirebase/appointment_model.dart';
// import 'package:flutter/material.dart';

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// // Entry point — provides the cubit
// // ─────────────────────────────────────────────────────────────────────────────

// class AddResultProvider extends StatelessWidget {
//   final String appointmentId;
//   const AddResultProvider({super.key, required this.appointmentId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           AddResultCubit(),
//       child: const AddResultPage(),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Page
// // ─────────────────────────────────────────────────────────────────────────────

// class AddResultPage extends StatefulWidget {
//   const AddResultPage({super.key});

//   @override
//   State<AddResultPage> createState() => _AddResultPageState();
// }

// class _AddResultPageState extends State<AddResultPage> {
//   final _notesCtrl = TextEditingController();

//   // ── Theme ─────────────────────────────────────────────────────────────────
//   static const Color _primary = Color(0xFF1A73C1);
//   static const Color _teal = Color(0xFF0D9488);
//   static const Color _surface = Color(0xFFF8F9FB);
//   static const Color _cardBg = Colors.white;
//   static const Color _border = Color(0xFFE5E7EB);
//   static const Color _textMain = Color(0xFF111827);
//   static const Color _textSub = Color(0xFF6B7280);
//   static const Color _success = Color(0xFF0F6E56);
//   static const Color _error = Color(0xFFDC2626);
//   static const Color _amber = Color(0xFF854F0B);

//   @override
//   void dispose() {
//     _notesCtrl.dispose();
//     super.dispose();
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // Build
//   // ─────────────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddResultCubit, AddResultState>(
//       listener: (context, state) {
//         if (state is AddResultSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: const Row(children: [
//                 Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
//                 SizedBox(width: 8),
//                 Text('Results submitted successfully'),
//               ]),
//               backgroundColor: _success,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           );
//           Navigator.pop(context, true);
//         }

//         if (state is AddResultError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: _error,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         // ── Loading ──────────────────────────────────────────────────────────
//         if (state is AddResultLoading || state is AddResultInitial) {
//           return Scaffold(
//             backgroundColor: _surface,
//             appBar: _appBar(context, null, false),
//             body: const Center(child: CircularProgressIndicator(color: _primary)),
//           );
//         }

//         // ── Extract data from any loaded state ───────────────────────────────
//         final data = _getData(state);
//         if (data == null) {
//           return Scaffold(
//             backgroundColor: _surface,
//             appBar: _appBar(context, null, false),
//             body: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.error_outline, size: 52, color: Color(0xFFDC2626)),
//                   const SizedBox(height: 12),
//                   Text(
//                     state is AddResultError ? state.message : 'Something went wrong',
//                     style: const TextStyle(color: _textSub, fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//        // final isSubmitting = state is AddResultSubmitting;
//        // final uploadingTestId =
//            // state is AddResultUploading ? state.uploadingTestId : null;

//         return Scaffold(
//           backgroundColor: _surface,
//           appBar: _appBar(context, data, false /*isSubmitting*/),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildAppointmentCard(data.appointment),
//                 const SizedBox(height: 16),
//                 _buildProgressBanner(data),
//                 const SizedBox(height: 16),
//                // _buildTestsList(context, data, uploadingTestId),
//                 const SizedBox(height: 16),
//                 _buildNotesCard(context),
//                 const SizedBox(height: 28),
//                 _buildSubmitButton(context, data, false /*isSubmitting*/),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ── Helper: extract AddResultLoaded from any state ────────────────────────

//   AddResultLoaded? _getData(AddResultState state) {
//     if (state is AddResultLoaded) return state;
//    // if (state is AddResultUploading) return state.data;
//    // if (state is AddResultSubmitting) return state.data;
//     if (state is AddResultError) return state.data;
//     return null;
//   }

//   // ── AppBar ────────────────────────────────────────────────────────────────

//   AppBar _appBar(BuildContext context, AddResultLoaded? data, bool isSubmitting) {
//     return AppBar(
//       backgroundColor: _primary,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//         onPressed: isSubmitting ? null : () => Navigator.maybePop(context),
//       ),
//       title: const Text(
//         'Add Test Results',
//         style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
//       ),
//       actions: [
//         if (data != null)
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Center(
//               // child: Text(
//               //   '${data.uploadedCount}/${data.appointment.selectedTests.length} uploaded',
//               //   style: TextStyle(
//               //     color: Colors.white.withOpacity(0.85),
//               //     fontSize: 13,
//               //   ),
//               // ),
//             ),
//           ),
//       ],
//     );
//   }

//   // ── Appointment info card ─────────────────────────────────────────────────

//   Widget _buildAppointmentCard(AppointmentModel appt) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _cardBg,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _border, width: 0.8),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40, height: 40,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE6F1FB),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.assignment_outlined, color: _primary, size: 20),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Appointment ID',
//                       style: TextStyle(fontSize: 11, color: _textSub),
//                     ),
//                     Text(
//                       appt.appointmentId,
//                       style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _textMain),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               _statusBadge(appt.status),
//             ],
//           ),
//           const SizedBox(height: 14),
//           const Divider(height: 1, color: _border),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               _infoChip(Icons.calendar_today_outlined, appt.date),
//               const SizedBox(width: 12),
//               _infoChip(Icons.access_time_outlined, appt.time),
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE1F5EE),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 // child: Text(
//                 //   'Total: \$${appt.totalPrice.toStringAsFixed(0)}',
//                 //   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _success),
//                 // ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoChip(IconData icon, String label) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 14, color: _textSub),
//         const SizedBox(width: 4),
//         Text(label, style: const TextStyle(fontSize: 13, color: _textSub)),
//       ],
//     );
//   }

//   Widget _statusBadge(String status) {
//     Color bg, fg;
//     switch (status) {
//       case 'completed':
//         bg = const Color(0xFFEAF3DE); fg = _success;
//       case 'cancelled':
//         bg = const Color(0xFFFCEBEB); fg = _error;
//       default:
//         bg = const Color(0xFFFAEEDA); fg = _amber;
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
//       child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
//     );
//   }

//   // ── Progress banner ───────────────────────────────────────────────────────

//   Widget _buildProgressBanner(AddResultLoaded data) {
//     // final total = data.appointment.selectedTests.length;
//     // final uploaded = data.uploadedCount;
//     // final picked = data.pickedCount;
//    // final progress = total == 0 ? 0.0 : uploaded / total;

//     return Container(
//       decoration: BoxDecoration(
//         color: _cardBg,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _border, width: 0.8),
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Upload progress', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _textMain)),
//              // Text('$uploaded / $total files', style: const TextStyle(fontSize: 13, color: _textSub)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(99),
//             child: LinearProgressIndicator(
//               value:10 ,//progress,
//               minHeight: 6,
//               backgroundColor: const Color(0xFFE5E7EB),
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 10 == 10 ? _success : _primary,
//               ),
//             ),
//           ),
//           // if (picked > uploaded) ...[
//           //   const SizedBox(height: 6),
//           //   Text(
//           //     '$picked file(s) selected — tap "Upload" to upload them',
//           //     style: const TextStyle(fontSize: 11, color: _textSub),
//           //   ),
//           // ],
//         ],
//       ),
//     );
//   }

//   // ── Tests list ────────────────────────────────────────────────────────────

//   Widget _buildTestsList(
//     BuildContext context,
//     AddResultLoaded data,
//     String? uploadingTestId,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _cardBg,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _border, width: 0.8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
//             // child: Text(
//             //   'TESTS (${data.appointment.selectedTests.length})',
//             //   style: const TextStyle(
//             //     fontSize: 10, fontWeight: FontWeight.w600,
//             //     color: _textSub, letterSpacing: 0.8,
//             //   ),
//             // ),
//           ),
//           // ...data.appointment.selectedTests.asMap().entries.map((entry) {
//           //   final i = entry.key;
//           //   final test = entry.value;
//           //   final isLast = i == data.appointment.selectedTests.length - 1;

//             // return Column(
//             //   children: [
//             //     if (i > 0) const Divider(height: 1, color: _border),
//             //     _buildTestTile(
//             //       context: context,
//             //       test: test,
//             //       data: data,
//             //       isUploading: uploadingTestId == test.testId,
//             //       isLast: isLast,
//             //     ),
//             //   ],
//             // );
//           //}),
//         ],
//       ),
//     );
//   }

//   // Widget _buildTestTile({
//   //   required BuildContext context,
//   //   required SelectedTest test,
//   //   required AddResultLoaded data,
//   //   required bool isUploading,
//   //   required bool isLast,
//   // }) {
//   //   final cubit = context.read<AddResultCubit>();
//   //   final localPath = data.localFilePaths[test.testId];
//   //   final uploadedUrl = data.uploadedUrls[test.testId];
//   //   final isUploaded = uploadedUrl != null;

//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             // Test icon
//   //             Container(
//   //               width: 38, height: 38,
//   //               decoration: BoxDecoration(
//   //                 color: isUploaded
//   //                     ? const Color(0xFFEAF3DE)
//   //                     : const Color(0xFFF3F4F6),
//   //                 borderRadius: BorderRadius.circular(10),
//   //               ),
//   //               child: Icon(
//   //                 isUploaded
//   //                     ? Icons.check_circle_outline
//   //                     : Icons.science_outlined,
//   //                 color: isUploaded ? _success : _textSub,
//   //                 size: 19,
//   //               ),
//   //             ),
//   //             const SizedBox(width: 12),
//   //             // Test name + ID
//   //             Expanded(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(test.testName,
//   //                       style: const TextStyle(
//   //                           fontSize: 14, fontWeight: FontWeight.w600, color: _textMain)),
//   //                   Text(test.testId,
//   //                       style: const TextStyle(fontSize: 11, color: _textSub)),
//   //                 ],
//   //               ),
//   //             ),
//   //             // Price
//   //             Text(
//   //               '\$${test.priceAtBooking.toStringAsFixed(0)}',
//   //               style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _textSub),
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(height: 10),

//   //         // File state row
//   //         if (isUploaded)
//   //           // ── Uploaded ────────────────────────────────────────────────
//   //           Row(
//   //             children: [
//   //               const Icon(Icons.link, size: 14, color: _success),
//   //               const SizedBox(width: 4),
//   //               Expanded(
//   //                 child: Text(
//   //                   'Uploaded successfully',
//   //                   style: const TextStyle(fontSize: 12, color: _success),
//   //                   overflow: TextOverflow.ellipsis,
//   //                 ),
//   //               ),
//   //               GestureDetector(
//   //                 onTap: () => cubit.clearFile(test.testId),
//   //                 child: const Icon(Icons.close, size: 16, color: _textSub),
//   //               ),
//   //             ],
//   //           )
//   //         else if (isUploading)
//   //           // ── Uploading ────────────────────────────────────────────────
//   //           Row(
//   //             children: [
//   //               const SizedBox(
//   //                 width: 14, height: 14,
//   //                 child: CircularProgressIndicator(strokeWidth: 2, color: _primary),
//   //               ),
//   //               const SizedBox(width: 8),
//   //               const Text('Uploading...', style: TextStyle(fontSize: 12, color: _primary)),
//   //             ],
//   //           )
//   //         else if (localPath != null)
//   //           // ── File picked, not uploaded yet ────────────────────────────
//   //           Row(
//   //             children: [
//   //               const Icon(Icons.attach_file, size: 14, color: _textSub),
//   //               const SizedBox(width: 4),
//   //               Expanded(
//   //                 child: Text(
//   //                   localPath.split('/').last,
//   //                   style: const TextStyle(fontSize: 12, color: _textSub),
//   //                   overflow: TextOverflow.ellipsis,
//   //                 ),
//   //               ),
//   //               GestureDetector(
//   //                 onTap: () => cubit.clearFile(test.testId),
//   //                 child: const Icon(Icons.close, size: 16, color: _textSub),
//   //               ),
//   //             ],
//   //           )
//   //         else
//   //           // ── No file yet ──────────────────────────────────────────────
//   //           const Row(
//   //             children: [
//   //               Icon(Icons.upload_file_outlined, size: 14, color: _textSub),
//   //               SizedBox(width: 4),
//   //               Text('No file selected', style: TextStyle(fontSize: 12, color: _textSub)),
//   //             ],
//   //           ),

//   //         const SizedBox(height: 10),

//   //         // Action buttons
//   //         Row(
//   //           children: [
//   //             // Pick file
//   //             Expanded(
//   //               child: OutlinedButton.icon(
//   //                 onPressed: isUploading
//   //                     ? null
//   //                     : () => _pickFile(context, test.testId),
//   //                 icon: const Icon(Icons.folder_open_outlined, size: 15),
//   //                 label: Text(localPath != null ? 'Change file' : 'Choose file'),
//   //                 style: OutlinedButton.styleFrom(
//   //                   foregroundColor: _primary,
//   //                   side: const BorderSide(color: _primary, width: 0.8),
//   //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   //                   padding: const EdgeInsets.symmetric(vertical: 9),
//   //                   textStyle: const TextStyle(fontSize: 13),
//   //                 ),
//   //               ),
//   //             ),
//   //             const SizedBox(width: 8),
//   //             // Upload button
//   //             Expanded(
//   //               child: ElevatedButton.icon(
//   //                 onPressed: (localPath == null || isUploading || isUploaded)
//   //                     ? null
//   //                     : () => cubit.uploadFile(test.testId),
//   //                 icon: isUploaded
//   //                     ? const Icon(Icons.check, size: 15)
//   //                     : const Icon(Icons.cloud_upload_outlined, size: 15),
//   //                 label: Text(isUploaded ? 'Uploaded' : 'Upload'),
//   //                 style: ElevatedButton.styleFrom(
//   //                   backgroundColor: isUploaded ? _success : _primary,
//   //                   disabledBackgroundColor: const Color(0xFFE5E7EB),
//   //                   foregroundColor: Colors.white,
//   //                   elevation: 0,
//   //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   //                   padding: const EdgeInsets.symmetric(vertical: 9),
//   //                   textStyle: const TextStyle(fontSize: 13),
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // ── Notes card ────────────────────────────────────────────────────────────

//   Widget _buildNotesCard(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _cardBg,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _border, width: 0.8),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'ADMIN NOTES (OPTIONAL)',
//             style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _textSub, letterSpacing: 0.8),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _notesCtrl,
//             maxLines: 3,
//             onChanged: context.read<AddResultCubit>().updateNotes,
//             decoration: InputDecoration(
//               hintText: 'Add any notes for the patient...',
//               hintStyle: const TextStyle(fontSize: 13, color: _textSub),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: _border),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: _primary),
//               ),
//               contentPadding: const EdgeInsets.all(12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Submit button ─────────────────────────────────────────────────────────

//   Widget _buildSubmitButton(
//     BuildContext context,
//     AddResultLoaded data,
//     bool isSubmitting,
//   ) {
//    // final canSubmit = data.allUploaded && !isSubmitting;

//     return Column(
//       children: [
//        //if (!data.allUploaded && data.pickedCount > 0) ...[
//           // SizedBox(
//           //   width: double.infinity,
//           //   height: 48,
//           //   child: OutlinedButton.icon(
//           //     onPressed: isSubmitting
//           //         // ? null
//           //         // :() => context.read<AddResultCubit>().uploadAllFiles(),
//           //     icon: const Icon(Icons.cloud_upload_outlined, size: 17),
//           //     label: const Text('Upload all files'),
//           //     style: OutlinedButton.styleFrom(
//           //       foregroundColor: _primary,
//           //       side: const BorderSide(color: _primary),
//           //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           //       textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//           //     ),
//           //   ),
//           // ),
//           const SizedBox(height: 10),
//        // ],
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               if()
//               context.read<AddResultCubit>().state.();
//               context.read<AddResultCubit>().submitResult();
//             },
//             icon: isSubmitting
//                 ? const SizedBox(
//                     width: 18, height: 18,
//                     child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                   )
//                 : const Icon(Icons.send_outlined, size: 18),
//             label: Text(isSubmitting ? 'Submitting...' : 'Submit Results'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _teal,
//               disabledBackgroundColor: const Color(0xFFE5E7EB),
//               disabledForegroundColor: _textSub,
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//         // if (!data.allUploaded) ...[
//         //   const SizedBox(height: 8),
//         //   Text(
//         //     'Upload all ${data.appointment.selectedTests.length} files to enable submit',
//         //     style: const TextStyle(fontSize: 12, color: _textSub),
//         //     textAlign: TextAlign.center,
//         //   ),
//         // ],
//       ],
//     );
//   }

//   // ── File picker ───────────────────────────────────────────────────────────

//   // Future<void> _pickFile(BuildContext context, String testId) async {
//   //   final result = await FilePicker.pickFiles(
//   //     type: FileType.custom,
//   //     allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//   //     allowMultiple: false,
//   //   );

//   //   if (result != null && result.files.single.path != null && context.mounted) {
//   //     context.read<AddResultCubit>().setLocalFile(testId, result.files.single.path!);
//   //   }
//   // }
// }

import 'package:appwithfirebase/features/result/add_result_cubit.dart';
import 'package:appwithfirebase/features/result/add_result_state.dart';
import 'package:appwithfirebase/shared_widget/my_text_form_field.dart';
import 'package:appwithfirebase/model/result_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class AddResultPage extends StatelessWidget {
//   AddResultPage({super.key});
//   final TextEditingController _notesController = TextEditingController();
//   //TextEditingController();
//   final TextEditingController _urlController = TextEditingController();
//   final TextEditingController _appointmentIdController = TextEditingController(
//     text: '1G59cpCqAKpaMfZKfUPu',
//   );

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddResultCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Add Result')),
//         body: BlocConsumer<AddResultCubit, AddResultState>(
//           listener: (context, state) {
//             if (state is AddResultSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Appointment loaded successfully'),
//                 ),
//               );
//             } else if (state is AddResultError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Failed to load appointment: ${state.message}'),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               children: [
//                 // Add your form fields here
//                 MyTextFormField(
//                   labelText: ' Appointment ID',
//                   controller: _appointmentIdController,
//                 ),

//                 MyTextFormField(
//                   labelText: ' Result URL',
//                   controller: _urlController,
//                 ),

//                 MyTextFormField(
//                   labelText: 'Result Notes',
//                   controller: _notesController,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<AddResultCubit>().loadAppointment(
//                       _appointmentIdController.text,
//                       _notesController.text,
//                       _urlController.text,
//                     );
//                   },
//                   child: const Text('get appointment'),
//                 ),
//                 if (state is AddResultLoaded)
//                   Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Appointment ID: ${state.result.appointmentId}'),
//                         Text('Result URL: ${state.result.resultUrl}'),
//                       ],
//                     ),
//                   ),

//                 ElevatedButton(
//                   onPressed: () {
//                     if (state is AddResultLoaded) {
//                       final id = context
//                           .read<AddResultCubit>()
//                           .currentResult
//                           ?.resultId;

//                       context.read<AddResultCubit>().submitResult(id!);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('No appointment loaded')),
//                       );
//                     }
//                   },
//                   child: const Text('submit'),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class AddResultPage extends StatelessWidget {
//   AddResultPage({super.key});

//   final _appointmentIdController = TextEditingController(
//     text: '1G59cpCqAKpaMfZKfUPu',
//   );
//   final _urlController = TextEditingController();
//   final _notesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddResultCubit(),
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF8F9FB),
//         appBar: AppBar(
//           title: const Text(
//             'Submit Test Results',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//         body: BlocConsumer<AddResultCubit, AddResultState>(
//           listener: (context, state) {
//             if (state is AddResultSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Result successfully linked!'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             }
//             if (state is AddResultError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   _buildInputCard(context, state is AddResultLoading),
//                   const SizedBox(height: 20),
//                   if (state is AddResultLoaded) _buildPreviewCard(state.result),
//                   const SizedBox(height: 30),
//                   _buildSubmitButton(context, state),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildInputCard(BuildContext context, bool isLoading) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
//         ],
//       ),
//       child: Column(
//         children: [
//           MyTextFormField(
//             labelText: 'Appointment ID',
//             controller: _appointmentIdController,
//           ),
//           const SizedBox(height: 12),
//           MyTextFormField(
//             labelText: 'Document URL (PDF/Image)',
//             controller: _urlController,
//           ),
//           const SizedBox(height: 12),
//           MyTextFormField(
//             labelText: 'Clinical Notes',
//             controller: _notesController,
//             maxLines: 3,
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: isLoading
//                   ? null
//                   : () => context.read<AddResultCubit>().loadAppointment(
//                       _appointmentIdController.text,
//                       _notesController.text,
//                       _urlController.text,
//                     ),
//               icon: const Icon(Icons.search),
//               label: const Text('Verify Appointment'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPreviewCard(ResultModel result) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE0F2F1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFF80CBC4)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.teal),
//               SizedBox(width: 8),
//               Text(
//                 'Data Verified',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Ready to link file to ID: ${result.appointmentId}',
//             style: const TextStyle(fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context, AddResultState state) {
//     final bool isReady = state is AddResultLoaded;
//     final bool isLoading = state is AddResultLoading;

//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF1A73C1),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           disabledBackgroundColor: Colors.grey.shade300,
//         ),
//         onPressed: (isReady && !isLoading)
//             ? () => context.read<AddResultCubit>().submitResult()
//             : null,
//         child: isLoading
//             ? const CircularProgressIndicator(color: Colors.white)
//             : const Text(
//                 'Confirm & Save Result',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//       ),
//     );
//   }
// }

// import 'package:appwithfirebase/add_result_cubit.dart';
// import 'package:appwithfirebase/add_result_state.dart';
// import 'package:appwithfirebase/my_text_form_field.dart'; // Ensure this matches your file name
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class AddResultPage extends StatelessWidget {
  AddResultPage({super.key});

  // Controllers are kept outside build to prevent reset on rebuild
  final _appointmentIdController = TextEditingController(
    text: 'sUVf4ZCigsaKu7WwebG2',
  );
  final _urlController = TextEditingController(
    text:
        'https://www.nxp.com/testreports/360000008865_AU_PLATING_ZHM_F_ROHS.pdf',
  );
  final _notesController = TextEditingController();

  // Theme Constants
  static const Color _primaryBlue = Color(0xFF1A73C1);
  static const Color _bgGrey = Color(0xFFF8F9FB);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddResultCubit(),
      child: Scaffold(
        backgroundColor: _bgGrey,
        appBar: AppBar(
          title: const Text(
            'Laboratory Result Entry',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: BlocConsumer<AddResultCubit, AddResultState>(
          listener: (context, state) => _handleStateChanges(context, state),
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 20),
                  _buildFormCard(context, state is AddResultLoading),
                  const SizedBox(height: 20),

                  // Conditional Preview Section
                  if (state is AddResultLoaded) ...[
                    _buildVerificationCard(state.result.appointmentId),
                    const SizedBox(height: 30),
                  ],

                  _buildSubmitButton(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Link Medical Records",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Enter the appointment details and the result document URL.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          MyTextFormField(
            labelText: 'Appointment Reference ID',
            controller: _appointmentIdController,
            prefixIcon: const Icon(Icons.numbers, size: 20),
          ),
          const SizedBox(height: 16),
          MyTextFormField(
            labelText: 'Result URL (Cloud Storage)',
            controller: _urlController,
            prefixIcon: const Icon(Icons.link, size: 20),
          ),
          const SizedBox(height: 16),
          MyTextFormField(
            labelText: 'Clinical Notes',
            controller: _notesController,
            maxLines: 3,
            prefixIcon: const Icon(Icons.note_alt_outlined, size: 20),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: _primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<AddResultCubit>().loadAppointment(
                        _appointmentIdController.text,
                        _notesController.text,
                        _urlController.text,
                      );
                    },
              child: const Text('Verify Data Integrity'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard(String id) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Appointment #$id verified. Ready for submission.",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, AddResultState state) {
    final bool isReady = state is AddResultLoaded;
    final bool isLoading = state is AddResultLoading;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: (isReady && !isLoading)
            ? () => context.read<AddResultCubit>().submitResult()
            : null,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Submit to Database',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  // --- Logic & Dialog Handlers ---

  void _handleStateChanges(BuildContext context, AddResultState state) {
    if (state is AddResultSuccess) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Uploaded Successfully',
        desc: 'The medical result has been linked to the appointment.',
        btnOkOnPress: () => Navigator.pop(context),
      ).show();
    }

    if (state is AddResultAlreadyExists) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Overwrite Result?',
        desc:
            'An entry already exists for this appointment. Would you like to update the existing record?',
        btnCancelOnPress: () {
          // Revert state to loaded so the "Submit" button is still interactive
          context.read<AddResultCubit>().emit(
            AddResultLoaded(result: state.newResult),
          );
        },
        btnOkText: 'Yes, Replace',
        btnOkColor: Colors.orange,
        btnOkOnPress: () {
          context.read<AddResultCubit>().performSaveOrUpdate(
            state.newResult,
            state.existingDocId,
          );
        },
      ).show();
    }

    if (state is AddResultError) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Process Error',
        desc: state.message,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
