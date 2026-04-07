import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../features/onboarding/home_screen.dart';
import '../styles/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Momentum - Task & Routine Planner',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
