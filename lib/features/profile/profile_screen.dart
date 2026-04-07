import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/app_theme.dart';
import '../../styles/app_typography.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _avatarBg = Color(0xFFFFD178);

  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  /// Placeholder — replace with actual DB query.
  Future<void> _loadUsername() async {
    // TODO: Fetch from database.
    final name = await _fetchUsernameFromDatabase();
    if (!mounted) return;
    setState(() => _username = name);
  }

  /// Placeholder — returns dummy username until DB is wired up.
  Future<String> _fetchUsernameFromDatabase() async {
    return 'Alex Doe';
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, topPadding + 20, 20, 20),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: AppTheme.white,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Account',
                    textAlign: TextAlign.center,
                    style: AppTypography.profileScreenTitle,
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 28),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: _avatarBg,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.white.withValues(alpha: 0.16),
                  width: 1.6,
                ),
              ),
              alignment: Alignment.center,
              child: const Text('🐯', style: TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 14),
            Text(
              _username.isEmpty ? '...' : _username,
              style: AppTypography.profileUsername,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Data & Account',
                style: AppTypography.profileSectionLabel,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  _AccountOptionTile(
                    icon: CupertinoIcons.doc_text,
                    title: 'Progress Report',
                    subtitle: 'Download PDF',
                    trailingIcon: CupertinoIcons.arrow_down_to_line,
                  ),
                  Divider(height: 1, color: AppTheme.divider),
                  _AccountOptionTile(
                    icon: CupertinoIcons.person_2,
                    title: 'Account Details',
                    subtitle: 'View and update profile',
                    trailingIcon: CupertinoIcons.chevron_right,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'MOMENTUM V0.0.1 (BUILD 001)',
              textAlign: TextAlign.center,
              style: AppTypography.profileVersionLabel,
            ),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.profileTileTitle),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.profileTileSubtitle),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(trailingIcon, color: AppTheme.muted, size: 20),
        ],
      ),
    );
  }
}
