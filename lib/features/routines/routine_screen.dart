import 'package:flutter/material.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_bottom_nav_bar.dart';
import 'add_new_routine_screen.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  int? _selectedRoutineIndex;
  DateTime _selectedCalendarDate = DateTime.now();
  bool? _selectedFilterExpanded = true;
  bool? _routinesExpanded = true;
  bool? _completedExpanded = false;

  @override
  Widget build(BuildContext context) {
    final routineItems = _getMockRoutineItems(_selectedCalendarDate);
    final weekDays = _buildWeekDays(_selectedCalendarDate);
    final routineTabs = _getRoutineCategoryTabs();
    final streakCount = _calculateCurrentStreak();
    final completedRoutineCount = _getCompletedRoutineCount(routineItems);
    final totalRoutineCount = _getTotalRoutineCount(routineItems);
    final routineProgress = totalRoutineCount == 0
        ? 0.0
        : completedRoutineCount / totalRoutineCount;
    final selectedCategory = _getSelectedRoutineCategory(routineTabs);
    final filteredRoutineItems = _getFilteredRoutineItems(
      selectedCategory,
      routineItems,
    );
    final filteredActiveRoutineItems = filteredRoutineItems
        .where((item) => !item.isCompleted)
        .toList();
    final remainingRoutineItems = _getRemainingRoutineItems(
      selectedCategory,
      routineItems,
    );
    final activeRoutineItems = remainingRoutineItems
        .where((item) => !item.isCompleted)
        .toList();
    final completedRoutineItems = routineItems
        .where((item) => item.isCompleted)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
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
                          'Routine',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _resetToToday,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF7EA8FF),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: const Text('Today'),
                  ),
                  IconButton(
                    onPressed: _openCalendar,
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 74,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const gap = 8.0;
                    final itemWidth = (constraints.maxWidth - (gap * 6)) / 7;

                    return Row(
                      children: weekDays.asMap().entries.map((entry) {
                        final index = entry.key;
                        final day = entry.value;
                        final isSelected = _isSameDate(
                          day.fullDate,
                          _selectedCalendarDate,
                        );

                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == weekDays.length - 1 ? 0 : gap,
                          ),
                          child: SizedBox(
                            width: itemWidth,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCalendarDate = day.fullDate;
                                });
                                debugPrint(
                                  'RoutineScreen: selected week-strip date -> ${day.fullDate}',
                                );
                                _showRoutinesForSelectedDate(day.fullDate);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFF0F1726),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF4D94FF)
                                        : const Color(0xFF17243B),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      day.label,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white70
                                            : Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${day.fullDate.day}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1726),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF17243B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT STREAK',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: const Color(0xFF5EA2FF),
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.6,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Keep it UP!',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Text('🔥', style: TextStyle(fontSize: 22)),
                            const SizedBox(width: 8),
                            Text(
                              '$streakCount',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      '$completedRoutineCount / $totalRoutineCount routines completed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: routineProgress.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: const Color(0xFF1E293B),
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 46,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedRoutineIndex;
                    return GestureDetector(
                      onTap: () {
                        final nextSelectedIndex = isSelected ? null : index;
                        setState(() {
                          _selectedRoutineIndex = nextSelectedIndex;
                          _selectedFilterExpanded = true;
                        });
                        debugPrint(
                          nextSelectedIndex == null
                              ? 'RoutineScreen: cleared routine category filter'
                              : 'RoutineScreen: selected routine category -> ${routineTabs[index]}',
                        );
                        _showRoutinesForSelectedDate(_selectedCalendarDate);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF121A29),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4D94FF)
                                : const Color(0xFF1A2435),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          routineTabs[index],
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
                  itemCount: routineTabs.length,
                ),
              ),
              const SizedBox(height: 24),
              if (selectedCategory != null) ...[
                _RoutineListSection(
                  title: selectedCategory,
                  count: filteredActiveRoutineItems.length,
                  isExpanded: _selectedFilterExpanded ?? true,
                  onToggle: () {
                    setState(() {
                      _selectedFilterExpanded = !(_selectedFilterExpanded ?? true);
                    });
                  },
                  items: filteredActiveRoutineItems,
                ),
                const SizedBox(height: 18),
              ],
              _RoutineListSection(
                title: 'Routines',
                count: activeRoutineItems.length,
                isExpanded: _routinesExpanded ?? true,
                onToggle: () {
                  setState(() {
                    _routinesExpanded = !(_routinesExpanded ?? true);
                  });
                },
                items: activeRoutineItems,
              ),
              const SizedBox(height: 18),
              _RoutineListSection(
                title: 'Completed',
                count: completedRoutineItems.length,
                isExpanded: _completedExpanded ?? false,
                onToggle: () {
                  setState(() {
                    _completedExpanded = !(_completedExpanded ?? false);
                  });
                },
                items: completedRoutineItems,
                showCompletedStyle: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddRoutinePressed,
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, size: 32),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.routines,
        onTabSelected: (selected) {
          navigateFromTabSelection(
            context,
            currentTab: AppTab.routines,
            selectedTab: selected,
          );
        },
      ),
    );
  }

  Future<void> _openCalendar() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedCalendarDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedCalendarDate = pickedDate;
    });

    debugPrint('RoutineScreen: selected calendar date -> $pickedDate');
    _showRoutinesForSelectedDate(pickedDate);
  }

  void _showRoutinesForSelectedDate(DateTime selectedDate) {
    // TODO: Load and show routines for the selected past or future date.
    final selectedCategory = _getSelectedRoutineCategory(_getRoutineCategoryTabs());
    debugPrint(
      'RoutineScreen: loading routines for selected date -> $selectedDate, category -> ${selectedCategory ?? 'all'}',
    );
  }

  void _resetToToday() {
    final today = _dateOnly(DateTime.now());
    setState(() {
      _selectedCalendarDate = today;
    });
    debugPrint('RoutineScreen: reset to today -> $today');
    _showRoutinesForSelectedDate(today);
  }

  int _calculateCurrentStreak() {
    // TODO: Calculate current streak from saved routine completion history.
    return 12;
  }

  void _onAddRoutinePressed() {
    debugPrint('RoutineScreen: add new routine tapped');
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AddNewRoutineScreen(),
      ),
    );
  }

  int _getCompletedRoutineCount(List<_RoutineItem> routineItems) {
    // TODO: Calculate completed routine count for the selected date.
    return routineItems.where((item) => item.isCompleted).length;
  }

  int _getTotalRoutineCount(List<_RoutineItem> routineItems) {
    // TODO: Calculate total routine count for the selected date.
    return routineItems.length;
  }

  List<String> _getRoutineCategoryTabs() {
    // TODO: Load routine-enabled categories from database.
    const allCategories = <_CategoryOption>[
      _CategoryOption(name: 'Skincare', isRoutineCategory: true),
      _CategoryOption(name: 'Diet', isRoutineCategory: true),
      _CategoryOption(name: 'Workout', isRoutineCategory: true),
      _CategoryOption(name: 'Meditation', isRoutineCategory: true),
      _CategoryOption(name: 'Work', isRoutineCategory: false),
      _CategoryOption(name: 'Shopping', isRoutineCategory: false),
    ];

    return allCategories
        .where((category) => category.isRoutineCategory)
        .map((category) => category.name)
        .toList();
  }

  String? _getSelectedRoutineCategory(List<String> routineTabs) {
    if (_selectedRoutineIndex == null) {
      return null;
    }

    if (_selectedRoutineIndex! < 0 || _selectedRoutineIndex! >= routineTabs.length) {
      return null;
    }

    return routineTabs[_selectedRoutineIndex!];
  }

  List<_RoutineItem> _getFilteredRoutineItems(
    String? selectedCategory,
    List<_RoutineItem> routineItems,
  ) {
    if (selectedCategory == null) {
      return routineItems;
    }

    return routineItems
        .where((item) => item.category == selectedCategory)
        .toList();
  }

  List<_RoutineItem> _getRemainingRoutineItems(
    String? selectedCategory,
    List<_RoutineItem> routineItems,
  ) {
    if (selectedCategory == null) {
      return routineItems;
    }

    return routineItems
        .where((item) => item.category != selectedCategory)
        .toList();
  }

  List<_RoutineItem> _getMockRoutineItems(DateTime selectedDate) {
    final isToday = _isSameDate(_dateOnly(selectedDate), _dateOnly(DateTime.now()));

    return [
      _RoutineItem(
        title: 'Deep Cleanser',
        timeRange: '07:00 - 07:05',
        category: 'Skincare',
        icon: Icons.water_drop_rounded,
        iconColor: Color(0xFF22C55E),
        isCompleted: isToday,
      ),
      _RoutineItem(
        title: 'Hydrating Toner',
        timeRange: '07:05 - 07:10',
        category: 'Skincare',
        icon: Icons.opacity_rounded,
        iconColor: Color(0xFF34D399),
        isCompleted: isToday,
      ),
      _RoutineItem(
        title: 'Vitamin C Serum',
        timeRange: '07:10 - 07:20',
        category: 'Skincare',
        currentTag: 'Current',
        icon: Icons.science_rounded,
        iconColor: Color(0xFF60A5FA),
        isCurrent: isToday,
      ),
      _RoutineItem(
        title: 'Moisturizer & SPF',
        timeRange: '07:20 - 07:25',
        category: 'Skincare',
        icon: Icons.spa_outlined,
        iconColor: Color(0xFF6B7280),
      ),
      _RoutineItem(
        title: 'Protein Breakfast',
        timeRange: '08:00 - 08:20',
        category: 'Diet',
        icon: Icons.restaurant_rounded,
        iconColor: Color(0xFF4ADE80),
      ),
      _RoutineItem(
        title: 'Strength Training',
        timeRange: '06:00 - 06:45',
        category: 'Workout',
        icon: Icons.fitness_center_rounded,
        iconColor: Color(0xFF60A5FA),
      ),
      _RoutineItem(
        title: 'Breathing Session',
        timeRange: '09:00 - 09:10',
        category: 'Meditation',
        icon: Icons.self_improvement_rounded,
        iconColor: Color(0xFFA78BFA),
      ),
    ];
  }

  List<_RoutineDay> _buildWeekDays(DateTime referenceDate) {
    final weekStart = _startOfWeek(referenceDate);

    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      return _RoutineDay(
        label: _weekdayLabel(date.weekday),
        fullDate: date,
      );
    });
  }

  DateTime _startOfWeek(DateTime referenceDate) {
    final baseDate = _dateOnly(referenceDate);
    return baseDate.subtract(Duration(days: baseDate.weekday - 1));
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}

class _RoutineDay {
  const _RoutineDay({required this.label, required this.fullDate});

  final String label;
  final DateTime fullDate;
}

class _CategoryOption {
  const _CategoryOption({
    required this.name,
    required this.isRoutineCategory,
  });

  final String name;
  final bool isRoutineCategory;
}

class _RoutineItem {
  const _RoutineItem({
    required this.title,
    required this.timeRange,
    required this.category,
    required this.icon,
    required this.iconColor,
    this.currentTag,
    this.isCurrent = false,
    this.isCompleted = false,
  });

  final String title;
  final String timeRange;
  final String category;
  final IconData icon;
  final Color iconColor;
  final String? currentTag;
  final bool isCurrent;
  final bool isCompleted;
}

class _RoutineListSection extends StatelessWidget {
  const _RoutineListSection({
    required this.title,
    required this.count,
    required this.isExpanded,
    required this.onToggle,
    required this.items,
    this.showCompletedStyle = false,
  });

  final String title;
  final int count;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<_RoutineItem> items;
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
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No routines available',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white38),
              ),
            )
          else
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _RoutineListCard(
                  item: item,
                  showCompletedStyle: showCompletedStyle,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _RoutineListCard extends StatelessWidget {
  const _RoutineListCard({
    required this.item,
    required this.showCompletedStyle,
  });

  final _RoutineItem item;
  final bool showCompletedStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2740),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: item.isCurrent ? const Color(0xFF2D4D82) : Colors.transparent,
        ),
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
                    : item.isCurrent
                    ? const Color(0xFF3B82F6)
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
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: showCompletedStyle ? Colors.white54 : Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: showCompletedStyle
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item.timeRange,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: showCompletedStyle ? Colors.white38 : Colors.white60,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.currentTag != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        item.currentTag!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF7EA8FF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
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
                    item.category,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF7EA8FF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: showCompletedStyle
                  ? const Color(0xFF10B981)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: showCompletedStyle
                    ? const Color(0xFF10B981)
                    : item.isCurrent
                    ? const Color(0xFF3B82F6)
                    : Colors.white24,
                width: 2,
              ),
            ),
            child: showCompletedStyle
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                : null,
          ),
        ],
      ),
    );
  }
}
