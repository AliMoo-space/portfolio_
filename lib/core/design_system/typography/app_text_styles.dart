// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

@immutable
final class AppTextStyles {
  const AppTextStyles._();

  // ============================================================
  // Font Families
  // ============================================================

  static const String headingFontFamily = 'Inter';
  static const String bodyFontFamily = 'Inter';

  // ============================================================
  // Display
  // ============================================================

  static TextStyle get displayLarge => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        height: 48 / 40,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
        color: AppColors.textPrimary,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        height: 36 / 28,
        color: AppColors.textPrimary,
      );

  // ============================================================
  // Headline
  // ============================================================

  static TextStyle get headlineLarge => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        height: 36 / 28,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
        color: AppColors.textPrimary,
      );

  // ============================================================
  // Title
  // ============================================================

  static TextStyle get titleLarge => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w600,
        height: 24 / 16.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleSmall => TextStyle(
        fontFamily: headingFontFamily,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        height: 22 / 15,
        color: AppColors.textPrimary,
      );

  // ============================================================
  // Body
  // ============================================================

  static TextStyle get bodyLarge => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        height: 22 / 14.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w400,
        height: 19 / 13.5,
        color: AppColors.textSecondary,
      );

  // ============================================================
  // Label
  // ============================================================

  static TextStyle get labelLarge => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w600,
        height: 20 / 14.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w500,
        height: 18 / 13.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w500,
        height: 17 / 12.5,
        color: AppColors.textSecondary,
      );

  // ============================================================
  // Custom Styles
  // ============================================================

  static TextStyle get hint => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        height: 20 / 14.5,
        color: AppColors.textHint,
      );

  static TextStyle get disabled => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        height: 20 / 14.5,
        color: AppColors.textDisabled,
      );

  static TextStyle get inverse => TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        height: 20 / 14.5,
        color: AppColors.textInverse,
      );

  // ============================================================
  // Responsive Section & Hero Typography Helpers
  // ============================================================

  /// Returns standardized responsive section header style across breakpoints
  static TextStyle sectionTitle(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 640) {
      return headlineMedium.copyWith(
        fontSize: width < 360 ? 22.0 : 25.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      );
    } else if (width < 1024) {
      return displaySmall.copyWith(
        fontSize: 28.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
      );
    } else {
      return displayMedium.copyWith(
        fontSize: 34.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
      );
    }
  }

  /// Specialized style for the hero name across devices
  static TextStyle heroName({
    double? fontSize,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: headingFontFamily,
        fontSize: fontSize ?? 72.0,
        fontWeight: FontWeight.w900,
        height: 1.15,
        letterSpacing: -1.2,
        color: color ?? Colors.white,
      );

  /// Specialized style for the typewriter subtitle
  static TextStyle heroSubtitle({
    double? fontSize,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: headingFontFamily,
        fontSize: fontSize ?? 36.0,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.5,
        color: color ?? AppColors.textSecondary,
      );

  /// Standardized hero bio description style
  static TextStyle heroBio({
    double? fontSize,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: fontSize ?? 18.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color ?? AppColors.textSecondary,
      );

  /// Standardized navbar logo typography
  static TextStyle navLogo({
    double? fontSize,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: headingFontFamily,
        fontSize: fontSize ?? 20.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: color ?? Colors.white,
      );

  /// Standardized nav menu item typography
  static TextStyle navItem({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: fontSize ?? 15.0,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.textSecondary,
      );
}

