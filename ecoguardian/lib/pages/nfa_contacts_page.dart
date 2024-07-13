import 'package:flutter/material.dart';

class NfaContactsPage extends StatelessWidget {
  const NfaContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFA Contacts'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'National Forestry Authority (NFA)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Address: Plot 10/20, Spring Road, Bugolobi, Kampala, Uganda'),
            SizedBox(height: 8.0),
            Text('Phone: +256 414 360 400'),
            SizedBox(height: 8.0),
            Text('Email: info@nfa.org.ug'),
            // Add more contact details as needed
          ],
        ),
      ),
    );
  }
}