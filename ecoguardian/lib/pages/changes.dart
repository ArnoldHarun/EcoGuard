import 'package:flutter/material.dart';
import 'account_settings_page.dart';
import 'notification_settings_page.dart';
import 'privacy_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSettingTile(
              title: 'Notification Settings',
              icon: Icons.notifications,
              onTap: () {
                // Implement notification settings action
              },
            ),
            const SizedBox(height: 16.0),
            _buildSettingTile(
              title: 'Account Settings',
              icon: Icons.account_circle,
              onTap: () {
                // Implement account settings action
              },
            ),
            const SizedBox(height: 16.0),
            _buildSettingTile(
              title: 'Privacy Settings',
              icon: Icons.lock,
              onTap: () {
                // Implement privacy settings action
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.green,
              ),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

