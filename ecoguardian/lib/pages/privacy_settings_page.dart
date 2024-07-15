import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSettingTile(
              title: 'Data Privacy',
              icon: Icons.security,
              onTap: () {
                _showDataPrivacy(context);
              },
            ),
            const SizedBox(height: 16.0),
            _buildSettingTile(
              title: 'Manage Blocked Users',
              icon: Icons.block,
              onTap: () {
                _showBlockedUsers(context);
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

  void _showDataPrivacy(BuildContext context) {
    // Mock data privacy details for demonstration
    String userDataDetails = '''
    Data Privacy Details:
    - Name: John Doe
    - Email: johndoe@example.com
    - Address: 123 Main St, Anytown
    - Phone: +1234567890
    
    Your data is securely stored and not shared with anyone.
    ''';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Privacy Details'),
          content: Text(userDataDetails),
          actions: <Widget>[
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBlockedUsers(BuildContext context) {
    // Implement logic to show blocked users page or dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Manage Blocked Users tapped')),
    );
  }
}
