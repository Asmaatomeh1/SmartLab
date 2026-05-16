import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.validator,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.fontSize = 16,
    this.onChanged,
    this.maxLines = 1,
    this.prefixIcon,
  });

  final String? Function(String?)? validator;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double fontSize;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          // hintStyle: AppFonts.subtitleGreyMedium.copyWith(fontSize: 15.sp),
          hint: Text(
            "Enter your $labelText",
            style: AppFonts.subtitleGreyMedium.copyWith(fontSize: fontSize.h),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Color.fromARGB(143, 131, 133, 137),
              width: 1,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Color.fromARGB(143, 131, 133, 137),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color.fromARGB(143, 131, 133, 137),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
