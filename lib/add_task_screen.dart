import 'package:flutter/material.dart';

import 'add_new_category_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();

  final List<String> _priorities = const ['Low', 'Medium', 'High'];
  final List<String> _categories = <String>[
    'Personal',
    'Work',
    'Shopping',
    'Fitness',
  ];

  int _selectedPriorityIndex = 1;
  int _selectedCategoryIndex = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B14),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'Add New Task',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Container(height: 1, color: const Color(0xFF1B2433)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Task Name'),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _taskNameController,
                      hintText: 'e.g., Morning Run',
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Description'),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _taskDescriptionController,
                      hintText: 'Add details regarding this task...',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Priority'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF161E2B),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: List.generate(_priorities.length, (index) {
                          final isSelected = index == _selectedPriorityIndex;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedPriorityIndex = index;
                                });
                                debugPrint(
                                  'AddTaskScreen: selected priority -> ${_priorities[index]}',
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF2F80ED)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _priorities[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Date'),
                              const SizedBox(height: 10),
                              _SelectionField(
                                label: _formatDate(_selectedDate),
                                icon: Icons.calendar_today_outlined,
                                onTap: _pickDate,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Time'),
                              const SizedBox(height: 10),
                              _SelectionField(
                                label: _selectedTime.format(context),
                                icon: Icons.access_time_rounded,
                                onTap: _pickTime,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Category'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ...List.generate(_categories.length, (index) {
                          final isSelected = index == _selectedCategoryIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                              debugPrint(
                                'AddTaskScreen: selected category -> ${_categories[index]}',
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF122A57)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF2F80ED)
                                      : const Color(0xFF2B3445),
                                ),
                              ),
                              child: Text(
                                _categories[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF5EA2FF)
                                      : Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: _onAddNewCategoryPressed,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2B3445),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _onCreateTaskPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F80ED),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: const Icon(Icons.add_task_rounded),
                        label: const Text('Create Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Colors.white70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF161E2B),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked == null) return;
    setState(() {
      _selectedDate = picked;
    });
    debugPrint('AddTaskScreen: selected date -> ${_formatDate(_selectedDate)}');
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked == null) return;
    setState(() {
      _selectedTime = picked;
    });
    if (!mounted) return;
    debugPrint('AddTaskScreen: selected time -> ${_selectedTime.format(context)}');
  }

  Future<void> _onCreateTaskPressed() async {
    debugPrint('AddTaskScreen: create task button clicked');
    final isSaved = await _saveTaskToDatabase();
    if (!mounted) return;
    if (isSaved) {
      debugPrint('AddTaskScreen: task saved successfully, returning to task screen');
      Navigator.of(context).pop();
    }
  }

  Future<bool> _saveTaskToDatabase() async {
    // TODO: Implement task save logic.
    debugPrint('AddTaskScreen: saving task with values');
    debugPrint('taskName: ${_taskNameController.text}');
    debugPrint('description: ${_taskDescriptionController.text}');
    debugPrint('priority: ${_priorities[_selectedPriorityIndex]}');
    debugPrint('date: ${_formatDate(_selectedDate)}');
    if (mounted) {
      debugPrint('time: ${_selectedTime.format(context)}');
    }
    debugPrint('category: ${_categories[_selectedCategoryIndex]}');
    return true;
  }

  void _onAddNewCategoryPressed() {
    debugPrint('AddTaskScreen: add new category button clicked');
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AddNewCategoryScreen(),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    if (isToday) return 'Today';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF161E2B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Icon(icon, color: Colors.white54, size: 20),
          ],
        ),
      ),
    );
  }
}
