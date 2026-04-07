import 'package:flutter/material.dart';

import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';
import '../../styles/app_icons.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    super.key,
    required this.onSaveSuccess,
    required this.onSaveFailed,
  });

  final VoidCallback onSaveSuccess;
  final VoidCallback onSaveFailed;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _weightFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(_onFieldFocusChanged);
    _emailFocusNode.addListener(_onFieldFocusChanged);
    _heightFocusNode.addListener(_onFieldFocusChanged);
    _weightFocusNode.addListener(_onFieldFocusChanged);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    super.dispose();
  }

  void _onFieldFocusChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _onContinuePressed() async {
    final saved = await _saveUserDetailsToDatabase();
    if (!mounted) return;
    if (saved) {
      widget.onSaveSuccess();
      return;
    }
    widget.onSaveFailed();
  }

  void _onCancelPressed() {
    Navigator.of(context).maybePop();
  }

  Future<bool> _saveUserDetailsToDatabase() async {
    // TODO: Implement actual DB save logic.
    debugPrint('Saving user details:');
    debugPrint('username: ${_usernameController.text}');
    debugPrint('email: ${_emailController.text}');
    debugPrint('height: ${_heightController.text}');
    debugPrint('weight: ${_weightController.text}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(28, topPadding + 20, 28, bottomPadding + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create \nYour Profile',
                  style: AppTypography.addUserHeadline,
                  textAlign: TextAlign.left,
                ),
                IconButton.filled(
                  onPressed: _onCancelPressed,
                  icon: AppIcons.addUserCloseIcon,
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.surface,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.all(10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: 'Name',
                      hint: 'Enter your name',
                      controller: _usernameController,
                      focusNode: _usernameFocusNode,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Email address',
                      hint: 'your@email.com',
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: 'Height (cm)',
                            hint: 'e.g. 175',
                            controller: _heightController,
                            focusNode: _heightFocusNode,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildInputField(
                            label: 'Weight (kg)',
                            hint: 'e.g. 70',
                            controller: _weightController,
                            focusNode: _weightFocusNode,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onContinuePressed,
                icon: AppIcons.addUserSaveIcon,
                iconAlignment: IconAlignment.end,
                label: const Text('Save User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
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

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.addUserFieldLabel,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: AppTypography.addUserTextFieldText,
          cursorColor: AppTheme.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppTheme.muted.withValues(alpha: 0.75)),
            filled: true,
            fillColor: AppTheme.surface,
            hoverColor: AppTheme.surface,
            focusColor: AppTheme.surface,
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
      ],
    );
  }
}
