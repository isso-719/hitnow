import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hitnow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'hitnow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _stats = "Push to Start.";
  bool _isVisibleStart = true;
  bool _isVisibleHitNow = false;
  DateTime startTime;
  DateTime endTime;

  double randomDoubleInRange({double min = 0.0, double max = 1.0}) {
    return Random().nextDouble() * (max - min + 1) + min;
  }

  void _hitnow() async {
    setState(() {
      _isVisibleStart = !_isVisibleStart;
      _stats = "...";
    });

    int randSec = (5 + 5 * randomDoubleInRange()).round();
    await new Future.delayed(Duration(seconds: randSec));

    setState(() {
      _stats = "hitnow!";
      _isVisibleHitNow = !_isVisibleHitNow;
    });

    startTime = DateTime.now();
  }

  void _hit() {
    endTime = DateTime.now();
    var result = endTime.difference(startTime);
    var resMicroSec = result.inMicroseconds;
    var resSec = result.inSeconds;
    setState(() {
      _stats = resSec.toString() + "." + resMicroSec.toString();
      _isVisibleStart = !_isVisibleStart;
      _isVisibleHitNow = !_isVisibleHitNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_stats',
              style: Theme.of(context).textTheme.headline4,
            ),
            Visibility(
              visible: _isVisibleStart,
              child: ElevatedButton(
                child: const Text("Start"),
                onPressed: _hitnow,
              ),
            ),
            Visibility(
              visible: _isVisibleHitNow,
              child: ElevatedButton(
                child: const Text("hitnow"),
                onPressed: _hit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
