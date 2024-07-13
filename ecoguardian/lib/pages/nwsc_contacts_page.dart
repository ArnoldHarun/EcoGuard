import 'package:flutter/material.dart';

class NwscContactsPage extends StatelessWidget {
  const NwscContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NWSC Contacts'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'National Water and Sewerage Corporation (NWSC)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Address: Plot 3 Nakasero Road, Kampala, Uganda'),
            SizedBox(height: 8.0),
            Text('Phone: +256 313 315 100'),
            SizedBox(height: 8.0),
            Text('Email: info@nwsc.co.ug'),
            // Add more contact details as needed
          ],
        ),
      ),
    );
  }
}