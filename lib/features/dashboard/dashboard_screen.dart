import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<_PendingTaskItem> _pendingTasks = <_PendingTaskItem>[
    _PendingTaskItem(
      tag: 'HIGH',
      tagColor: Color(0xFFEF4444),
      title: 'Finish Q3 Project Report',
      subtitle: 'Due 5:00 PM',
    ),
    _PendingTaskItem(
      tag: 'MED',
      tagColor: Color(0xFFEAB308),
      title: 'Grocery Shopping',
      subtitle: 'Milk, Eggs',
    ),
    _PendingTaskItem(
      tag: 'LOW',
      tagColor: Color(0xFF22C55E),
      title: 'Read 10 pages',
      subtitle: 'Atomic Habits',
    ),
    _PendingTaskItem(
      tag: 'PERSONAL',
      tagColor: Color(0xFF8B5CF6),
      title: 'Call Mom',
      subtitle: 'Check-in',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateText = DateFormat('MMM d').format(now).toUpperCase();
    final dayText = DateFormat('EEEE').format(now);
    final weeklyData = const <_WeeklyProgressPoint>[
      _WeeklyProgressPoint(label: 'M', completed: 2, total: 5),
      _WeeklyProgressPoint(label: 'T', completed: 3, total: 5),
      _WeeklyProgressPoint(label: 'W', completed: 4, total: 5),
      _WeeklyProgressPoint(label: 'T', completed: 3, total: 5),
      _WeeklyProgressPoint(label: 'F', completed: 5, total: 5),
      _WeeklyProgressPoint(label: 'S', completed: 2, total: 5),
      _WeeklyProgressPoint(label: 'S', completed: 1, total: 5),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateText,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white70,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        dayText,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF101D37),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Progress',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Overall routines completed',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: weeklyData
                            .map(
                              (point) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: _WeeklyProgressBar(point: point),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Text(
                    "Today's Routines",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _goToRoutine(context),
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _RoutineTile(
                icon: Icons.restaurant_rounded,
                title: 'Diet Routine',
                subtitle: '3/4 meals logged',
                progress: 0.75,
                progressColor: const Color(0xFF4ADE80),
                onTap: () => _goToRoutine(context),
              ),
              const SizedBox(height: 10),
              _RoutineTile(
                icon: Icons.fitness_center_rounded,
                title: 'Workout Routine',
                subtitle: '45 mins left',
                progress: 0.25,
                progressColor: const Color(0xFF60A5FA),
                onTap: () => _goToRoutine(context),
              ),
              const SizedBox(height: 10),
              _RoutineTile(
                icon: Icons.spa_rounded,
                title: 'Skincare Routine',
                subtitle: 'Morning done',
                progress: 0.50,
                progressColor: const Color(0xFFA78BFA),
                onTap: () => _goToRoutine(context),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Pending Tasks',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _goToPendingTasks(context),
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.95,
                children: _pendingTasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final task = entry.value;
                  return _TaskCard(
                    tag: task.tag,
                    tagColor: task.tagColor,
                    title: task.title,
                    subtitle: task.subtitle,
                    isCompleted: task.isCompleted,
                    onToggleComplete: () => _markTaskAsComplete(index),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '"Small daily improvements are the key to staggering long-term results."',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.home,
        onTabSelected: (selected) {
          navigateFromTabSelection(
            context,
            currentTab: AppTab.home,
            selectedTab: selected,
          );
        },
      ),
    );
  }

  void _goToRoutine(BuildContext context) {
    navigateFromTabSelection(
      context,
      currentTab: AppTab.home,
      selectedTab: AppTab.routines,
    );
  }

  void _goToPendingTasks(BuildContext context) {
    navigateFromTabSelection(
      context,
      currentTab: AppTab.home,
      selectedTab: AppTab.tasks,
    );
  }

  void _markTaskAsComplete(int index) {
    if (_pendingTasks[index].isCompleted) return;
    setState(() {
      _pendingTasks[index] = _pendingTasks[index].copyWith(isCompleted: true);
    });
    // TODO: Persist completion status in database.
  }
}

class _WeeklyProgressPoint {
  const _WeeklyProgressPoint({
    required this.label,
    required this.completed,
    required this.total,
  });

  final String label;
  final int completed;
  final int total;

  double get ratio => total == 0 ? 0 : completed / total;
}

class _WeeklyProgressBar extends StatelessWidget {
  const _WeeklyProgressBar({required this.point});

  final _WeeklyProgressPoint point;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: point.ratio.clamp(0.08, 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF22D3EE), Color(0xFF2563EB)],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          point.label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _RoutineTile extends StatelessWidget {
  const _RoutineTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final double progress;
  final Color progressColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF101D37),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1A2B4A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: progressColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: const Color(0xFF253556),
                      color: progressColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: progressColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.onToggleComplete,
  });

  final String tag;
  final Color tagColor;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback onToggleComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF101D37),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: tagColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onToggleComplete,
                splashRadius: 18,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isCompleted ? const Color(0xFF22C55E) : Colors.white38,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isCompleted ? Colors.white54 : Colors.white,
              fontWeight: FontWeight.w600,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isCompleted ? Colors.white38 : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingTaskItem {
  const _PendingTaskItem({
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  final String tag;
  final Color tagColor;
  final String title;
  final String subtitle;
  final bool isCompleted;

  _PendingTaskItem copyWith({bool? isCompleted}) {
    return _PendingTaskItem(
      tag: tag,
      tagColor: tagColor,
      title: title,
      subtitle: subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
