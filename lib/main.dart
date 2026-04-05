// import 'package:appwithfirebase/Auth.dart';
// import 'package:appwithfirebase/admin_page.dart';
// import 'package:appwithfirebase/apppintment.dart';
// import 'package:appwithfirebase/home.dart';
// import 'package:appwithfirebase/login.dart';
// import 'package:appwithfirebase/signup.dart';
// import 'package:appwithfirebase/start_screen.dart';
// import 'package:appwithfirebase/user_page.dart';
// import 'package:appwithfirebase/verify.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   //FirebaseAuth.instance.signOut();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,

//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               if (snapshot.data!.emailVerified) {
//                 await AppAuth().refreshCurrentUser();
//                 if (FirebaseAuth.instance.currentUser?. == 'admin_uid') {
//                   return  AdminPage();
//                 } else {
//                   return  UserPage();
//                 }
//               } else {
//                 return const StartScreen();
//               }
//             }

//             return StartScreen();
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:appwithfirebase/appointment.dart';
import 'package:appwithfirebase/auth.dart';
import 'package:appwithfirebase/admin_page.dart';
import 'package:appwithfirebase/routes.dart';
import 'package:appwithfirebase/start_screen.dart';
import 'package:appwithfirebase/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Rive for Web (This initializes 'makeFlutterFactory')
  //await RiveFile.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          routes: {
            //Routes.home: (context) => const HomePage(),
            Routes.appointment: (context) => const AppointmentPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            // error: Colors.white,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch().copyWith(error: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          home: const AuthWrapper(), // We use a wrapper to handle the logic
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If Firebase is still checking the connection
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If a user is logged in
        if (snapshot.hasData) {
          User user = snapshot.data!;

          // Check for verification
          if (user.emailVerified) {
            // We use a FutureBuilder here because refreshCurrentUser() is async
            return FutureBuilder(
              future: AppAuth().refreshCurrentUser(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                // Redirect based on the role fetched from Firestore
                if (AppAuth.currentUser?.role == 'admin') {
                  return AdminPage();
                } else {
                  return const UserPage();
                }
              },
            );
          } else {
            // If logged in but not verified, go to Start or a Verify screen
            return const StartScreen();
          }
        }

        // Not logged in
        return const StartScreen();
      },
    );
  }
}
