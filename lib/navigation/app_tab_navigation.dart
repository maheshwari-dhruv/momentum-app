import 'package:flutter/material.dart';

import '../dashboard_screen.dart';
import '../profile_screen.dart';
import '../routine_screen.dart';
import '../stats_screen.dart';
import '../task_screen.dart';
import '../widgets/app_bottom_nav_bar.dart';

void navigateFromTabSelection(
  BuildContext context, {
  required AppTab currentTab,
  required AppTab selectedTab,
}) {
  if (selectedTab == currentTab) return;

  Widget destination;
  switch (selectedTab) {
    case AppTab.home:
      destination = const DashboardScreen();
      break;
    case AppTab.tasks:
      destination = const TaskScreen();
      break;
    case AppTab.routines:
      destination = const RoutineScreen();
      break;
    case AppTab.stats:
      destination = const StatsScreen();
      break;
    case AppTab.account:
      destination = const ProfileScreen();
      break;
  }

  Navigator.of(
    context,
  ).pushReplacement(
    PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => destination,
      transitionDuration: const Duration(milliseconds: 240),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.02, 0),
                  end: Offset.zero,
                ).animate(curved),
            child: child,
          ),
        );
      },
    ),
  );
}
