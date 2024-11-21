import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:moniepoint_test/utils/app_colors.dart';

// roboto, open sans, lato

class AppTypography {
  static final _instance = AppTypography._internal();

  AppTypography._internal();

  factory AppTypography() => _instance;

  static final outfitBold24 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 38.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.1,
    ),
  );

  static final outfitBold17 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      height: 1.1,
    ),
  );

  static final outfitNormal14 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: appColors.brownA5947D,
      height: 1.1,
    ),
  );

  static final outfitNormal25 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w400,
      color: appColors.brownA5947D,
      height: 1.1,
    ),
  );
  static final outfitNormal16 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: appColors.brownA5947D,
      height: 1.1,
    ),
  );
  static final outfitNormal17 = GoogleFonts.outfit(
    textStyle: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: appColors.black,
      height: 1.1,
    ),
  );
}
