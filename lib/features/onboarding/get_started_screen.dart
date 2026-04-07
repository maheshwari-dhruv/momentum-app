import 'package:flutter/material.dart';

import '../../styles/app_icons.dart';
import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';
import '../dashboard/dashboard_screen.dart';
import 'add_user_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, topPadding + 40, 30, bottomPadding + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _MutedWord(text: 'Tasks'),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcons.getStartedWorkoutIcon,
                      const SizedBox(width: 10),
                      Text('Momentum', style: AppTypography.getStartedMainWord),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const _MutedWord(text: 'Routine'),
                  const SizedBox(height: 15),
                  const _MutedWord(text: 'Habits'),
                ],
              ),
            ),
            Text(
              'Your routines,\nupgraded',
              style: AppTypography.getStartedHeadline,
            ),
            const SizedBox(height: 15),
            Text(
              'Build better habits, stay consistent,\n& keep everything in one place.',
              style: AppTypography.getStartedBody,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openAddUserScreen(context),
                icon: AppIcons.getStartedCtaIcon,
                iconAlignment: IconAlignment.end,
                label: const Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 0,
                  textStyle: AppTypography.getStartedButtonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddUserScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AddUserScreen(
          onSaveSuccess: () => _navigateToDashboard(context),
          onSaveFailed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => const DashboardScreen(),
      ),
      (route) => false,
    );
  }
}

class _MutedWord extends StatelessWidget {
  const _MutedWord({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.getStartedMutedWord,
    );
  }
}
