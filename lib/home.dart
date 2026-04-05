import 'package:appwithfirebase/test/custom_appbar.dart';
import 'package:appwithfirebase/test/home_grid.dart';
import 'package:appwithfirebase/test/image_slider.dart';
import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(child: Text('Welcome ${user?.email ?? 'Guest'}')),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Home")),
//       body: Center(child: Text("Welcome ${user?.email}")),
//     );
//   }
// }

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Home"),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => StartScreen()),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      // body: Center(child: Text("Welcome ${user?.email}")),
      body: SingleChildScrollView(
        child: Column(
          children: [customAppBar(), const ImageSlider(), HomeGrid()],
        ),
      ),
    );
  }
}
