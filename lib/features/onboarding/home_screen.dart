import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import 'user_setup_screen.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showGetStartedButton = false;

  @override
  void initState() {
    super.initState();
    _handleStartupFlow();
  }

  Future<void> _handleStartupFlow() async {
    final userExists = await _checkUserExistsInDatabase();

    if (!mounted) return;

    if (userExists) {
      setState(() {
        _showGetStartedButton = false;
      });

      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _navigateToDashboard();
      return;
    }

    setState(() {
      _showGetStartedButton = true;
    });
  }

  Future<bool> _checkUserExistsInDatabase() async {
    // TODO: Implement DB user existence check.
    // Temporary behavior: always show splash and enter the app.
    return false;
  }

  void _onGetStartedPressed() {
    _navigateToSaveUserDetails();
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const DashboardScreen(),
      ),
    );
  }

  void _navigateToSaveUserDetails() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => UserSetupScreen(
          onSaveSuccess: _navigateToDashboard,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      showGetStartedButton: _showGetStartedButton,
      onGetStarted: _onGetStartedPressed,
    );
  }
}
