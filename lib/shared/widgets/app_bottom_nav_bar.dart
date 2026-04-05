import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
    const items = <({AppTab tab, IconData outlineIcon, IconData filledIcon})>[
      (
        tab: AppTab.home,
        outlineIcon: Ionicons.egg_outline,
        filledIcon: Ionicons.egg,
      ),
      (
        tab: AppTab.tasks,
        outlineIcon: Ionicons.checkbox_outline,
        filledIcon: Ionicons.checkbox,
      ),
      (
        tab: AppTab.routines,
        outlineIcon: Ionicons.time_outline,
        filledIcon: Ionicons.time,
      ),
      (
        tab: AppTab.stats,
        outlineIcon: Ionicons.stats_chart_outline,
        filledIcon: Ionicons.stats_chart,
      ),
      (
        tab: AppTab.account,
        outlineIcon: Ionicons.person_outline,
        filledIcon: Ionicons.person,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.15),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
              ),
              color: const Color(0xFF15171B).withValues(alpha: 0.70),
            ),
            child: Row(
              children: items.map((item) {
                final isSelected = currentTab == item.tab;
                return Expanded(
                  child: _NavItem(
                    icon: isSelected ? item.filledIcon : item.outlineIcon,
                    isSelected: isSelected,
                    onTap: () => onTabSelected(item.tab),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 21,
          color: isSelected ? Colors.white : Colors.white54,
        ),
      ),
    );
  }
}
