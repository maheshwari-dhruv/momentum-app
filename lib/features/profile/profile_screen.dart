import 'package:flutter/material.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_tab_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabScaffold(
      currentTab: AppTab.account,
      onTabSelected: (selected) {
        navigateFromTabSelection(
          context,
          currentTab: AppTab.account,
          selectedTab: selected,
        );
      },
      backgroundColor: const Color(0xFF020B1F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
          child: Column(
            children: [
              Text(
                'Account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 26),
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9C8A3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 52,
                  color: Color(0xFF5E4638),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Alex Doe',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 34),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DATA & ACCOUNT',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white54,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF111D36),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 14,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    _AccountOptionTile(
                      icon: Icons.description_outlined,
                      title: 'Progress Report',
                      subtitle: 'Download PDF',
                      trailingIcon: Icons.download_rounded,
                    ),
                    Divider(height: 1, color: Color(0xFF1B2A47)),
                    _AccountOptionTile(
                      icon: Icons.manage_accounts_outlined,
                      title: 'Account Details',
                      subtitle: 'View and update profile',
                      trailingIcon: Icons.chevron_right_rounded,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Log Out',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFF5B5B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'MOMENTUM V2.4.1 (BUILD 204)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white30,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountOptionTile extends StatelessWidget {
  const _AccountOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF17284A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF5EA2FF)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(trailingIcon, color: Colors.white38),
        ],
      ),
    );
  }
}
