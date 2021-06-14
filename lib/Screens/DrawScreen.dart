import 'package:digit_detective_app/Services/Recognizer.dart';
import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({Key key}) : super(key: key);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
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
          onPressed: () {},
        ),
        body: Column(
          children: [
            Row(
              children: [Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Text("Mr. Digit Detective will guess the number", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("The digits have been sized-normalized and centered in a fixed-size images (28 x 28)")],
                  ),
                ),
              )],
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
