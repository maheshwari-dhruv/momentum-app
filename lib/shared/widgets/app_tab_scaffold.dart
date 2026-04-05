import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_bottom_nav_bar.dart';

export 'app_bottom_nav_bar.dart';

class AppTabScaffold extends StatelessWidget {
  const AppTabScaffold({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
    required this.body,
    this.backgroundColor = Colors.transparent,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTabSelected;
  final Widget body;
  final Color backgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(child: body),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: _EdgeBlurOverlay(
                height: 50,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66111113),
                  Color(0x22111113),
                  Color(0x00111113),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: _EdgeBlurOverlay(
                height: 90,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0x88111113),
                  Color(0x33111113),
                  Color(0x00111113),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppBottomNavBar(
              currentTab: currentTab,
              onTabSelected: onTabSelected,
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

class _EdgeBlurOverlay extends StatelessWidget {
  const _EdgeBlurOverlay({
    required this.height,
    required this.begin,
    required this.end,
    required this.colors,
  });

  final double height;
  final Alignment begin;
  final Alignment end;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
            ),
          ),
        ),
      ),
    );
  }
}
