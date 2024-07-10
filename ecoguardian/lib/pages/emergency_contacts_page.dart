import 'package:flutter/material.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAuthorityCard(
              icon: Icons.business,
              title: 'NEMA (National Environment Management Authority)',
              description:
                  'NEMA is responsible for ensuring sustainable management of the environment and natural resources in Uganda.',
            ),
            const SizedBox(height: 16.0),
            _buildAuthorityCard(
              icon: Icons.waves,
              title: 'NWSC (National Water and Sewerage Corporation)',
              description:
                  'NWSC provides water and sewerage services in Uganda, ensuring access to clean water and sanitation.',
            ),
            const SizedBox(height: 16.0),
            _buildAuthorityCard(
              icon: Icons.local_florist,
              title: 'NFA (National Forestry Authority)',
              description:
                  'NFA is responsible for managing and conserving Uganda’s central forest reserves and wildlife.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorityCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40.0,
                  color: Colors.green,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
