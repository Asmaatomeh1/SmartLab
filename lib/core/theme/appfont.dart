import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static TextStyle title = TextStyle(
    fontFamily: 'SFCompactDisplay',
    fontSize: 35.w,
    fontWeight: FontWeight.bold,
    height: 1.18.h,
    color: const Color(0xFF151516),
  );

  static TextStyle titleBlue = TextStyle(
    fontFamily: 'SFCompactDisplay',
    fontSize: 35.w,
    fontWeight: FontWeight.bold,
    height: 1.18.h,
    color: const Color(0xFF407BFF),
  );
  static TextStyle subtitle = TextStyle(
    fontFamily: 'SFCompactDisplay',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    height: 1.18.h,
    color: AppColors.grey,
  );
  static TextStyle subtitleBlackMedium = TextStyle(
    fontFamily: 'SFCompactDisplay',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.18.h,
    color: AppColors.black,
  );

  static TextStyle subtitleGreyMedium = TextStyle(
    fontFamily: 'SFCompactDisplay',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.18.h,
    color: AppColors.grey,
  );
  static TextStyle buttonWhite = TextStyle(
    fontFamily: "SFCompactDisplay",
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle buttonBlack = TextStyle(
    fontFamily: "SFCompactDisplay",
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF151516),
  );
  static TextStyle buttonLogin = TextStyle(
    fontFamily: "SFCompactDisplay",
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
