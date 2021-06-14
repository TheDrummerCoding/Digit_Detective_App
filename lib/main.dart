import 'dart:async';

import 'package:flutter/material.dart';

import 'Screens/WelcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogoPage(),
    );
  }
}

class MyLogoPage extends StatefulWidget {
  const MyLogoPage({Key key}) : super(key: key);

  @override
  _MyLogoPageState createState() => _MyLogoPageState();
}

class _MyLogoPageState extends State<MyLogoPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), openWelcomePage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/image/digitdetectivelogo.png")),
        ),
      ),
    ));
  }

  void openWelcomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
