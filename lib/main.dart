import 'package:flutter/material.dart';
import 'package:staggercalc/functions/calc_stagger.dart';
import 'package:staggercalc/functions/format_stagger.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:staggercalc/models/fractions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stagger Demo'),
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
  int _counterA = 84;
  int _counterB = 84;
  int _fractionIndexA = 0;
  int _fractionIndexB = 0;
  double _stagger = 0.0;
  String _formattedStagger = "";

  void _incrementCounter() {
    setState(() {
      //_counter++;
    });
  }

  void _calcStagger() {
    _stagger = calcStagger(_counterA, _counterB, eighths[_fractionIndexA],
        eighths[_fractionIndexB]);
    setState(() {
      _formattedStagger = formatStagger(_stagger);
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
              _formattedStagger,
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeDetector(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '$_counterA',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onSwipeUp: () {
                    setState(() {
                      _counterA = _counterA + 1;
                    });
                    _calcStagger();
                    print('A - Up: $_counterA');
                  },
                  onSwipeDown: () {
                    setState(() {
                      _counterA = _counterA - 1;
                    });
                    _calcStagger();
                    print('A - Down: $_counterA');
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 50.0,
                    verticalSwipeMaxWidthThreshold: 100.0,
                  ),
                ),
                SwipeDetector(
                  child: Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '${eighths[_fractionIndexA]}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  onSwipeUp: () {
                    if (_fractionIndexA == 7) {
                      _fractionIndexA = -1;
                    }
                    setState(() {
                      _fractionIndexA = _fractionIndexA + 1;
                    });
                    print('A: $_fractionIndexA');
                    _calcStagger();
                  },
                  onSwipeDown: () {
                    if (_fractionIndexA == 0) {
                      _fractionIndexA = 8;
                    }
                    setState(() {
                      _fractionIndexA = _fractionIndexA - 1;
                    });
                    print('A: $_fractionIndexA');
                    _calcStagger();
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 20.0,
                    verticalSwipeMaxWidthThreshold: 50.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeDetector(
                  child: Container(
                    color: Colors.blue[300],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '$_counterB',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onSwipeUp: () {
                    setState(() {
                      _counterB = _counterB + 1;
                    });
                    _calcStagger();
                    print('B - Up: $_counterB');
                  },
                  onSwipeDown: () {
                    setState(() {
                      _counterB = _counterB - 1;
                    });
                    _calcStagger();
                    print('B - Down: $_counterB');
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 50.0,
                    verticalSwipeMaxWidthThreshold: 100.0,
                  ),
                ),
                SwipeDetector(
                  child: Container(
                    color: Colors.green[300],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '${eighths[_fractionIndexB]}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  onSwipeUp: () {
                    if (_fractionIndexB == 7) {
                      _fractionIndexB = -1;
                    }
                    setState(() {
                      _fractionIndexB = _fractionIndexB + 1;
                    });
                    print('B: $_fractionIndexB');
                    _calcStagger();
                  },
                  onSwipeDown: () {
                    if (_fractionIndexB == 0) {
                      _fractionIndexB = 8;
                    }
                    setState(() {
                      _fractionIndexB = _fractionIndexB - 1;
                    });
                    print('B: $_fractionIndexB');
                    _calcStagger();
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 20.0,
                    verticalSwipeMaxWidthThreshold: 50.0,
                  ),
                ),
              ],
            ),
            // ListWheelScrollView.useDelegate(
            //   itemExtent: 50,
            //   childDelegate: ListWheelChildBuilderDelegate(
            //     builder: (context, index) => Container(
            //       color: Colors.orange,
            //       child: Center(
            //         child: Text('Item $index'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcStagger,
        tooltip: 'Increment',
        child: Icon(Icons.adb),
      ),
    );
  }
}
