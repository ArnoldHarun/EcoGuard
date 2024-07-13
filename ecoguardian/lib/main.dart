import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/report_issue_page.dart';
import 'pages/learn_page.dart';
import 'pages/notifications_page.dart';
import 'pages/profile_page.dart';
import 'pages/emergency_contacts_page.dart';
import 'pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCu3hXDaqQ58VvHNQ1On5wxcgaU0CIXCo8",
      authDomain: "eco-guardian-bd74f.firebaseapp.com",
      projectId: "eco-guardian-bd74f",
      storageBucket: "eco-guardian-bd74f.appspot.com",
      messagingSenderId: "917905910857",
      appId: "1:917905910857:android:0493bc9f3e302c6d912398",
      measurementId: "G-MEASUREMENT_ID",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff0ACF83),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/report': (context) => const ReportIssuePage(),
        '/learn': (context) => const LearnPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/profile': (context) => const ProfilePage(),
        '/emergency_contacts': (context) => const EmergencyContactsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
