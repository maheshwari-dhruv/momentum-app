import 'package:flutter/material.dart';

import 'navigation/app_tab_navigation.dart';
import 'widgets/app_bottom_nav_bar.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      body: const SafeArea(
        child: Center(
          child: Text('Stats Screen', style: TextStyle(color: Colors.white)),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.stats,
        onTabSelected: (selected) {
          navigateFromTabSelection(
            context,
            currentTab: AppTab.stats,
            selectedTab: selected,
          );
        },
      ),
    );
  }
}
