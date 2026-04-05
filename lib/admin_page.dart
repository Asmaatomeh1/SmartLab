import 'package:appwithfirebase/auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});
  final user = AppAuth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: Center(
        child: Text(
          "Welcome to the Admin Panel! ${user?.toString() ?? 'No user data'}",
        ),
      ),
    );
  }
}
