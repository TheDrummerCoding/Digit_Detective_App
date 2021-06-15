import 'package:digit_detective_app/Screens/Utils/Constants.dart';
import 'package:tflite/tflite.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

final canvasCullRect = Rect.fromPoints(
    Offset(0, 0), Offset(Constants.imageSize, Constants.imageSize));

final _bgPaint = Paint()..color = Colors.black;

class Recognizer {
  Rect get _canvasCullRect => null;

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

  Future recognize(List<Offset> points) async {}

  Picture _pointsToPicture(List<Offset> points) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, _canvasCullRect)
      ..scale(Constants.mnistImageSize / Constants.canvaSize);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, Constants.imageSize, Constants.imageSize),
        _bgPaint);
  }
}
