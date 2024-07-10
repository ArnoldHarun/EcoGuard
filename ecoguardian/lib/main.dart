import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/report_issue_page.dart';
import 'pages/learn_page.dart';
import 'pages/notifications_page.dart';
import 'pages/profile_page.dart';
import 'pages/emergency_contacts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      },
    );
  }
}
