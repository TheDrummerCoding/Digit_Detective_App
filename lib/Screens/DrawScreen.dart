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
                )
              ],
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
                },
                child: CustomPaint(
                  painter: DrawingPainter(_points),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _initModel() async {
    var res = await _recognizer.loadModel();
    print(res);
  }
}
