import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'feedback.dart'; // Import the FeedbackPage

class StutterSpeechPage extends StatefulWidget {
  const StutterSpeechPage({Key? key}) : super(key: key);

  @override
  _StutterSpeechPageState createState() => _StutterSpeechPageState();
}

class _StutterSpeechPageState extends State<StutterSpeechPage> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;
  String? _resultText;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _initSound();
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _recorder = null;
    _player?.closePlayer();
    _player = null;
    super.dispose();
  }

  Future<void> _initSound() async {
    await _recorder?.openRecorder();
    await _player?.openPlayer();
  }

  Future<void> _startRecording() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print('Microphone permission not granted');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    _filePath = '${directory.path}/recording.wav';
    await _recorder?.startRecorder(
      toFile: _filePath,
      codec: Codec.pcm16WAV,
    );
    setState(() {
      _isRecording = true;
      _resultText = 'Recording...';
    });
  }

  Future<void> _stopRecording() async {
    await _recorder?.stopRecorder();
    setState(() {
      _isRecording = false;
      _resultText = 'Recording saved at: $_filePath';
    });
    await _startPlayback();
  }

  Future<void> _startPlayback() async {
    if (_filePath != null && !_isPlaying) {
      await _player?.startPlayer(
        fromURI: _filePath!,
        codec: Codec.pcm16WAV,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
            _resultText = 'Playback finished';
          });
        },
      );
      setState(() {
        _isPlaying = true;
        _resultText = 'Playing...';
      });
    }
  }

  void _navigateToFeedback() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedbackPage(
          speechScore: 75, // Example score, replace with actual score if needed
          tips: 'Here are some tips to improve your speech.\n'
              '1. Focus on slow and deliberate speech.\n'
              '2. Implement strategic pauses to make speaking more manageable.\n'
              '3. Speak slowly and deliberately, focusing on clearly enunciating each word.\n'
              '4. Use relaxation techniques to reduce overall stress and tension.\n'
              '5. Practice mindful speaking by being aware of your speech patterns.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset(
          'images/logo.png',
          height: 50,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset(
                'images/microphone.png',
                height: 150,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                label: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isRecording || _isPlaying ? null : _startPlayback,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Recording'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              if (_filePath != null)
                Text(
                  'Recording saved at: $_filePath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white, // Set color to white
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Ensures the text stays on one line
                ),
              const SizedBox(height: 20),
              if (_resultText != null)
                Text(
                  _resultText!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),
              if (_resultText != null)
                GestureDetector(
                  onTap: _navigateToFeedback,
                  child: const Text(
                    'Show Result',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

