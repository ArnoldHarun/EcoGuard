import 'package:flutter/material.dart';

class NemaContactsPage extends StatelessWidget {
  const NemaContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEMA Contacts'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'National Environment Management Authority (NEMA)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Address: NEMA House, Plot 17/19/21, Jinja Road, Kampala, Uganda'),
            SizedBox(height: 8.0),
            Text('Phone: +256 414 251 064'),
            SizedBox(height: 8.0),
            Text('Email: info@nema.go.ug'),
            // Add more contact details as needed
          ],
        ),
      ),
    );
  }
}