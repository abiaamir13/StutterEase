import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Interpreter> loadModel() async {
  final interpreter = await Interpreter.fromAsset('assets/models/word.tflite');
  return interpreter;
}

Future<List<String>> loadLabels() async {
  final labelsFile = await rootBundle.loadString('assets/labels/word_labels.txt');
  final labels = labelsFile.split('\n');
  return labels;
}
