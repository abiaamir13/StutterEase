import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const DashboardPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = user['username'];
    String email = user['email'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            // Add more widgets for dashboard content
          ],
        ),
      ),
    );
  }
}