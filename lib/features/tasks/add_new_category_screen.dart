import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();

  final List<Color> _colorOptions = const [
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFFF43F5E),
    Color(0xFFA855F7),
    Color(0xFFF59E0B),
    Color(0xFF06B6D4),
  ];

  int _selectedColorIndex = 0;
  bool _isRoutineCategory = false;

  @override
  void dispose() {
    _categoryNameController.dispose();
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
                    'New Category',
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
                    // Category Name
                    Text('Category Name', style: AppTypography.addUserFieldLabel),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _categoryNameController,
                      style: AppTypography.addUserTextFieldText,
                      cursorColor: AppTheme.primary,
                      decoration: InputDecoration(
                        hintText: 'e.g., Study',
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

                    // Routine Category Toggle
                    Text(
                      'Routine Category',
                      style: AppTypography.addUserFieldLabel,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: Row(
                        children: [
                          _buildToggleOption(
                            label: 'Yes',
                            isSelected: _isRoutineCategory,
                            onTap: () =>
                                setState(() => _isRoutineCategory = true),
                          ),
                          _buildToggleOption(
                            label: 'No',
                            isSelected: !_isRoutineCategory,
                            onTap: () =>
                                setState(() => _isRoutineCategory = false),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Category Color
                    Text(
                      'Category Color',
                      style: AppTypography.addUserFieldLabel,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: List.generate(_colorOptions.length, (index) {
                        final isSelected = index == _selectedColorIndex;
                        final color = _colorOptions[index];
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedColorIndex = index),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.35),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // ── Save Button (pinned at bottom) ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSaveCategoryPressed,
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
                child: const Text('Save Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.taskFilterChip.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSaveCategoryPressed() async {
    final isSaved = await _saveCategoryToDatabase();
    if (!mounted) return;
    if (isSaved) Navigator.of(context).pop();
  }

  /// Placeholder — replace with actual DB save logic.
  Future<bool> _saveCategoryToDatabase() async {
    final selectedColor = _colorOptions[_selectedColorIndex];
    // TODO: Implement category save logic.
    debugPrint('AddNewCategoryScreen: saving category');
    debugPrint('  name: ${_categoryNameController.text}');
    debugPrint('  isRoutine: $_isRoutineCategory');
    debugPrint('  color: ${_colorToHex(selectedColor)}');
    return true;
  }

  String _colorToHex(Color color) {
    final value = color.toARGB32().toRadixString(16).padLeft(8, '0');
    return '#${value.substring(2).toUpperCase()}';
  }
}
