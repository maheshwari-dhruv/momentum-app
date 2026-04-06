import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'app_theme.dart';

class AppIcons {
  const AppIcons._();

  // Splash Screen
  static Widget get splashTextIcon => const Icon(
    Ionicons.flash_sharp,
    color: AppTheme.iconPrimary,
    size: 30,
  );

  // Get Started Screen
  static Widget get getStartedWorkoutIcon => const Icon(
    Ionicons.barbell_sharp,
    color: AppTheme.iconPrimary,
    size: 35,
  );
  static Widget get getStartedCtaIcon => const Icon(
    Ionicons.arrow_forward_outline,
    color: AppTheme.white,
    size: 20,
  );

  // Add User Screen
  static Widget get addUserCloseIcon => const Icon(
    Ionicons.close,
    size: 30,
  );
  static Widget get addUserSaveIcon => const Icon(
    Ionicons.bookmark,
    color: AppTheme.white,
    size: 25,
  );
}
