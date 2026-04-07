import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_tab_scaffold.dart';
import '../../styles/app_icons.dart';
import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int? _selectedFilterIndex;
  bool? _selectedFilterExpanded = true;
  bool _todayExpanded = true;
  bool _completedExpanded = false;

  final List<String> _filters = const [
    'Work',
    'Personal',
    'Fitness',
    'Health',
    'Study',
    'Shopping',
  ];

  List<_TaskItem> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  /// Placeholder — replace with actual DB query to fetch all tasks.
  Future<void> _loadAllTasks() async {
    // TODO: Fetch from database.
    final tasks = await _fetchTasksFromDatabase();
    if (!mounted) return;
    setState(() => _tasks = tasks);
  }

  /// Placeholder — returns dummy tasks until DB is wired up.
  Future<List<_TaskItem>> _fetchTasksFromDatabase() async {
    final today = _dateOnly(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));

    return [
      _TaskItem(
        id: '1',
        title: 'Prepare Q3 presentation',
        category: 'WORK',
        timeLabel: '2:00 PM',
        priority: 'HIGH',
        priorityColor: AppTheme.danger,
        dueDate: today,
      ),
      _TaskItem(
        id: '2',
        title: 'Grocery shopping',
        category: 'PERSONAL',
        timeLabel: '6:30 PM',
        priority: 'MEDIUM',
        priorityColor: AppTheme.warning,
        dueDate: today,
      ),
      _TaskItem(
        id: '3',
        title: 'Email Client',
        category: 'WORK',
        timeLabel: '8:00 PM',
        priority: 'MEDIUM',
        priorityColor: AppTheme.warning,
        dueDate: today,
      ),
      _TaskItem(
        id: '4',
        title: 'Morning Stretch',
        category: 'FITNESS',
        timeLabel: '7:00 AM',
        priority: 'LOW',
        priorityColor: AppTheme.success,
        dueDate: today,
        isCompleted: true,
      ),
      _TaskItem(
        id: '5',
        title: 'Review design mockups',
        category: 'WORK',
        timeLabel: '9:00 AM',
        priority: 'LOW',
        priorityColor: AppTheme.success,
        dueDate: tomorrow,
      ),
      _TaskItem(
        id: '6',
        title: 'Water plants',
        category: 'PERSONAL',
        timeLabel: '10:00 AM',
        priority: 'LOW',
        priorityColor: AppTheme.success,
        dueDate: tomorrow,
      ),
      _TaskItem(
        id: '7',
        title: 'Book doctor appointment',
        category: 'PERSONAL',
        timeLabel: 'Yesterday',
        priority: 'MEDIUM',
        priorityColor: AppTheme.warning,
        dueDate: today.subtract(const Duration(days: 1)),
      ),
      _TaskItem(
        id: '8',
        title: 'Complete weekly check-in',
        category: 'WORK',
        timeLabel: '2 days ago',
        priority: 'LOW',
        priorityColor: AppTheme.success,
        dueDate: today.subtract(const Duration(days: 2)),
      ),
      _TaskItem(
        id: '9',
        title: 'Plan weekend workout',
        category: 'FITNESS',
        timeLabel: '8:00 AM',
        priority: 'LOW',
        priorityColor: AppTheme.success,
        dueDate: today.add(const Duration(days: 3)),
      ),
    ];
  }

  void _toggleTask(String id) {
    setState(() {
      final i = _tasks.indexWhere((t) => t.id == id);
      if (i == -1) return;
      _tasks[i] = _tasks[i].copyWith(isCompleted: !_tasks[i].isCompleted);
    });
    // TODO: Persist completion status in database.
  }

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final selectedFilter = _getSelectedFilter();

    final todayTasks = _tasks.where((t) => _isSameDate(t.dueDate, today)).toList();
    final dailyTotalTaskCount = todayTasks.length;
    final dailyCompletedTaskCount = todayTasks.where((t) => t.isCompleted).length;
    final dailyProgress = dailyTotalTaskCount == 0
        ? 0.0
        : dailyCompletedTaskCount / dailyTotalTaskCount;

    final pendingTasks = todayTasks.where((t) => !t.isCompleted).toList();
    final completedTasks = todayTasks.where((t) => t.isCompleted).toList();

    final selectedFilterTasks = selectedFilter == null
        ? <_TaskItem>[]
        : pendingTasks.where((t) => _matchesFilter(t, selectedFilter)).toList();
    final remainingTasks = selectedFilter == null
        ? pendingTasks
        : pendingTasks
              .where((t) => !_matchesFilter(t, selectedFilter))
              .toList();

    return AppTabScaffold(
      currentTab: AppTab.tasks,
      onTabSelected: (selected) {
        navigateFromTabSelection(
          context,
          currentTab: AppTab.tasks,
          selectedTab: selected,
        );
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, kBottomNavBarHeight + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Text('Task', style: AppTypography.dashboardHeadline),
            const SizedBox(height: 4),
            Text('Focus on what matters', style: AppTypography.dashboardSubtitle),

            const SizedBox(height: 20),

            // ── Progress Card ──
            _ProgressCard(
              completedCount: dailyCompletedTaskCount,
              totalCount: dailyTotalTaskCount,
              progress: dailyProgress,
            ),

            const SizedBox(height: 20),

            // ── Filter Chips ──
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final isSelected = index == _selectedFilterIndex;
                  return GestureDetector(
                    onTap: () => _onFilterSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primary : AppTheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppTheme.primary : AppTheme.divider,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[index],
                        style: AppTypography.taskFilterChip.copyWith(
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ── Selected Filter Section ──
            if (selectedFilter != null) ...[
              _TaskSection(
                title: selectedFilter,
                count: selectedFilterTasks.length,
                isExpanded: _selectedFilterExpanded ?? true,
                onToggle: () {
                  setState(() {
                    _selectedFilterExpanded = !(_selectedFilterExpanded ?? true);
                  });
                },
                tasks: selectedFilterTasks,
                onToggleTask: _toggleTask,
              ),
              const SizedBox(height: 18),
            ],

            // ── Todo Section ──
            _TaskSection(
              title: 'Todo Tasks',
              count: remainingTasks.length,
              isExpanded: _todayExpanded,
              onToggle: () => setState(() => _todayExpanded = !_todayExpanded),
              tasks: remainingTasks,
              onToggleTask: _toggleTask,
            ),

            const SizedBox(height: 18),

            // ── Completed Section ──
            _TaskSection(
              title: 'Completed',
              count: completedTasks.length,
              isExpanded: _completedExpanded,
              onToggle: () =>
                  setState(() => _completedExpanded = !_completedExpanded),
              tasks: completedTasks,
              showCompletedStyle: true,
              onToggleTask: _toggleTask,
            ),
          ],
        ),
      ),
    );
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = _selectedFilterIndex == index ? null : index;
      _selectedFilterExpanded = true;
    });
  }

  String? _getSelectedFilter() {
    if (_selectedFilterIndex == null ||
        _selectedFilterIndex! < 0 ||
        _selectedFilterIndex! >= _filters.length) {
      return null;
    }
    return _filters[_selectedFilterIndex!];
  }

  bool _matchesFilter(_TaskItem task, String filter) {
    return task.category.toLowerCase() == filter.toLowerCase();
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ── Progress Card ──

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.completedCount,
    required this.totalCount,
    required this.progress,
  });

  final int completedCount;
  final int totalCount;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$completedCount / $totalCount tasks',
                  style: AppTypography.taskProgressCount,
                ),
                const SizedBox(height: 6),
                Text('Completed today', style: AppTypography.taskProgressTitle),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 6,
                    backgroundColor: AppTheme.surface,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                  ),
                ),
                Text(
                  '${(progress.clamp(0.0, 1.0) * 100).round()}%',
                  style: AppTypography.taskProgressPercent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Task Section (collapsible) ──

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.title,
    required this.count,
    required this.isExpanded,
    required this.onToggle,
    required this.tasks,
    required this.onToggleTask,
    this.showCompletedStyle = false,
  });

  final String title;
  final int count;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<_TaskItem> tasks;
  final ValueChanged<String> onToggleTask;
  final bool showCompletedStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(
                isExpanded
                    ? CupertinoIcons.chevron_down
                    : CupertinoIcons.chevron_right,
                color: AppTheme.textSecondary,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(title, style: AppTypography.taskSectionHeader),
              const SizedBox(width: 8),
              const Expanded(
                child: Divider(color: AppTheme.divider, height: 1),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$count',
                  style: AppTypography.taskPriorityLabel.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 12),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No tasks available',
                style: AppTypography.dashboardEmptyState,
              ),
            )
          else
            _buildTaskGrid(),
        ],
      ],
    );
  }

  /// Two-column masonry layout matching the dashboard task cards.
  Widget _buildTaskGrid() {
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
                    showCompletedStyle: showCompletedStyle,
                    onToggle: () => onToggleTask(task.id),
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
}

// ── Individual Task Card (box style, matches dashboard) ──

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.showCompletedStyle,
    required this.onToggle,
  });

  final _TaskItem task;
  final bool showCompletedStyle;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isCompleted = showCompletedStyle || task.isCompleted;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.card,
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
                  color: task.priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.category,
                  style: AppTypography.dashboardTileSubtitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  isCompleted
                      ? AppIcons.checkCircleFilled
                      : AppIcons.circleOutline,
                  color: isCompleted ? AppTheme.primary : AppTheme.muted,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.dashboardTileTitle.copyWith(
              color: isCompleted ? AppTheme.muted : AppTheme.textPrimary,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data Model ──

class _TaskItem {
  _TaskItem({
    required this.id,
    required this.title,
    required this.category,
    required this.timeLabel,
    required this.priority,
    required this.priorityColor,
    required this.dueDate,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String category;
  final String timeLabel;
  final String priority;
  final Color priorityColor;
  final DateTime dueDate;
  bool isCompleted;

  _TaskItem copyWith({bool? isCompleted}) {
    return _TaskItem(
      id: id,
      title: title,
      category: category,
      timeLabel: timeLabel,
      priority: priority,
      priorityColor: priorityColor,
      dueDate: dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
