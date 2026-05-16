// import 'dart:io';

// import 'package:appwithfirebase/my_text_form_field.dart';
// import 'package:appwithfirebase/result_cubit.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// //import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class SearchPage extends StatelessWidget {
//   SearchPage({super.key});
//   TextEditingController appointmentIdController = TextEditingController();
//   String url = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Search")),
//       body: BlocProvider(
//         create: (context) => ResultCubit(),
//         child: Column(
//           children: [
//             const Text("Search Page"),
//             MyTextFormField(
//               labelText: 'inter the appintmentId ',
//               controller: appointmentIdController,
//               keyboardType: TextInputType.numberWithOptions(),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 //Implement search functionality
//                 //final ImagePicker picker = ImagePicker();
//                 // Pick an image.
//                 //final XFile? image = await picker.pickImage(
//                 //  mediaType: MediaType.image,
//                 //);
//                 // Capture a photo.

//                 uploadResultPdf('L6umWJjMi6Jcc1AMfKBy');
//               },
//               child: const Text("upload"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> uploadResultPdf(String appointmentId) async {
//     // FilePickerResult? result = await FilePicker.platform.pickFiles(
//     //   type: FileType.any,
//     //   allowedExtensions: ['pdf'],
//     // );
//     // ImagePicker imagePicker = ImagePicker();
//     // XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
//     // if (image == null) return;

//     // File file = File(image.path);

//     // String fileName = DateTime.now().millisecondsSinceEpoch.toString();

//     // /// رفع إلى Storage
//     // Reference ref = FirebaseStorage.instance.ref().child(
//     //   "results/$fileName.pdf",
//     // );
//     FilePickerResult? result = await FilePicker.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'pdf', 'doc'],
//     );

//     if (result == null) return;

//     File file = File(result.files.single.path!);

//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();

//     /// رفع إلى Storage
//     // Reference ref = FirebaseStorage.instance.ref().child(
//     //   "results/$fileName.pdf",
//     // );

//     // await ref.putFile(file);

//     // /// جلب الرابط
//     // String url = await ref.getDownloadURL();

//     /// حفظ في Firestore
//     ///
//     print(file.uri);
//     url = file.uri.toString();
//     await FirebaseFirestore.instance.collection("results").add({
//       "appointmentId": appointmentId,
//       "userId": FirebaseAuth.instance.currentUser?.uid,
//       "pdfUrl": url,
//       "fileName": "Result.pdf",
//       "date": Timestamp.now(),
//     });
//   }
//   openFile(String url) async {
//     // فتح الملف باستخدام حزمة url_launcher
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:appwithfirebase/my_text_form_field.dart';
// // import 'package:appwithfirebase/result_cubit.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:http/http.dart' as http;

// // class SearchPage extends StatelessWidget {
// //   SearchPage({super.key});

// //   TextEditingController appointmentIdController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Search")),
// //       body: BlocProvider(
// //         create: (context) => ResultCubit(),
// //         child: Column(
// //           children: [
// //             const Text("Search Page"),

// //             MyTextFormField(
// //               labelText: 'enter the appointmentId',
// //               controller: appointmentIdController,
// //               keyboardType: const TextInputType.numberWithOptions(),
// //             ),

// //             ElevatedButton(
// //               onPressed: () async {
// //                 // uploadResultFile(
// //                 //   appointmentIdController.text,
// //                 // );
// //                 uploadResultFile('L6umWJjMi6Jcc1AMfKBy');
// //               },
// //               child: const Text("Upload File"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // رفع الملف إلى Cloudinary
// //   Future<String?> uploadToCloudinary(File file) async {
// //     var uri = Uri.parse(
// //       "https://api.cloudinary.com/v1_1/da9dmaieq/auto/upload",
// //     );

// //     var request = http.MultipartRequest('POST', uri);

// //     request.fields['upload_preset'] = 'asmaa_results';

// //     request.files.add(await http.MultipartFile.fromPath('file', file.path));

// //     var response = await request.send();

// //     if (response.statusCode == 200) {
// //       var res = await http.Response.fromStream(response);

// //       var data = jsonDecode(res.body);

// //       return data['secure_url']; // الرابط
// //     }

// //     return null;
// //   }

// //   // اختيار الملف + رفعه + تخزين الرابط
// //   Future<void> uploadResultFile(String appointmentId) async {
// //     FilePickerResult? result = await FilePicker.pickFiles(
// //       type: FileType.custom,
// //       allowedExtensions: ['jpg', 'pdf', 'doc'],
// //     );

// //     if (result == null) return;

// //     File file = File(result.files.single.path!);

// //     // رفع إلى Cloudinary
// //     String? url = await uploadToCloudinary(file);

// //     if (url == null) return;

// //     // حفظ الرابط في Firestore
// //     await FirebaseFirestore.instance.collection("results").add({
// //       "appointmentId": appointmentId,
// //       "userId": FirebaseAuth.instance.currentUser?.uid,
// //       "fileUrl": url,
// //       "fileName": result.files.single.name,
// //       "date": Timestamp.now(),
// //     });

// //     print("Upload success ✅");
// //   }
// // }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController appointmentController = TextEditingController();
  final _flutterMediaDownloaderPlugin = MediaDownload();

  void savePdfUrl() async {
    final url =
        'https://www.nxp.com/testreports/360000008865_AU_PLATING_ZHM_F_ROHS.pdf';

    final appointmentId = 'mgCoNj6dKNIVxVVA42YH';
    // appointmentController.text.trim();

    if (url.isEmpty || appointmentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both Appointment ID and URL")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection("results").add({
      "appointmentId": appointmentId,
      "pdfUrl": url,
      "date": DateTime.now(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("PDF URL saved successfully ✅")));

    urlController.clear();
    appointmentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Upload PDF URL")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: appointmentController,
              decoration: InputDecoration(
                labelText: "Appointment ID",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: "PDF URL",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: savePdfUrl, child: Text("Save PDF URL")),
            //Image.network('https://beige-kariotta-8.tiiny.site/IMG_0355.jpg'),
            SizedBox(
              height: 400,

              // child: SfPdfViewer.network(
              //   "https://drive.google.com/uc?export=download&id=1YtbG7_5Mi88BzL9sCQIqwKiB1hWIRIIL",
              //   key: Key("pdfViewer"),
              // ),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("logout"),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     _flutterMediaDownloaderPlugin.downloadMedia(
            //       context,
            //       'https://drive.google.com/uc?export=download&id=1YtbG7_5Mi88BzL9sCQIqwKiB1hWIRIIL',
            //     );
            //   },
            //   child: const Text('Media Download'),
            // ),
          ],
        ),
      ),
    );
  }
}
