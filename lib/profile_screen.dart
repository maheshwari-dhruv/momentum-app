import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020B1F),
        foregroundColor: Colors.white,
        title: const Text('Profile & Settings'),
      ),
      body: const Center(
        child: Text('Profile Screen', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
