import 'package:flutter/material.dart';

import '../../styles/app_icons.dart';
import '../../styles/app_typography.dart';

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
    if (mounted) {
      setState(() {});
    }
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        color: const Color(0xFF111113),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _onCancelPressed,
                  behavior: HitTestBehavior.opaque,
                  child: AppIcons.addUserBackIcon,
                ),
                const SizedBox(height: 20),
                Text(
                  'Create \nyour profile',
                  style: AppTypography.addUserHeadline,
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
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Email address',
                          hint: 'your@email.com',
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
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
                            const SizedBox(width: 12),
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
                _ActionButton(
                  label: 'Save User',
                  onPressed: _onContinuePressed,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF78A2A),
                      Color(0xFFED7225),
                    ],
                  ),
                  textStyle: AppTypography.addUserPrimaryButtonText,
                  borderColor: Colors.white.withValues(alpha: 0.10),
                ),
                const SizedBox(height: 15),
                _ActionButton(
                  label: 'Cancel',
                  onPressed: _onCancelPressed,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2B2E33),
                      Color(0xFF17191D),
                    ],
                  ),
                  textStyle: AppTypography.addUserSecondaryButtonText,
                  borderColor: Colors.white.withValues(alpha: 0.10),
                ),
              ],
            ),
          ),
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
          style: AppTypography.addUserFieldLabel.copyWith(
            color: focusNode.hasFocus ? const Color(0xFFED7225) : Colors.white,
            fontWeight: focusNode.hasFocus ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: AppTypography.addUserTextFieldText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF202225),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFED7225),
                width: 1.5,
              ),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onPressed,
    required this.gradient,
    required this.textStyle,
    required this.borderColor,
  });

  final String label;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final TextStyle textStyle;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: textStyle.color,
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          child: Text(label, style: textStyle),
        ),
      ),
    );
  }
}
