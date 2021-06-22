import 'dart:typed_data';

import 'package:digit_detective_app/Models/Prediction.dart';
import 'package:digit_detective_app/Screens/Prediction_Widget.dart';
import 'package:digit_detective_app/Screens/Utils/Constants.dart';
import 'package:digit_detective_app/Services/Recognizer.dart';
import 'package:digit_detective_app/Screens/Drawing_Painter.dart';
import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({Key key}) : super(key: key);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final _points = List<Offset>();
  final _recognizer = Recognizer();
  List<Prediction> _prediction = [];
  bool initializated = false;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "avenir"),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            "Digit Detective",
            style: TextStyle(fontSize: 24),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _prediction.clear();
              _points.clear();
            });
          },
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Mr. Digit Detective will guess the number",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "The digits have been sized-normalized and centered in a fixed-size images (28 x 28)")
                      ],
                    ),
                  ),
                ),
                _mnistImagePreview()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: Constants.canvaSize + Constants.borderSize * 2,
              height: Constants.canvaSize + Constants.borderSize * 2,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: Constants.borderSize)),
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  Offset _localPosition = details.localPosition;
                  if (_localPosition.dx >= 0 &&
                      _localPosition.dx <= Constants.canvaSize &&
                      _localPosition.dy >= 0 &&
                      _localPosition.dy <= Constants.canvaSize) {
                    setState(() {
                      _points.add(_localPosition);
                    });
                  }
                },
                onPanEnd: (DragEndDetails details) {
                  _points.add(null);
                  _recognize();
                },
                child: CustomPaint(
                  painter: DrawingPainter(_points),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: PredictionWidget(
                predictions: _prediction,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _mnistImagePreview() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: FutureBuilder(
        future: _previewImage(),
        builder: (BuildContext, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data,
              fit: BoxFit.fill,
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  void _initModel() async {
    var res = await _recognizer.loadModel();
  }

  Future<Uint8List> _previewImage() async {
    return await _recognizer.previewImage(_points);
  }

  void _recognize() async {
    List<dynamic> pred = await _recognizer.recognize(_points);
    setState(() {
      _prediction = pred.map((json) => Prediction.fromJson(json)).toList();
    });
  }
}
