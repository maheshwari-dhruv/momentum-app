import 'package:flutter/material.dart';

import '../../styles/app_icons.dart';
import '../../styles/app_typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
