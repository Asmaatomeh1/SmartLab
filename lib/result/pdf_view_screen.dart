//
import 'package:appwithfirebase/core/theme/app_theme.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UserViewPage extends StatelessWidget {
  final String appointmentId;

  const UserViewPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(title: Text("View PDF")),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("results")
              .where("appointmentId", isEqualTo: appointmentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No PDF found for this Appointment ID"),
              );
            }

            final doc = snapshot.data!.docs.first;
            final pdfUrl = doc.get('resultUrl') as String;
            print("PDF URL: $pdfUrl"); // تأكد من جلب الرابط بشكل صحيح

            return SfPdfViewer.network(
              pdfUrl,
              key: const ValueKey("pdfViewer"),
              // onHyperlinkClicked: (details) {
              //   print("Hyperlink clicked: ${details.uri}");
              // },
              otherSearchTextHighlightColor: Colors.black,
              currentSearchTextHighlightColor: Colors.black12,
            );
          },
        ),
      ),
    );
  }
}
