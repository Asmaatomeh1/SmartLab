import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  final VoidCallback onPressed;
  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: AppFonts.buttonWhite.copyWith(fontSize: 16.sp)),
            SizedBox(width: 8.w),
            Icon(
              icon?.icon,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
