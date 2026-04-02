import 'package:flutter/material.dart';

import 'navigation/app_tab_navigation.dart';
import 'widgets/app_bottom_nav_bar.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020B1F),
        foregroundColor: Colors.white,
        title: const Text('Routines'),
      ),
      body: const Center(
        child: Text('Routine Screen', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.routines,
        onTabSelected: (selected) {
          navigateFromTabSelection(
            context,
            currentTab: AppTab.routines,
            selectedTab: selected,
          );
        },
      ),
    );
  }
}
