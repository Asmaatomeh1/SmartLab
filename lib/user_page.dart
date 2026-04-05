import 'package:appwithfirebase/button1.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/home.dart';
import 'package:appwithfirebase/multi_step_form_screen.dart';
import 'package:appwithfirebase/result.dart';
import 'package:flutter/material.dart';

// class UserPage extends StatelessWidget {
//   UserPage({super.key});
//   final user = AppAuth.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Panel"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               AppAuth().signOut();
//             },
//           ),
//         ],
//       ),

//       body: Center(
//         child: Text(
//           "Welcome to the User Panel! ${user?.toString() ?? 'No user data'}",
//         ),
//       ),
//     );
//   }
// }

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class UserPage extends StatelessWidget {
//   final PersistentTabController _controller = PersistentTabController(
//     initialIndex: 0,
//   );

//   UserPage({super.key});

// final _formKey = GlobalKey<FormState>();
// final TextEditingController firstNameController = TextEditingController();
// final TextEditingController lastNameController = TextEditingController();
// final TextEditingController emailController = TextEditingController();

//   List<Widget> _buildScreens() {
//     return [
//       Center(child: Text("Home")),
//       Center(child: Text("Search")),
//       Center(child: Text("Add")),
//       Center(child: Text("Profile")),
//       Center(child: Text("Settings")),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           'assets/images/home-3.png',
//           width: 24,
//           height: 24,
//           color: Colors.blueAccent,
//           //scale: 0.1,
//         ),
//         inactiveIcon: Image.asset(
//           'assets/images/home-2.png',
//           width: 24,
//           height: 24,
//           color: Colors.grey,
//         ),
//         activeColorPrimary: AppColors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           'assets/images/search.png',
//           width: 24,
//           height: 24,
//           color: Colors.blueAccent,
//         ),
//         inactiveIcon: Image.asset(
//           'assets/images/search.png',
//           width: 24,
//           height: 24,
//           color: Colors.grey,
//         ),
//       ),
//       PersistentBottomNavBarItem(
//         iconSize: 45,
//         icon: Icon(Icons.add, color: Colors.white),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           'assets/images/user-2.png',
//           width: 24,
//           height: 24,
//           color: Colors.blueAccent,
//         ),
//         inactiveIcon: Image.asset(
//           'assets/images/user.png',
//           width: 24,
//           height: 24,
//           color: Colors.grey,
//         ),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           'assets/images/settings-2.png',
//           width: 24,
//           height: 24,
//           color: Colors.blueAccent,
//         ),
//         inactiveIcon: Image.asset(
//           'assets/images/settings.png',
//           width: 24,
//           height: 24,
//           color: Colors.grey,
//         ),
//       ),
//     ];
//   }

//   final form = MultiStepFormWidget(
//   // Required callback

//   onSubmit: () {
//     if (_formKey.currentState!.validate()) {
//       print('Form submitted successfully');
//     }
//   },

//   // Define form steps
//   steps: [
//     // Step 1
//     FormStep(
//       title: 'Personal Information',
//       fields: [
//         EasyTextFormField(
//           controller: firstNameController,
//           label: 'First Name',
//           validator: (value) => value!.isEmpty ? 'First name is required' : null,
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Last Name'),
//         ),
//       ],
//     ),

//     // Step 2
//     FormStep(
//       title: 'Contact Details',
//       fields: [
//         EasyTextFormField(
//           controller: emailController,
//           label: 'Email',
//           validator: (value) => value!.isEmpty ? 'Email is required' : null,
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Username'),
//         ),
//       ],
//     ),
//   ],

//   // Customizable button styles
//   nextButtonColor: const Color(0xFF2196F3),
//   prevButtonColor: const Color(0xFF424242),
//   submitButtonColor: const Color(0xFF4CAF50),
//   nextButtonTextColor: Colors.white,
//   prevButtonTextColor: Colors.white,
//   submitButtonTextColor: Colors.white,
//   stepIndicatorActiveColor: const Color(0xFF2196F3),
//   stepIndicatorDefaultColor: const Color(0xFF757575),
// );
// @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       navBarStyle: NavBarStyle.style15, // هنا الستايل
//     );
//   }

// }

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  // Define controllers here so they persist
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  //final _formKey = GlobalKey<FormState>();

  //  List<String> selectedIdTests = [];

  List<Widget> _buildScreens() {
    return [
      const Home(),

      const Center(child: Text("Search")),

      _BuildAddPageStart(),
      const ResultsScreen(),
      const Center(child: Text("Profile")),
    ];
  }

  ///const Color(0xFF2196F3),
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/home-3.png',
          width: 24,
          height: 24,
          color: Colors.blueAccent,
          //scale: 0.1,
        ),
        inactiveIcon: Image.asset(
          'assets/images/home-2.png',
          width: 24,
          height: 24,
          color: Colors.grey,
        ),
        activeColorPrimary: AppColors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/search.png',
          width: 24,
          height: 24,
          color: Colors.blueAccent,
        ),
        inactiveIcon: Image.asset(
          'assets/images/search.png',
          width: 24,
          height: 24,
          color: Colors.grey,
        ),
      ),
      PersistentBottomNavBarItem(
        iconSize: 45,
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/settings-2.png',
          width: 24,
          height: 24,
          color: Colors.blueAccent,
        ),
        inactiveIcon: Image.asset(
          'assets/images/settings.png',
          width: 24,
          height: 24,
          color: Colors.grey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/user-2.png',
          width: 24,
          height: 24,
          color: Colors.blueAccent,
        ),
        inactiveIcon: Image.asset(
          'assets/images/user.png',
          width: 24,
          height: 24,
          color: Colors.grey,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    //uploadMockTests();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true, // Keeps your form data if you switch tabs
          navBarStyle: NavBarStyle.style15,
          //  backgroundColor: Colors.white,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildAddPageStart() {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 50,

          child: Button1(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultiStepFormScreen(),
                ),
              );
            },
            text: 'Start a New Appointment',
          ),
        ),
      ),
    );
  }
}
