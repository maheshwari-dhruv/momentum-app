import 'package:flutter/material.dart';

enum AppTab { home, tasks, routines, stats, account }

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      onTap: (index) => onTabSelected(AppTab.values[index]),
      backgroundColor: const Color(0xFF040C1F),
      selectedItemColor: const Color(0xFF3B82F6),
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Task'),
        BottomNavigationBarItem(icon: Icon(Icons.cached_rounded), label: 'Routine'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Account'),
      ],
    );
  }
}
