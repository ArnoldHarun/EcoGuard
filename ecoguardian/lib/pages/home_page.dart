import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFeatureCard(
              context,
              'Report an Issue',
              'Report environmental issues to authorities',
              Icons.report_problem_rounded,
              '/report',
              Colors.red,
            ),
            const SizedBox(height: 20.0),
            _buildFeatureCard(
              context,
              'Learn About Conservation',
              'Discover tips and practices for environmental conservation',
              Icons.eco_rounded,
              '/education',
              Colors.green,
            ),
            const SizedBox(height: 20.0),
            _buildFeatureCard(
              context,
              'Notifications',
              'Get updates and alerts on reported issues',
              Icons.notifications_rounded,
              '/notifications',
              Colors.blue,
            ),
            const SizedBox(height: 20.0),
            _buildFeatureCard(
              context,
              'My Profile',
              'View and manage your profile settings',
              Icons.person_rounded,
              '/profile',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, String subtitle,
      IconData iconData, String route, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 36.0,
                color: Colors.white,
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
