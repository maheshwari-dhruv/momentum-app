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
      title: 'Momentum App',
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        final previewChild = DevicePreview.appBuilder(context, child);

        return Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppTheme.appBackgroundGradient,
              ),
            ),
            previewChild,
          ],
        );
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(title: 'Momentum App'),
    );
  }
}
