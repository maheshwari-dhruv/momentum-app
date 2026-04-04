import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import 'get_started_screen.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const bool _holdOnSplashScreenForUiUpdate = false;

  @override
  void initState() {
    super.initState();
    _handleStartupFlow();
  }

  Future<void> _handleStartupFlow() async {
    if (_holdOnSplashScreenForUiUpdate) {
      debugPrint(
        'HomeScreen: temporary splash hold enabled for UI updates.',
      );
      return;
    }

    final userExists = await _checkUserExistsInDatabase();
    if (!mounted) return;

    if (userExists) {
      _navigateToDashboard();
      return;
    }

    _navigateToGetStarted();
  }

  Future<bool> _checkUserExistsInDatabase() async {
    // TODO: Implement DB user existence check.
    // Temporary behavior: always continue to get started.
    return false;
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const DashboardScreen(),
      ),
    );
  }

  void _navigateToGetStarted() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const GetStartedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
