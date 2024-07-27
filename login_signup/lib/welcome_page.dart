import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _navigateToLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.pink.shade100, // Set background color to light pink
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // No shadow
          centerTitle: true,
          title: Image.asset(
            'images/logo.png', // Path to your logo
            height: 60, // Adjust the height as needed
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Ensure vertical scrolling
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 520, // Adjusted height to fit the image height
                      child: Image.asset(
                        'images/welcome.png', // Use the provided image
                        width: 480, // Original width of the image
                        height: 360, // Original height of the image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Let\'s start your stutter therapy today with us!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color changed to green
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: _navigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color of the button
                      foregroundColor: Colors.black, // Text color of the button
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
