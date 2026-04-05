// ignore_for_file: file_names

import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button2 extends StatelessWidget {
  const Button2({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(text, style: AppFonts.buttonLogin.copyWith(fontSize: 20.sp)),
    );
  }
}
