import 'package:flutter/material.dart';

import 'navigation/app_tab_navigation.dart';
import 'widgets/app_bottom_nav_bar.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'pending task screen',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.tasks,
        onTabSelected: (selected) {
          navigateFromTabSelection(
            context,
            currentTab: AppTab.tasks,
            selectedTab: selected,
          );
        },
      ),
    );
  }
}
