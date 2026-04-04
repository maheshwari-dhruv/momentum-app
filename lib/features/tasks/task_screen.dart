import 'package:flutter/material.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_bottom_nav_bar.dart';
import 'add_task_screen.dart';

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

  late final List<_TaskItem> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _buildMockTasks();
  }

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final selectedFilter = _getSelectedFilter();
    final dailyCompletedTasks = _tasks
        .where(
          (task) => task.isCompleted && _isSameDate(task.dueDate, today),
        )
        .toList();
    final dailyTotalTaskCount = _tasks
        .where((task) => _isSameDate(task.dueDate, today))
        .length;
    final dailyCompletedTaskCount = dailyCompletedTasks.length;
    final dailyProgress = dailyTotalTaskCount == 0
        ? 0.0
        : dailyCompletedTaskCount / dailyTotalTaskCount;

    final allTodayTasks = _tasks
        .where(
          (task) =>
              !task.isCompleted && _isSameDate(task.dueDate, today),
        )
        .toList();
    final selectedFilterTasks = selectedFilter == null
        ? <_TaskItem>[]
        : allTodayTasks
              .where((task) => _matchesFilter(task, selectedFilter))
              .toList();
    final todayTasks = selectedFilter == null
        ? allTodayTasks
        : allTodayTasks
              .where((task) => !_matchesFilter(task, selectedFilter))
              .toList();
    final completedTasks = dailyCompletedTasks;

    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Focus on what matters',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1726),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF17243B)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$dailyCompletedTaskCount / $dailyTotalTaskCount tasks',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed today',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 54,
                            height: 54,
                            child: CircularProgressIndicator(
                              value: dailyProgress.clamp(0.0, 1.0),
                              strokeWidth: 6,
                              backgroundColor: const Color(0xFF1E293B),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF3B82F6),
                              ),
                            ),
                          ),
                          Text(
                            '${(dailyProgress.clamp(0.0, 1.0) * 100).round()}%',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedFilterIndex;
                    return GestureDetector(
                      onTap: () => _onFilterSelected(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF17243D),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF243554),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _filters[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemCount: _filters.length,
                ),
              ),
              const SizedBox(height: 24),
              if (selectedFilter != null && selectedFilterTasks.isNotEmpty) ...[
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
                ),
                const SizedBox(height: 18),
              ],
              _TaskSection(
                title: 'Todo Tasks',
                count: todayTasks.length,
                isExpanded: _todayExpanded,
                onToggle: () {
                  setState(() {
                    _todayExpanded = !_todayExpanded;
                  });
                },
                tasks: todayTasks,
              ),
              const SizedBox(height: 18),
              _TaskSection(
                title: 'Completed',
                count: completedTasks.length,
                isExpanded: _completedExpanded,
                onToggle: () {
                  setState(() {
                    _completedExpanded = !_completedExpanded;
                  });
                },
                tasks: completedTasks,
                showCompletedStyle: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTaskPressed,
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, size: 32),
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

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = _selectedFilterIndex == index ? null : index;
      _selectedFilterExpanded = true;
    });
  }

  String? _getSelectedFilter() {
    if (_selectedFilterIndex == null) {
      return null;
    }

    if (_selectedFilterIndex! < 0 || _selectedFilterIndex! >= _filters.length) {
      return null;
    }

    return _filters[_selectedFilterIndex!];
  }

  bool _matchesFilter(_TaskItem task, String filter) {
    return task.category.toLowerCase() == filter.toLowerCase();
  }

  void _onAddTaskPressed() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const AddTaskScreen()));
  }

  List<_TaskItem> _buildMockTasks() {
    final today = _dateOnly(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));

    return [
      _TaskItem(
        title: 'Prepare Q3 presentation',
        category: 'WORK',
        timeLabel: '2:00 PM',
        priority: 'HIGH',
        priorityColor: const Color(0xFFEF4444),
        dueDate: today,
      ),
      _TaskItem(
        title: 'Grocery shopping',
        category: 'PERSONAL',
        timeLabel: '6:30 PM',
        priority: 'MEDIUM',
        priorityColor: const Color(0xFFEAB308),
        dueDate: today,
      ),
      _TaskItem(
        title: 'Email Client',
        category: 'WORK',
        timeLabel: '8:00 PM',
        priority: 'MEDIUM',
        priorityColor: const Color(0xFFEAB308),
        dueDate: today,
      ),
      _TaskItem(
        title: 'Morning Stretch',
        category: 'FITNESS',
        timeLabel: '7:00 AM',
        priority: 'LOW',
        priorityColor: const Color(0xFF22C55E),
        dueDate: today,
        isCompleted: true,
      ),
      _TaskItem(
        title: 'Review design mockups',
        category: 'WORK',
        timeLabel: '9:00 AM',
        priority: 'LOW',
        priorityColor: const Color(0xFF22C55E),
        dueDate: tomorrow,
      ),
      _TaskItem(
        title: 'Water plants',
        category: 'PERSONAL',
        timeLabel: '10:00 AM',
        priority: 'LOW',
        priorityColor: const Color(0xFF22C55E),
        dueDate: tomorrow,
      ),
      _TaskItem(
        title: 'Book doctor appointment',
        category: 'PERSONAL',
        timeLabel: 'Yesterday',
        priority: 'MEDIUM',
        priorityColor: const Color(0xFFEAB308),
        dueDate: today.subtract(const Duration(days: 1)),
      ),
      _TaskItem(
        title: 'Complete weekly check-in',
        category: 'WORK',
        timeLabel: '2 days ago',
        priority: 'LOW',
        priorityColor: const Color(0xFF22C55E),
        dueDate: today.subtract(const Duration(days: 2)),
      ),
      _TaskItem(
        title: 'Plan weekend workout',
        category: 'FITNESS',
        timeLabel: '8:00 AM',
        priority: 'LOW',
        priorityColor: const Color(0xFF22C55E),
        dueDate: today.add(const Duration(days: 3)),
      ),
    ];
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}

class _TaskItem {
  const _TaskItem({
    required this.title,
    required this.category,
    required this.timeLabel,
    required this.priority,
    required this.priorityColor,
    required this.dueDate,
    this.isCompleted = false,
  });

  final String title;
  final String category;
  final String timeLabel;
  final String priority;
  final Color priorityColor;
  final DateTime dueDate;
  final bool isCompleted;
}

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.title,
    required this.count,
    required this.isExpanded,
    required this.onToggle,
    required this.tasks,
    this.showCompletedStyle = false,
  });

  final String title;
  final int count;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<_TaskItem> tasks;
  final bool showCompletedStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.chevron_right_rounded,
                color: Colors.white60,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white60,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF17243D),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
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
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white38),
              ),
            )
          else
            ...tasks.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TaskListCard(
                  task: task,
                  showCompletedStyle: showCompletedStyle,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _TaskListCard extends StatelessWidget {
  const _TaskListCard({
    required this.task,
    required this.showCompletedStyle,
  });

  final _TaskItem task;
  final bool showCompletedStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2740),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: showCompletedStyle
                    ? const Color(0xFF22C55E)
                    : Colors.white38,
                width: 2,
              ),
              color: showCompletedStyle
                  ? const Color(0xFF22C55E).withValues(alpha: 0.12)
                  : Colors.transparent,
            ),
            child: showCompletedStyle
                ? const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: Color(0xFF22C55E),
                  )
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: showCompletedStyle
                              ? Colors.white54
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: showCompletedStyle
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      task.priority,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: task.priorityColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF253556),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        task.category,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF7EA8FF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      task.timeLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
