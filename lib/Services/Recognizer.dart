import 'package:tflite/tflite.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

class Recognizer {
  Future loadModel() {
    Tflite.close();

    return Tflite.loadModel(
      model: "asset/mnist.tflite",
      labels: "asset/mnist.txt",
    );
  }

  dispose() {
    Tflite.close();
  }
}
