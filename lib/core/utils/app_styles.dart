import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppStyles{
  static TextStyle regular12Text = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryDark
  );

  static TextStyle regular12SalePrice = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryDark
  );

  static TextStyle regular14Text = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryDark
  );

  static TextStyle regular14Primary = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryColor
  );

  static TextStyle regular18White = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.whiteColor
  );

  static TextStyle light14SearchHint = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.searchHintColor
  );

  static TextStyle light16White = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.whiteColor
  );

  static TextStyle light18HintText = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w300, color: AppColors.hintTextColor
  );

  static TextStyle semi16TextWhite = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.whiteColor
  );

  static TextStyle semi20Primary = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryColor
  );

  static TextStyle semi24White = GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.whiteColor
  );

  static TextStyle medium14Category = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryDark
  );

  static TextStyle medium20Primary = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.primaryColor);

  static TextStyle medium18White = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.whiteColor
  );

  static TextStyle medium18Header = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.blackColor);
}