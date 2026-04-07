import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/routines/add_new_routine_screen.dart';
import '../../features/tasks/add_task_screen.dart';
import '../../styles/app_icons.dart';
import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';

const kBottomNavBarHeight = 100.0;

enum AppTab { home, tasks, routines, stats, account }

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
    required this.isAddMenuOpen,
    required this.onAddPressed,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTabSelected;
  final bool isAddMenuOpen;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    const items = <({AppTab? tab, IconData outlineIcon, IconData filledIcon})>[
      (
        tab: AppTab.home,
        outlineIcon: CupertinoIcons.house,
        filledIcon: CupertinoIcons.house_fill,
      ),
      (
        tab: AppTab.tasks,
        outlineIcon: CupertinoIcons.checkmark_square,
        filledIcon: CupertinoIcons.checkmark_square_fill,
      ),
      (
        tab: null,
        outlineIcon: CupertinoIcons.add,
        filledIcon: CupertinoIcons.xmark,
      ),
      (
        tab: AppTab.routines,
        outlineIcon: CupertinoIcons.clock,
        filledIcon: CupertinoIcons.clock_fill,
      ),
      (
        tab: AppTab.stats,
        outlineIcon: CupertinoIcons.chart_bar,
        filledIcon: CupertinoIcons.chart_bar_fill,
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
                  Colors.white.withValues(alpha: 0.08),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              color: const Color(0xFF15171B).withValues(alpha: 0.45),
            ),
            child: Row(
              children: items.map((item) {
                if (item.tab == null) {
                  return Expanded(
                    child: _CenterAddButton(
                      isOpen: isAddMenuOpen,
                      onPressed: onAddPressed,
                    ),
                  );
                }
                final isSelected = currentTab == item.tab;
                return Expanded(
                  child: _NavItem(
                    icon: isSelected ? item.filledIcon : item.outlineIcon,
                    isSelected: isSelected,
                    onTap: () => onTabSelected(item.tab!),
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
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppTheme.background : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 25,
          color: isSelected
              ? AppTheme.primary
              : AppTheme.white.withValues(alpha: 0.50),
        ),
      ),
    );
  }
}

class _AddMenuTile extends StatelessWidget {
  const _AddMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: AppTheme.primary, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: AppTypography.navBarMenuItemText,
              ),
            ),
            AppIcons.navBarMenuForwardIcon,
          ],
        ),
      ),
    );
  }
}

class AddQuickMenu extends StatelessWidget {
  const AddQuickMenu({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                color: const Color(0xFF15171B).withValues(alpha: 0.45),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AddMenuTile(
                    icon: CupertinoIcons.checkmark_square,
                    title: 'Add Task',
                    onTap: () {
                      onClose();
                      navigator.push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AddTaskScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 1,
                  ),
                  _AddMenuTile(
                    icon: CupertinoIcons.clock,
                    title: 'Add Routine',
                    onTap: () {
                      onClose();
                      navigator.push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AddNewRoutineScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CenterAddButton extends StatelessWidget {
  const _CenterAddButton({required this.isOpen, required this.onPressed});

  final bool isOpen;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: isOpen ? AppTheme.surface : AppTheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isOpen ? CupertinoIcons.xmark : CupertinoIcons.add,
            color: AppTheme.white,
            size: 23,
          ),
        ),
      ),
    );
  }
}
