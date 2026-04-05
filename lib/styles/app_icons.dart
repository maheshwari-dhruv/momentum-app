import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppIcons {
  const AppIcons._();

  // Splash Screen
  static Widget get splashTextIcon => const Icon(
    Ionicons.flash_sharp,
    color: Colors.white,
    size: 25,
  );

  // Get Started Screen
  static Widget get getStartedWorkoutIcon => const Icon(
    Ionicons.barbell_sharp,
    color: Colors.white,
    size: 35,
  );
  static Widget get getStartedCtaIcon => const Icon(
    Ionicons.arrow_forward_outline,
    color: Colors.white,
    size: 20,
  );

  // Add User Screen
  static Widget get addUserBackIcon => const Icon(
    Ionicons.arrow_back_outline,
    color: Color(0xFFED7225),
    size: 25,
  );
}
