import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_bottom_nav_bar.dart';
import '../../styles/app_theme.dart';

export 'app_bottom_nav_bar.dart';

class AppTabScaffold extends StatefulWidget {
  const AppTabScaffold({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
    required this.body,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTabSelected;
  final Widget body;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  State<AppTabScaffold> createState() => _AppTabScaffoldState();
}

class _AppTabScaffoldState extends State<AppTabScaffold> {
  bool _isAddMenuOpen = false;

  void _toggleAddMenu() {
    setState(() {
      _isAddMenuOpen = !_isAddMenuOpen;
    });
  }

  void _closeAddMenu() {
    if (!_isAddMenuOpen) return;
    setState(() {
      _isAddMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackground =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: Stack(
        children: [
          Positioned.fill(child: widget.body),
          if (_isAddMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeAddMenu,
                behavior: HitTestBehavior.opaque,
                child: const SizedBox.expand(),
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: _EdgeBlurOverlay(
                height: 50,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.background.withValues(alpha: 0.72),
                  AppTheme.background.withValues(alpha: 0.25),
                  AppTheme.background.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: _EdgeBlurOverlay(
                height: 90,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppTheme.background.withValues(alpha: 0.85),
                  AppTheme.background.withValues(alpha: 0.32),
                  AppTheme.background.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          if (_isAddMenuOpen)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: false,
                child: AddQuickMenu(onClose: _closeAddMenu),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppBottomNavBar(
              currentTab: widget.currentTab,
              onTabSelected: (tab) {
                _closeAddMenu();
                widget.onTabSelected(tab);
              },
              isAddMenuOpen: _isAddMenuOpen,
              onAddPressed: _toggleAddMenu,
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
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
