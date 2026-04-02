import 'package:flutter/material.dart';

import '../profile_screen.dart';

enum AppTab { home, tasks, routines, stats }

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
      ],
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const ProfileScreen()));
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF1C2A47),
          borderRadius: BorderRadius.circular(19),
        ),
        child: const Icon(Icons.person_outline_rounded, color: Colors.white),
      ),
    );
  }
}
