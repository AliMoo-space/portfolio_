import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../spacing/app_radius.dart';
import '../spacing/app_spacing.dart';
import '../typography/app_text_styles.dart';

@immutable
final class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      fontFamily: AppTextStyles.bodyFontFamily,

      // تم تغييرها من AppColors.white إلى background
      // لأن background هو لون خلفية التطبيق الأساسي.
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,

        // تم تصحيحها لاستخدام onPrimary بدل textPrimary
        // لأنها مخصصة للنصوص والأيقونات فوق primary.
        onPrimary: AppColors.onPrimary,

        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,

        // تم إضافة accent كـ tertiary للـColorScheme
        // بحيث يكون لون الـAccent متاحًا من خلال الـTheme.
        tertiary: AppColors.accent,
        onTertiary: AppColors.onAccent,

        // تم تغييرها من background إلى surface
        // لأن surface مخصص للكروت والـMaterial surfaces.
        surface: AppColors.surface,

        onSurface: AppColors.onSurface,

        error: AppColors.error,
        onError: AppColors.onError,

        // استخدام الـoutline المخصص بدل border مباشرة.
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      dividerColor: AppColors.divider,

      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space24,
            vertical: AppSpacing.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius12),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),

        hintStyle: AppTextStyles.hint,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          borderSide: const BorderSide(color: AppColors.error),
        ),

        // تم إضافة focusedErrorBorder
        // عشان شكل الـTextField يفضل واضح لو عليه Error وهو Focused.
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      // تم إضافة focusedErrorBorder
      // عشان شكل الـTextField يفضل واضح لو عليه Error وهو Focused.
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),

      iconTheme: const IconThemeData(color: AppColors.textSecondary),

      // تمت إضافة Theme للـCheckbox
      // عشان ياخد ألوان الـDesign System بدل الألوان الافتراضية.
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius4),
        ),
        side: const BorderSide(color: AppColors.outline),
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return null;
        }),
      ),

      // تمت إضافة Theme للـRadio
      // عشان اللون المختار يعتمد على الـprimary.
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.outline;
        }),
      ),

      // تمت إضافة Theme للـSwitch
      // عشان الـselected والـdisabled states يستخدموا ألوان الـDesign System.
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.onPrimary;
          }

          return AppColors.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.disabled;
        }),
      ),
    );
  }

  static ThemeData get lightTheme => light;

  static ThemeData get darkTheme => dark;

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.bodyFontFamily,
      scaffoldBackgroundColor: AppColors.darkCanvas,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cyanAccent,
        onPrimary: AppColors.darkCanvas,
        secondary: AppColors.electricBlue,
        onSecondary: Colors.white,
        tertiary: AppColors.brightFuchsia,
        onTertiary: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: Colors.white,
        error: AppColors.error,
        onError: AppColors.onError,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkCardContainer,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.white),
        displayMedium: AppTextStyles.displayMedium.copyWith(color: Colors.white),
        displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.white),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: Colors.white),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: const Color(0xFFE2E8F0)),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFFCBD5E1)),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF94A3B8)),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        labelMedium: AppTextStyles.labelMedium.copyWith(color: const Color(0xFFCBD5E1)),
        labelSmall: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF94A3B8)),
      ),
      dividerColor: AppColors.darkBorder,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.cyanAccent,
          foregroundColor: AppColors.darkCanvas,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space24,
            vertical: AppSpacing.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius12),
          ),
        ),
      ),
    );
  }
}
