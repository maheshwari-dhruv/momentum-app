import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'AeonikTRIAL';

  // Get Started Screen
  static TextStyle get getStartedMutedWord => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.white,
  ).copyWith(
    color: Colors.white.withValues(alpha: 0.4),
  );
  static TextStyle get getStartedMainWord => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: Colors.white,
  );
  static TextStyle get getStartedHeadline => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
    color: Colors.white,
  );
  static TextStyle get getStartedBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    height: 1.5,
    color: Color(0x73FFFFFF),
  );
  static TextStyle get getStartedButtonText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Add User Screen
  static TextStyle get addUserHeadline => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 35,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 0,
    color: Color(0xFFED7225),
  );
  static TextStyle get addUserFieldLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    color: Colors.white,
  );
  static TextStyle get addUserTextFieldText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    color: Colors.white,
  );
  static TextStyle get addUserPrimaryButtonText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.5,
    fontWeight: FontWeight.w600,
    color: Color(0xFF110600),
  );
  static TextStyle get addUserSecondaryButtonText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Dashboard Screen
  static TextStyle get dashboardHeadline => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    // color: Color(0xFF110600),
  );
  static TextStyle get dashboardSubtitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    // color: const Color(0xFF110600).withValues(alpha: 0.7),
  );

  static const String googleSansFamily = 'GoogleSans';

  // Splash Screen
  static TextStyle get splashTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: AppTheme.textPrimary,
  );

  static TextTheme get textTheme => _buildTextTheme(
    fontFamily: googleSansFamily,
    bodyColor: const Color(0xFF262626),
    displayColor: const Color(0xFF262626),
    mutedColor: const Color(0xFF9A9A9A),
  );

  static TextTheme lightTextTheme = _buildTextTheme(
    fontFamily: fontFamily,
    bodyColor: const Color(0xFF111827),
    displayColor: const Color(0xFF0F172A),
    mutedColor: const Color(0xFF6B7280),
  );

  static TextTheme darkTextTheme = _buildTextTheme(
    fontFamily: fontFamily,
    bodyColor: const Color(0xFFF8FAFC),
    displayColor: Colors.white,
    mutedColor: const Color(0xFF94A3B8),
  );

  static TextTheme _buildTextTheme({
    required String fontFamily,
    required Color bodyColor,
    required Color displayColor,
    required Color mutedColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: displayColor,
        height: 1.15,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: displayColor,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: displayColor,
        height: 1.2,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: displayColor,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: displayColor,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: displayColor,
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: displayColor,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: bodyColor,
        height: 1.35,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: bodyColor,
        height: 1.35,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: bodyColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: bodyColor,
        height: 1.45,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: mutedColor,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: bodyColor,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: bodyColor,
        height: 1.2,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: mutedColor,
        height: 1.2,
      ),
    );
  }
}
