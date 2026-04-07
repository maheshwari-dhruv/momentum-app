import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppTypography {
  const AppTypography._();

  static const String googleSansFamily = 'GoogleSans';

  // Splash Screen
  static TextStyle get splashTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: AppTheme.white,
  );

  // Get Started Screen
  static TextStyle get getStartedMutedWord => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: AppTheme.muted,
  );
  static TextStyle get getStartedMainWord => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppTheme.white,
  );
  static TextStyle get getStartedHeadline => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppTheme.white,
  );
  static TextStyle get getStartedBody => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.25,
    color: AppTheme.textSecondary,
  );
  static TextStyle get getStartedButtonText => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // Add User Screen
  static TextStyle get addUserHeadline => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.25,
    color: AppTheme.white,
  );
  static TextStyle get addUserFieldLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    color: AppTheme.textSecondary,
  );
  static TextStyle get addUserTextFieldText => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    color: AppTheme.white,
  );
  static TextStyle get addUserSaveButtonText => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // Bottom Navigation Bar
  static TextStyle get navBarMenuItemText => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppTheme.textPrimary,
  );

  // Dashboard Screen
  static TextStyle get dashboardHeadline => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 22.5,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );
  static TextStyle get dashboardSubtitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 17.5,
    fontWeight: FontWeight.w500,
    color: AppTheme.textSecondary,
  );
  static TextStyle get dashboardCardHeading => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppTheme.white,
  );
  static TextStyle get dashboardPillLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: AppTheme.primary,
  );
  static TextStyle get dashboardQuote => TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: AppTheme.white.withValues(alpha: 0.7),
    fontStyle: FontStyle.italic,
  );
  static TextStyle get dashboardTileTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
  );
  static TextStyle get dashboardTileSubtitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textSecondary,
  );
  static TextStyle get dashboardEmptyState => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.muted,
  );
  static TextStyle get chartAxisLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textSecondary,
  );
  static TextStyle get chartYAxisLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppTheme.textSecondary,
  );

  // Profile Screen
  static TextStyle get profileScreenTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );
  static TextStyle get profileUsername => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );
  static TextStyle get profileSectionLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppTheme.muted,
  );
  static TextStyle get profileTileTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
  );
  static TextStyle get profileTileSubtitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textSecondary,
  );
  static TextStyle get profileVersionLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
    color: AppTheme.muted,
  );

  // Task Screen
  static TextStyle get taskSectionHeader => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: AppTheme.textSecondary,
  );
  static TextStyle get taskCardTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
  );
  static TextStyle get taskPriorityLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get taskCategoryPill => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppTheme.primary,
  );
  static TextStyle get taskTimeLabel => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.muted,
  );
  static TextStyle get taskFilterChip => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppTheme.white,
  );
  static TextStyle get taskProgressCount => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppTheme.textSecondary,
  );
  static TextStyle get taskProgressTitle => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );
  static TextStyle get taskProgressPercent => const TextStyle(
    fontFamily: googleSansFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppTheme.white,
  );

  static TextTheme get textTheme => _buildTextTheme(
    fontFamily: googleSansFamily,
    bodyColor: AppTheme.white,
    displayColor: AppTheme.white,
    mutedColor: AppTheme.muted,
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
