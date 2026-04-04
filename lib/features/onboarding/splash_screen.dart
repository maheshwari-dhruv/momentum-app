import 'package:flutter/material.dart';

import '../../styles/app_icons.dart';
import '../../styles/app_typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.splashTextIcon,
              const SizedBox(width: 5),
              Text(
                'Momentum',
                style: AppTypography.splashTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
