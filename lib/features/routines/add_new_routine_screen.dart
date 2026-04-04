import 'package:flutter/material.dart';

import '../tasks/add_new_category_screen.dart';

class AddNewRoutineScreen extends StatefulWidget {
  const AddNewRoutineScreen({super.key});

  @override
  State<AddNewRoutineScreen> createState() => _AddNewRoutineScreenState();
}

class _AddNewRoutineScreenState extends State<AddNewRoutineScreen> {
  final TextEditingController _routineNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<String> _categories = <String>[
    'Personal',
    'Work',
    'Shopping',
    'Fitness',
  ];
  final List<_FrequencyDay> _frequencyDays = const [
    _FrequencyDay(label: 'M', fullLabel: 'Monday'),
    _FrequencyDay(label: 'T', fullLabel: 'Tuesday'),
    _FrequencyDay(label: 'W', fullLabel: 'Wednesday'),
    _FrequencyDay(label: 'T', fullLabel: 'Thursday'),
    _FrequencyDay(label: 'F', fullLabel: 'Friday'),
    _FrequencyDay(label: 'S', fullLabel: 'Saturday'),
    _FrequencyDay(label: 'S', fullLabel: 'Sunday'),
  ];

  final Set<int> _selectedFrequencyIndexes = <int>{};

  int _selectedCategoryIndex = 3;
  TimeOfDay _startTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void dispose() {
    _routineNameController.dispose();
    _notesController.dispose();
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
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'Add Routine',
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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Routine Name'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _routineNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'e.g., Morning Run',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF161E2B),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        suffixIcon: const Icon(
                          Icons.edit_rounded,
                          color: Colors.white54,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Frequency'),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161E2B),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_frequencyDays.length, (index) {
                          final isSelected = _selectedFrequencyIndexes.contains(index);
                          return GestureDetector(
                            onTap: () => _toggleFrequency(index),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? const Color(0xFF2F80ED)
                                    : Colors.transparent,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _frequencyDays[index].label,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Time Slot'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _RoutineTimeField(
                            title: 'Start',
                            value: _startTime.format(context),
                            onTap: _pickStartTime,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '—',
                          style: TextStyle(color: Colors.white38, fontSize: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _RoutineTimeField(
                            title: 'End',
                            value: _endTime.format(context),
                            onTap: _pickEndTime,
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
                                'AddNewRoutineScreen: selected category -> ${_categories[index]}',
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
                    const SizedBox(height: 24),
                    _buildLabel('Notes'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _notesController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add any specific details or reminders...',
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
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onCreateRoutinePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text('Create Routine'),
                  ),
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
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Colors.white60,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  void _toggleFrequency(int index) {
    setState(() {
      if (_selectedFrequencyIndexes.contains(index)) {
        _selectedFrequencyIndexes.remove(index);
      } else {
        _selectedFrequencyIndexes.add(index);
      }
    });
    debugPrint(
      'AddNewRoutineScreen: frequency -> ${_frequencyDays[index].fullLabel} ${_selectedFrequencyIndexes.contains(index) ? 'selected' : 'removed'}',
    );
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked == null) return;
    setState(() {
      _startTime = picked;
    });
    if (!mounted) return;
    debugPrint('AddNewRoutineScreen: start time -> ${_startTime.format(context)}');
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked == null) return;
    setState(() {
      _endTime = picked;
    });
    if (!mounted) return;
    debugPrint('AddNewRoutineScreen: end time -> ${_endTime.format(context)}');
  }

  Future<void> _onCreateRoutinePressed() async {
    debugPrint('AddNewRoutineScreen: create routine button clicked');
    final isSaved = await _saveRoutineToDatabase();
    if (!mounted) return;
    if (isSaved) {
      debugPrint(
        'AddNewRoutineScreen: routine saved successfully, returning to previous screen',
      );
      Navigator.of(context).pop();
    }
  }

  Future<bool> _saveRoutineToDatabase() async {
    // TODO: Implement routine save logic.
    debugPrint('AddNewRoutineScreen: saving routine with values');
    debugPrint('routineName: ${_routineNameController.text}');
    debugPrint('startTime: ${_startTime.format(context)}');
    debugPrint('endTime: ${_endTime.format(context)}');
    debugPrint('notes: ${_notesController.text}');
    debugPrint('category: ${_categories[_selectedCategoryIndex]}');
    final selectedDays = _selectedFrequencyIndexes
        .map((index) => _frequencyDays[index].fullLabel)
        .toList();
    debugPrint('frequencyDays: $selectedDays');
    return true;
  }

  void _onAddNewCategoryPressed() {
    debugPrint('AddNewRoutineScreen: add new category button clicked');
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AddNewCategoryScreen(),
      ),
    );
  }
}

class _RoutineTimeField extends StatelessWidget {
  const _RoutineTimeField({
    required this.title,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF161E2B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.access_time_rounded, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

class _FrequencyDay {
  const _FrequencyDay({required this.label, required this.fullLabel});

  final String label;
  final String fullLabel;
}
