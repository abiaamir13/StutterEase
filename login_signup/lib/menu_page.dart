import 'package:flutter/material.dart';
import 'stutter_speech.dart';
import 'user_profile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String initialUsername; // Declare a property to hold the initial username

  // Constructor to initialize the initialUsername property
  const MyApp({Key? key, this.initialUsername = 'Guest'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StutterEase',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuPage(username: initialUsername), // Pass initialUsername to MenuPage
    );
  }
}

class MenuPage extends StatelessWidget {
  final String username; // Add username as a property

  const MenuPage({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'images/logo.png',
            height: 60,
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: 60,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.mic),
                title: const Text('Stutter Speech'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StutterSpeechPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_3_rounded),
                title: Text('User Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfilePage(username: username),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.purple,
            child: Center(
              child: Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1, color: Colors.grey);
              },
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(category: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        'images/logo.png',
        height: 60,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExercisePage(category: category),
          ),
        );
      },
      child: Card(
        color: category.color.withOpacity(0.8),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                category.imagePath,
                height: 80,
              ),
              SizedBox(height: 10),
              Text(
                category.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                category.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExercisePage extends StatelessWidget {
  final Category category;

  ExercisePage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Difficulty Level:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EasyExercisePage(category: category)),
                          );
                        },
                        child: Text(
                          'Easy',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MediumExercisePage(category: category)),
                          );
                        },
                        child: Text(
                          'Medium',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HardExercisePage(category: category)),
                          );
                        },
                        child: Text(
                          'Hard',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class EasyExercisePage extends StatefulWidget {
  final Category category;

  EasyExercisePage({required this.category});

  @override
  _EasyExercisePageState createState() => _EasyExercisePageState();
}

class _EasyExercisePageState extends State<EasyExercisePage> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    String content;
    String imagePath = ''; // Default for easy level

    if (widget.category.title == 'Tongue Twisters') {
      content = 'Peter Piper picked a peck of pickled peppers.';
    } else if (widget.category.title == 'Storytelling') {
      content = 'Once upon a time, in a kingdom far away, there lived a brave knight named Sir Lancelot. He was known far and wide for his courage and noble deeds. One day, he received a message from the king, calling him to embark on a quest to retrieve the legendary Sword of Destiny.';
    } else if (widget.category.title == 'Everyday Sentences') {
      content = 'Sentence: "I like pizza."\nTip: Practice with gentle onset and relaxed breathing. Focus on speaking each word clearly and at a comfortable pace.';
    } else if (widget.category.title == 'Pic Description') {
      content = '';
      imagePath = 'images/picture1.jpeg'; // Set appropriate image for easy level
    } else {
      content = 'Easy exercises content goes here for ${widget.category.title}.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          height: 60,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/medium_background.jpg', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Practice with this easy exercise:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  if (imagePath.isNotEmpty)
                    Image.asset(
                      imagePath,
                      height: 150,
                    ),
                  SizedBox(height: 20),
                  if (!isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = true;
                        });
                      },
                      child: Text(
                        'Start Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[50],
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  if (isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = false;
                        });
                      },
                      child: Text(
                        'Stop Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(200, 50),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MediumExercisePage extends StatefulWidget {
  final Category category;

  MediumExercisePage({required this.category});

  @override
  _MediumExercisePageState createState() => _MediumExercisePageState();
}

class _MediumExercisePageState extends State<MediumExercisePage> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    String content;
    String imagePath = ''; // Default for medium level

    if (widget.category.title == 'Tongue Twisters') {
      content = 'She sells seashells by the seashore.';
    } else if (widget.category.title == 'Storytelling') {
      content = 'As the city woke up to another bustling morning, commuters hurried through crowded streets, their footsteps echoing against the tall buildings. Cars honked impatiently in the background, weaving through traffic with precision. Amidst the hustle and bustle, street vendors set up their stalls, filling the air with the aroma of sizzling street food. A distant siren wailed, a reminder of the city\'s constant motion and the diverse tapestry of lives intertwining in its streets.';
    } else if (widget.category.title == 'Everyday Sentences') {
      content = 'Sentence: "Where is the nearest grocery store?"\nTip: Use slow and deliberate speech. Focus on breathing and speaking each word clearly.';
    } else if (widget.category.title == 'Pic Description') {
      content = '';
      imagePath = 'images/picture2.jpeg'; // Set appropriate image for medium level
    } else {
      content = 'Medium exercises content goes here for ${widget.category.title}.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          height: 60,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/medium_background.jpg', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Practice with this medium exercise:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  if (imagePath.isNotEmpty)
                    Image.asset(
                      imagePath,
                      height: 150,
                    ),
                  SizedBox(height: 20),
                  if (!isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = true;
                        });
                      },
                      child: Text(
                        'Start Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[50],
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  if (isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = false;
                        });
                      },
                      child: Text(
                        'Stop Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(200, 50),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class HardExercisePage extends StatefulWidget {
  final Category category;

  HardExercisePage({required this.category});

  @override
  _HardExercisePageState createState() => _HardExercisePageState();
}

class _HardExercisePageState extends State<HardExercisePage> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    String content;
    String imagePath = ''; // Default for hard level

    if (widget.category.title == 'Tongue Twisters') {
      content = 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?';
    } else if (widget.category.title == 'Storytelling') {
      content = 'The scientist stood before the colossal telescope, its lenses gleaming under the starlit sky. Millions of light-years away, a supernova exploded in a spectacular display of cosmic fireworks, its brilliance captured in fleeting moments of astronomical history. She meticulously recorded data, each pulse of light revealing secrets of the universe\'s birth and evolution. Hours passed like seconds as she immersed herself in the dance of celestial bodies, unraveling mysteries that had baffled humanity for centuries.';
    } else if (widget.category.title == 'Everyday Sentences') {
      content = 'Sentence: "What time does the movie start?"\nTip: Practice with emphasis on specific sounds or words that are challenging for you. Use gentle onset and relaxed breathing.';
    } else if (widget.category.title == 'Pic Description') {
      content = '';
      imagePath = 'images/picture3.png'; // Set appropriate image for hard level
    } else {
      content = 'Hard exercises content goes here for ${widget.category.title}.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          height: 60,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/medium_background.jpg', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Practice with this hard exercise:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  if (imagePath.isNotEmpty)
                    Image.asset(
                      imagePath,
                      height: 150,
                    ),
                  SizedBox(height: 20),
                  if (!isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = true;
                        });
                      },
                      child: Text(
                        'Start Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[50],
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  if (isRecording)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRecording = false;
                        });
                      },
                      child: Text(
                        'Stop Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(200, 50),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Category {
  final String title;
  final String description;
  final Color color;
  final String imagePath;

  Category({
    required this.title,
    required this.description,
    required this.color,
    required this.imagePath,
  });
}

// Example categories data
List<Category> categories = [
  Category(
    title: 'Tongue Twisters',
    description: 'Improve speech clarity and tongue coordination with fun phrases.',
    imagePath: 'images/tongue_twisters.png',
    color: Colors.green.withOpacity(0.6), // Adjusted color with opacity
  ),
  Category(
    title: 'Pic Description',
    description: 'Describe images to improve articulation and descriptive speech.',
    imagePath: 'images/pic_description.png',
    color: Colors.orange.withOpacity(0.6), // Adjusted color with opacity
  ),
  Category(
    title: 'Everyday Sentences',
    description: 'Practice common phrases and sentences for fluent everyday speech..',
    imagePath: 'images/everyday_sentences.png',
    color: Colors.pink.withOpacity(0.6), // Adjusted color with opacity
  ),
  Category(
    title: 'Storytelling',
    description: 'Improve narrative skills and fluency through storytelling exercises.',
    imagePath:'images/storytelling.png',
    color: Colors.red.withOpacity(0.6), // Adjusted color with opacity
  ),
];

