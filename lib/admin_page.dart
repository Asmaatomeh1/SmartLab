import 'package:appwithfirebase/result/add_result_page.dart';
import 'package:appwithfirebase/authentication/auth.dart';
import 'package:appwithfirebase/shared_widget/button1.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
      Center(child: Text("Home")),
      // PrepPage(),
      Container(
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Text("Search"),
            TextButton(
              onPressed: () {
                AppAuth().signOut();
              },
              child: Text("logout"),
            ),
          ],
        ),
      ),
      // _BuildAddPageStart(),
      AddResultPage(),
      Center(child: Text("Results")),
      Center(child: Text("Profile")),
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
  //   Widget _BuildAddPageStart() {
  //     return Scaffold(
  //       body: Center(
  //         child: SizedBox(
  //           width: 300,
  //           height: 50,

  //           child: Button1(
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const MultiStepFormScreen(),
  //                 ),
  //               );
  //             },
  //             text: 'Start a New Appointment',
  //           ),
  //         ),
  //       ),
  //     );
  //   }
}
