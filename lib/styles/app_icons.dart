import 'package:flutter/cupertino.dart';

import 'app_theme.dart';

class AppIcons {
  const AppIcons._();

  // Splash Screen
  static Widget get splashTextIcon => Icon(
    CupertinoIcons.bolt_fill,
    color: AppTheme.primary,
    size: 30,
  );

  // Get Started Screen
  static Widget get getStartedWorkoutIcon => const Icon(
    CupertinoIcons.flame,
    color: AppTheme.primary,
    size: 45,
  );
  static Widget get getStartedCtaIcon => const Icon(
    CupertinoIcons.arrow_right,
    color: AppTheme.white,
    size: 25,
  );

  // Add User Screen
  static Widget get addUserCloseIcon => const Icon(
    CupertinoIcons.xmark,
    size: 40,
  );
  static Widget get addUserSaveIcon => const Icon(
    CupertinoIcons.bookmark_fill,
    color: AppTheme.white,
    size: 25,
  );

  // Bottom Navigation Bar
  static Widget get navBarMenuForwardIcon => const Icon(
    CupertinoIcons.chevron_forward,
    color: AppTheme.muted,
    size: 20,
  );

  // Dashboard
  static const IconData quoteIcon = CupertinoIcons.quote_bubble;
  static const IconData checkCircleFilled = CupertinoIcons.checkmark_circle_fill;
  static const IconData circleOutline = CupertinoIcons.circle;
  static const IconData editIcon = CupertinoIcons.pencil;
  static const IconData deleteIcon = CupertinoIcons.trash;
}
