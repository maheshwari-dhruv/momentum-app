import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';
import 'add_new_category_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
    this.editTaskId,
    this.initialName,
    this.initialPriority,
    this.initialCategory,
  });

  final String? editTaskId;
  final String? initialName;
  final String? initialPriority;
  final String? initialCategory;

  bool get isEditing => editTaskId != null;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  static const List<_PriorityOption> _priorities = [
    _PriorityOption(label: 'Low', color: AppTheme.success),
    _PriorityOption(label: 'Medium', color: AppTheme.warning),
    _PriorityOption(label: 'High', color: AppTheme.danger),
  ];

  final List<String> _categories = <String>[
    'Personal',
    'Work',
    'Shopping',
    'Fitness',
    'Self-care',
  ];

  int _selectedPriorityIndex = 1;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _taskNameController.text = widget.initialName ?? '';
      if (widget.initialPriority != null) {
        final idx = _priorities.indexWhere(
          (p) => p.label.toLowerCase() == widget.initialPriority!.toLowerCase(),
        );
        if (idx != -1) _selectedPriorityIndex = idx;
      }
      if (widget.initialCategory != null) {
        final idx = _categories.indexWhere(
          (c) => c.toLowerCase() == widget.initialCategory!.toLowerCase(),
        );
        if (idx != -1) _selectedCategoryIndex = idx;
      }
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 20),
        child: Column(
          children: [
            // ── Header ──
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: AppTheme.white,
                    size: 22,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.isEditing ? 'Edit Task' : 'Add New Task',
                    textAlign: TextAlign.center,
                    style: AppTypography.profileScreenTitle,
                  ),
                ),
                const SizedBox(width: 22),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(color: AppTheme.divider, height: 1),

            const SizedBox(height: 24),

            // ── Form ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Name
                    Text('Task Name', style: AppTypography.addUserFieldLabel),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _taskNameController,
                      style: AppTypography.addUserTextFieldText,
                      cursorColor: AppTheme.primary,
                      decoration: InputDecoration(
                        hintText: 'e.g., Morning Run',
                        hintStyle: TextStyle(
                          color: AppTheme.muted.withValues(alpha: 0.75),
                        ),
                        filled: true,
                        fillColor: AppTheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.divider),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Priority
                    Text('Priority', style: AppTypography.addUserFieldLabel),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: Row(
                        children: List.generate(_priorities.length, (index) {
                          final isSelected = index == _selectedPriorityIndex;
                          final priority = _priorities[index];
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selectedPriorityIndex = index);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: priority.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      priority.label,
                                      style: AppTypography.taskFilterChip.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Category
                    Text('Category', style: AppTypography.addUserFieldLabel),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ...List.generate(_categories.length, (index) {
                          final isSelected = index == _selectedCategoryIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedCategoryIndex = index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primary.withValues(alpha: 0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.primary
                                      : AppTheme.divider,
                                ),
                              ),
                              child: Text(
                                _categories[index],
                                style: AppTypography.taskFilterChip.copyWith(
                                  color: isSelected
                                      ? AppTheme.primary
                                      : AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: _onAddNewCategoryPressed,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: const Icon(
                              CupertinoIcons.add,
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Save Button (pinned at bottom) ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onSavePressed,
                icon: Icon(
                  widget.isEditing
                      ? CupertinoIcons.checkmark_alt
                      : CupertinoIcons.add,
                ),
                iconAlignment: IconAlignment.end,
                label: Text(
                  widget.isEditing ? 'Save Changes' : 'Create Task',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 0,
                  textStyle: AppTypography.addUserSaveButtonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSavePressed() async {
    final isSaved = widget.isEditing
        ? await _updateTaskInDatabase()
        : await _saveTaskToDatabase();
    if (!mounted) return;
    if (isSaved) {
      Navigator.of(context).pop(true);
    }
  }

  /// Placeholder — replace with actual DB save logic.
  Future<bool> _saveTaskToDatabase() async {
    // TODO: Implement task save logic.
    debugPrint('AddTaskScreen: saving new task');
    debugPrint('  name: ${_taskNameController.text}');
    debugPrint('  priority: ${_priorities[_selectedPriorityIndex].label}');
    debugPrint('  category: ${_categories[_selectedCategoryIndex]}');
    return true;
  }

  /// Placeholder — replace with actual DB update logic.
  Future<bool> _updateTaskInDatabase() async {
    // TODO: Implement task update logic.
    debugPrint('AddTaskScreen: updating task ${widget.editTaskId}');
    debugPrint('  name: ${_taskNameController.text}');
    debugPrint('  priority: ${_priorities[_selectedPriorityIndex].label}');
    debugPrint('  category: ${_categories[_selectedCategoryIndex]}');
    return true;
  }

  void _onAddNewCategoryPressed() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AddNewCategoryScreen(),
      ),
    );
  }
}

/// Priority option with an associated color for backend use.
class _PriorityOption {
  const _PriorityOption({required this.label, required this.color});

  final String label;
  final Color color;
}
