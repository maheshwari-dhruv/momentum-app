import 'package:flutter/material.dart';

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'AeonikTRIAL';

  // Splash Screen
  static TextStyle get splashTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Colors.white,
  );

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

  static TextTheme lightTextTheme = _buildTextTheme(
    bodyColor: const Color(0xFF111827),
    displayColor: const Color(0xFF0F172A),
    mutedColor: const Color(0xFF6B7280),
  );

  static TextTheme darkTextTheme = _buildTextTheme(
    bodyColor: const Color(0xFFF8FAFC),
    displayColor: Colors.white,
    mutedColor: const Color(0xFF94A3B8),
  );

  static TextTheme _buildTextTheme({
    required Color bodyColor,
    required Color displayColor,
    required Color mutedColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: displayColor,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        color: displayColor,
        height: 1.1,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: displayColor,
        height: 1.15,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        color: displayColor,
        height: 1.15,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: displayColor,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: displayColor,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: displayColor,
        height: 1.25,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: bodyColor,
        height: 1.25,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: bodyColor,
        height: 1.25,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: bodyColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: bodyColor,
        height: 1.45,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: mutedColor,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: bodyColor,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: bodyColor,
        height: 1.2,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: mutedColor,
        height: 1.2,
      ),
    );
  }
}
