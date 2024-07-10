import 'package:flutter/material.dart';

class EnvironmentAwarenessPage extends StatelessWidget {
  const EnvironmentAwarenessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environmental Awareness'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Environmental Awareness Activities',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildAwarenessCard(
                title: 'Tree Planting',
                description:
                    'Encourage planting trees to combat deforestation and increase green cover.',
              ),
              _buildAwarenessCard(
                title: 'Recycling Drives',
                description:
                    'Organize community recycling drives to reduce waste and promote recycling habits.',
              ),
              _buildAwarenessCard(
                title: 'Clean-Up Campaigns',
                description:
                    'Participate in or organize clean-up campaigns to keep local areas litter-free.',
              ),
              _buildAwarenessCard(
                title: 'Educational Workshops',
                description:
                    'Conduct workshops to educate people about environmental conservation.',
              ),
              _buildAwarenessCard(
                title: 'Energy Conservation',
                description:
                    'Promote energy-saving practices to reduce carbon footprints.',
              ),
              _buildAwarenessCard(
                title: 'Water Conservation',
                description:
                    'Raise awareness about water conservation techniques and practices.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwarenessCard({
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
    );
  }
}
