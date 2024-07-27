import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import the WelcomePage

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomePage();
  }

  _navigateToWelcomePage() async {
    await Future.delayed(const Duration(seconds: 3)); // Duration for the splash screen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/logo.png', // Path to your logo
          height: 100, // Adjust the height as needed
        ),
      ),
    );
  }
}

