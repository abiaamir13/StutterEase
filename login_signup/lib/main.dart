import 'package:flutter/material.dart';
import 'splash_page.dart'; // Import the SplashPage
import 'login.dart'; // Import the LoginPage
import 'signup.dart'; // Import the SignupPage
import 'menu_page.dart'; // Import the MenuPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StutterEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash', // Set initial route to SplashPage
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) =>  LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/menu': (context) => MenuPage(username: 'exampleUsername'),
      },
      onGenerateRoute: (settings) {
        // Handle unknown routes here
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


