import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingItem(
              context,
              title: 'Change Username',
              onTap: () {
                // Handle username change
              },
            ),
            const SizedBox(height: 16.0),
            _buildSettingItem(
              context,
              title: 'Change Email',
              onTap: () {
                // Handle email change
              },
            ),
            const SizedBox(height: 16.0),
            _buildSettingItem(
              context,
              title: 'Change Password',
              onTap: () {
                // Handle password change
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
