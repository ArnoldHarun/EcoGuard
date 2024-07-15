import 'package:flutter/material.dart';

class DataPrivacyPage extends StatelessWidget {
  const DataPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Privacy'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('How We Collect Data'),
            _buildSectionContent(
                'We collect data that you provide directly to us, such as when you create an account, submit a report, or communicate with us. We may also collect data automatically through your use of the app, including device information and usage data.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('How We Use Data'),
            _buildSectionContent(
                'We use your data to provide and improve our services, communicate with you, and comply with legal obligations. Your data helps us enhance the app, respond to your inquiries, and ensure a safe environment.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Data Protection'),
            _buildSectionContent(
                'We implement various security measures to protect your data from unauthorized access, alteration, or disclosure. We use encryption, secure storage, and access controls to safeguard your information.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Your Rights'),
            _buildSectionContent(
                'You have the right to access, update, and delete your personal information. You can manage your data through the app settings or contact us for assistance.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16.0),
    );
  }
}
