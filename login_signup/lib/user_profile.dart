import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserProfilePage extends StatelessWidget {
  final String username;

  const UserProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png', height: 50), // Centered logo
        centerTitle: true, // Center the title (logo) in the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Username: ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      username,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Progress Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple), // Purple color for heading
              ),
              SizedBox(height: 8),
              Text(
                'Here is an overview of your progress in various exercises. Keep up the good work and continue practicing to improve your speech skills!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.8, // Adjusted aspect ratio
                children: [
                  ProgressIndicator(title: "Tongue Twisters", progress: 0.78, color: Colors.lightGreen.shade300),
                  ProgressIndicator(title: "Picture Description", progress: 0.25, color: Colors.red.shade300),
                  ProgressIndicator(title: "Everyday Sentences", progress: 0.65, color: Colors.lightBlue.shade200),
                  ProgressIndicator(title: "Storytelling", progress: 0.35, color: Colors.orange.shade300),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;

  const ProgressIndicator({Key? key, required this.title, required this.progress, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjusted font size and bold
        ),
        SizedBox(height: 8),
        Center(
          child: CircularPercentIndicator(
            radius: 60.0, // Adjusted radius
            lineWidth: 8.0, // Adjusted line width
            percent: progress,
            center: Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjusted font size and bold
            ),
            progressColor: color,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),
      ],
    );
  }
}
