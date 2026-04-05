// import 'package:appwithfirebase/app_styles.dart';
import 'package:appwithfirebase/auth.dart';
import 'package:appwithfirebase/button1.dart';
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:appwithfirebase/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Smart",
                      style: AppFonts.titleBlue.copyWith(fontSize: 32.sp),
                      children: [
                        TextSpan(
                          text: "Lab",
                          style: AppFonts.title.copyWith(fontSize: 32.sp),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),
                  // SvgPicture.asset(
                  //   "assets/images/Img.svg",
                  //   semanticsLabel: "Lab Test",
                  //   height: 100,
                  //   width: 100,
                  // ),
                  SizedBox(height: 5.h),
                  Center(
                    child: Container(
                      height: 400,
                      width: 500,
                      decoration: const BoxDecoration(
                        //  color: const Color.fromARGB(222, 0, 0, 0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Img.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //  SizedBox(height: 24.h),
                  Text(
                    "Introducing All new Lab Test Facility",
                    style: AppFonts.subtitle.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Discover Accurate Diagnostics & Reliable ",
                    style: AppFonts.title.copyWith(fontSize: 35.sp),
                  ),
                  Text(
                    'Testing Services.',
                    style: AppFonts.titleBlue.copyWith(fontSize: 35.sp),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Button1(
                        onPressed: () {
                          AppAuth.role = 'admin';
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        text: "Admin Panel ",
                        icon: const Icon(Icons.arrow_forward),
                      ),
                      SizedBox(width: 20.w),

                      ElevatedButton(
                        onPressed: () {
                          AppAuth.role = 'user';
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: const BorderSide(color: AppColors.black),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "User Panel",
                              style: AppFonts.buttonBlack.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            const Icon(
                              Icons.arrow_forward,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
