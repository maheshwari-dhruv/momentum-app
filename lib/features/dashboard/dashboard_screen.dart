import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_tab_scaffold.dart';
import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';
import '../profile/profile_screen.dart';
import '../tasks/add_task_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<_TaskItem> _todayTasks = [];
  List<_RoutineCategoryGroup> _routineGroups = [];
  List<_WeeklyProgressPoint> _weeklyData = [];

  @override
  void initState() {
    super.initState();
    _loadTodayTasks();
    _loadTodayRoutines();
    _loadWeeklyProgress();
  }

  /// Placeholder — replace with actual DB query to fetch today's tasks.
  Future<void> _loadTodayTasks() async {
    // TODO: Fetch from database. For now, use dummy data.
    final tasks = <_TaskItem>[
      _TaskItem(
        id: '1',
        title: 'Finish Q3 Project Report',
        category: 'Work',
        priority: TaskPriority.high,
      ),
      _TaskItem(
        id: '2',
        title: 'Grocery Shopping',
        category: 'Personal',
        priority: TaskPriority.medium,
      ),
      _TaskItem(
        id: '3',
        title: 'Read 10 pages',
        category: 'Self-care',
        priority: TaskPriority.low,
      ),
      _TaskItem(
        id: '4',
        title: 'Call Mom',
        category: 'Personal',
        priority: TaskPriority.medium,
      ),
      _TaskItem(
        id: '5',
        title: 'Review pull requests',
        category: 'Work',
        priority: TaskPriority.high,
      ),
    ];
    setState(() => _todayTasks = tasks);
  }

  /// Placeholder — replace with actual DB query.
  /// Fetches today's routines, groups by category, calculates completion %.
  Future<void> _loadTodayRoutines() async {
    // TODO: Fetch routines from database grouped by category.
    final groups = <_RoutineCategoryGroup>[
      _RoutineCategoryGroup(
        category: 'Diet',
        icon: CupertinoIcons.flame,
        color: const Color(0xFF4ADE80),
        completedCount: 3,
        totalCount: 4,
      ),
      _RoutineCategoryGroup(
        category: 'Workout',
        icon: CupertinoIcons.bolt_fill,
        color: const Color(0xFF60A5FA),
        completedCount: 1,
        totalCount: 4,
      ),
      _RoutineCategoryGroup(
        category: 'Skincare',
        icon: CupertinoIcons.sparkles,
        color: const Color(0xFFA78BFA),
        completedCount: 2,
        totalCount: 4,
      ),
    ];
    setState(() => _routineGroups = groups);
  }

  /// Placeholder — replace with actual calculation from DB.
  /// Computes daily completion ratios for the current week.
  Future<void> _loadWeeklyProgress() async {
    // TODO: Fetch from database. For now, use dummy data.
    final data = <_WeeklyProgressPoint>[
      _WeeklyProgressPoint(label: 'M', completed: 2, total: 5),
      _WeeklyProgressPoint(label: 'T', completed: 3, total: 5),
      _WeeklyProgressPoint(label: 'W', completed: 4, total: 5),
      _WeeklyProgressPoint(label: 'T', completed: 3, total: 5),
      _WeeklyProgressPoint(label: 'F', completed: 5, total: 5),
      _WeeklyProgressPoint(label: 'S', completed: 2, total: 5),
      _WeeklyProgressPoint(label: 'S', completed: 1, total: 5),
    ];
    setState(() => _weeklyData = data);
  }

  void _goToStats(BuildContext context) {
    navigateFromTabSelection(
      context,
      currentTab: AppTab.home,
      selectedTab: AppTab.stats,
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greetingText = _getGreeting(now);
    final dateText = DateFormat('E, d MMMM, y').format(now);
    const username = 'Username'; // TODO: Fetch from DB.

    return AppTabScaffold(
      currentTab: AppTab.home,
      onTabSelected: (selected) {
        navigateFromTabSelection(
          context,
          currentTab: AppTab.home,
          selectedTab: selected,
        );
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, kBottomNavBarHeight + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildGreeting(greetingText, username),
                      const SizedBox(height: 4),
                      Text(dateText, style: AppTypography.dashboardSubtitle),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ProfileScreen(),
                    ),
                  ),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD178),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('🐯', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ── Weekly Progress Card ──
            _DashboardCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Progress',
                        style: AppTypography.dashboardCardHeadingText,
                      ),
                      const Spacer(),
                      _SeeAllPill(
                        label: 'All Stats',
                        onTap: () => _goToStats(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 180,
                    child: _WeeklyAreaChart(data: _weeklyData),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ── Routines Card ──
            _DashboardCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Routines',
                        style: AppTypography.dashboardCardHeadingText,
                      ),
                      const Spacer(),
                      _SeeAllPill(onTap: () => _goToRoutine(context)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (_routineGroups.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No routines for today.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppTheme.muted),
                        ),
                      ),
                    )
                  else
                    ..._routineGroups.map(
                      (group) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _RoutineTile(group: group),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ── Today's Tasks Card ──
            _DashboardCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tasks",
                        style: AppTypography.dashboardCardHeadingText,
                      ),
                      const Spacer(),
                      _SeeAllPill(onTap: () => _goToTaskScene(context)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (_todayTasks.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No tasks for today.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppTheme.muted),
                        ),
                      ),
                    )
                  else
                    _buildTaskGrid(),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ── Quote Card ──
            _DashboardCard(
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.quote_bubble,
                    color: AppTheme.primary.withValues(alpha: 1),
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      '"Small daily improvements are the key to staggering long-term results."',
                      style: AppTypography.dashboardQuote,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  void _goToTaskScene(BuildContext context) {
    navigateFromTabSelection(
      context,
      currentTab: AppTab.home,
      selectedTab: AppTab.tasks,
    );
  }

  List<_TaskItem> get _sortedTasks {
    final active = _todayTasks.where((t) => !t.isCompleted).toList();
    final completed = _todayTasks.where((t) => t.isCompleted).toList();
    return [...active, ...completed];
  }

  void _toggleTask(String id) {
    setState(() {
      final i = _todayTasks.indexWhere((t) => t.id == id);
      if (i == -1) return;
      _todayTasks[i] = _todayTasks[i].copyWith(
        isCompleted: !_todayTasks[i].isCompleted,
      );
    });
    // TODO: Persist completion status in database.
  }

  void _onEditTask(String id) {
    final task = _todayTasks.firstWhere((t) => t.id == id);
    Navigator.of(context).push(
      MaterialPageRoute<bool>(
        builder: (_) => AddTaskScreen(
          editTaskId: task.id,
          initialName: task.title,
          initialPriority: task.priority.name,
          initialCategory: task.category,
        ),
      ),
    ).then((saved) {
      if (saved == true) _loadTodayTasks();
    });
  }

  void _onDeleteTask(String id) {
    setState(() => _todayTasks.removeWhere((t) => t.id == id));
    // TODO: Delete from database.
  }

  Widget _buildTaskGrid() {
    final tasks = _sortedTasks;
    final left = <_TaskItem>[];
    final right = <_TaskItem>[];
    for (var i = 0; i < tasks.length; i++) {
      (i.isEven ? left : right).add(tasks[i]);
    }

    Widget buildColumn(List<_TaskItem> items) {
      return Expanded(
        child: Column(
          children: items
              .map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TaskCard(
                    task: task,
                    onToggle: () => _toggleTask(task.id),
                    onEdit: () => _onEditTask(task.id),
                    onDelete: () => _onDeleteTask(task.id),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildColumn(left),
        const SizedBox(width: 10),
        buildColumn(right),
      ],
    );
  }

  static const int _maxInlineNameLength = 12;

  Widget _buildGreeting(String greeting, String name) {
    if (name.length > _maxInlineNameLength) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$greeting,', style: AppTypography.dashboardHeadline),
          Text(name, style: AppTypography.dashboardHeadline),
        ],
      );
    }
    return Text('$greeting, $name', style: AppTypography.dashboardHeadline);
  }

  String _getGreeting(DateTime dateTime) {
    final hour = dateTime.hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}

class _SeeAllPill extends StatelessWidget {
  const _SeeAllPill({required this.onTap, this.label = 'See All'});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTypography.dashboardSeeAllPillText,
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
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

class _WeeklyAreaChart extends StatelessWidget {
  const _WeeklyAreaChart({required this.data});

  final List<_WeeklyProgressPoint> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.ratio * 100);
    }).toList();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 25,
          getDrawingHorizontalLine: (_) => FlLine(
            color: Colors.white.withValues(alpha: 0.06),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 25,
              reservedSize: 32,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}%',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= data.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    data[i].label,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots.map((s) {
              return LineTooltipItem(
                '${s.y.toInt()}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: AppTheme.primary,
            barWidth: 2.5,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                radius: 3,
                color: AppTheme.primary,
                strokeWidth: 0,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primary.withValues(alpha: 0.3),
                  AppTheme.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineCategoryGroup {
  const _RoutineCategoryGroup({
    required this.category,
    required this.icon,
    required this.color,
    required this.completedCount,
    required this.totalCount,
  });

  final String category;
  final IconData icon;
  final Color color;
  final int completedCount;
  final int totalCount;

  double get progress => totalCount == 0 ? 0 : completedCount / totalCount;
}

class _RoutineTile extends StatelessWidget {
  const _RoutineTile({required this.group});

  final _RoutineCategoryGroup group;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: group.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(group.icon, color: group.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.category,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${group.completedCount}/${group.totalCount} completed',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: group.progress,
                    minHeight: 4,
                    backgroundColor: AppTheme.surface,
                    color: group.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${(group.progress * 100).toInt()}%',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: group.color),
          ),
        ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final _TaskItem task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showContextMenu(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: task.priority.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    task.category,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppTheme.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    task.isCompleted
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.circle,
                    color: task.isCompleted
                        ? AppTheme.primary
                        : AppTheme.muted,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              task.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: task.isCompleted
                    ? AppTheme.muted
                    : AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _TaskContextMenu(
        onEdit: () {
          Navigator.pop(context);
          onEdit();
        },
        onDelete: () {
          Navigator.pop(context);
          onDelete();
        },
      ),
    );
  }
}

class _TaskContextMenu extends StatelessWidget {
  const _TaskContextMenu({
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.pencil, color: AppTheme.textPrimary),
            title: Text(
              'Edit',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppTheme.textPrimary),
            ),
            onTap: onEdit,
          ),
          const Divider(height: 1, color: AppTheme.divider),
          ListTile(
            leading: const Icon(CupertinoIcons.trash, color: Color(0xFFEF4444)),
            title: Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: const Color(0xFFEF4444)),
            ),
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

enum TaskPriority {
  high(Color(0xFFEF4444)),
  medium(Color(0xFFEAB308)),
  low(Color(0xFF22C55E));

  const TaskPriority(this.color);
  final Color color;
}

class _TaskItem {
  const _TaskItem({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String category;
  final TaskPriority priority;
  final bool isCompleted;

  _TaskItem copyWith({bool? isCompleted}) {
    return _TaskItem(
      id: id,
      title: title,
      category: category,
      priority: priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
