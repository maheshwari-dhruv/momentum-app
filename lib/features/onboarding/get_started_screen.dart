import 'package:flutter/material.dart';

import '../../styles/app_icons.dart';
import '../../styles/app_typography.dart';
import '../dashboard/dashboard_screen.dart';
import 'add_user_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MutedWord(text: 'Tasks'),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcons.getStartedWorkoutIcon,
                          const SizedBox(width: 10),
                          Text(
                            'Workout',
                            style: AppTypography.getStartedMainWord
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const _MutedWord(text: 'Routine'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your routines,\nupgraded',
                      style: AppTypography.getStartedHeadline,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Build better habits, stay consistent, and keep everything in one place.',
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
                          backgroundColor: Colors.white.withValues(alpha: 0.095),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                          elevation: 0,
                          textStyle: AppTypography.getStartedButtonText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
