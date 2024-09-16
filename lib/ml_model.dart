import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'package:collection/collection.dart';

class MLModel {
  static Interpreter? _interpreter;

  static Future<void> loadModel() async {
    // Load the TensorFlow Lite model
    _interpreter = await Interpreter.fromAsset('model.tflite');
    print('Model loaded');
  }

  static Future<List<dynamic>?> predict(List<double> inputs) async {
    // Check if the interpreter is loaded
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }

    // Prepare input data
    var input = Float32List.fromList(inputs);

    // Create a buffer for the output
    var output = List.filled(1, 0.0)
        .reshape([1, 1]); // Adjust size according to model output

    // Run the model
    _interpreter?.runForMultipleInputs([input], [output] as Map<int, Object>);

    return output[0];
  }
}
