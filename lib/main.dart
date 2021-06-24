import 'package:flutter/material.dart';
import 'package:staggercalc/functions/calc_stagger.dart';
import 'package:staggercalc/functions/format_stagger.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:staggercalc/models/fractions.dart';
import 'models/pair.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Lock orientation in Portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
  int _maxSize = 150;
  int _minSize = 0;
  double _stagger = 0.0;
  String _formattedStagger = "0";
  List<Pair> _history = [];
  int _historyLength = 20;
  var _pair;

  int _changeCounter(bool increment, int size) {
    if (increment) {
      if (size == _maxSize) {
        return _minSize;
      } else {
        return size += 1;
      }
    } else {
      if (size == _minSize) {
        return _maxSize;
      } else {
        return size -= 1;
      }
    }
  }

  void _calcStagger() {
    _stagger = calcStagger(_counterA, _counterB, eighths[_fractionIndexA],
        eighths[_fractionIndexB]);
    setState(() {
      _formattedStagger = formatStagger(_stagger);
    });
  }

  void _resetValues() {
    setState(() {
      _counterA = 84;
      _counterB = 84;
      _fractionIndexA = 0;
      _fractionIndexB = 0;
      _calcStagger();
    });
  }

  void _addToHistory() {
    _pair = Pair(
        tireA: _counterA.toString() +
            (_fractionIndexA == 0 ? '' : ' ' + eighths[_fractionIndexA]),
        tireB: _counterB.toString() +
            (_fractionIndexB == 0 ? '' : ' ' + eighths[_fractionIndexB]),
        tireDiff: _formattedStagger);

    // _pair.tireA.whole = _counterA.toString();
    // _pair.tireA.fraction = eighths[_fractionIndexA];
    // _pair.tireB.whole = _counterB.toString();
    // _pair.tireB.fraction = eighths[_fractionIndexA];
    // _pair.tireDiff = _formattedStagger;

    if (_history.length >= _historyLength) _history.removeAt(0);

    setState(() {
      _history.add(_pair);
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // History List
            Container(
              color: Colors.grey[400],
              height: 72,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            _history[_history.length - 1 - index]
                                .tireA
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _history[_history.length - 1 - index]
                                .tireB
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _history[_history.length - 1 - index]
                                .tireDiff
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Result
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formattedStagger.split(' ')[0],
                  //style: Theme.of(context).textTheme.headline1,
                  style: TextStyle(fontSize: 140),
                ),
                Text(
                  _formattedStagger.split(' ').length == 2
                      ? '  ' + _formattedStagger.split(' ')[1]
                      : '',
                  //style: Theme.of(context).textTheme.headline3,
                  style: TextStyle(fontSize: 60),
                ),
              ],
            ),
            // Size A
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeDetector(
                  child: Container(
                    //color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '$_counterA',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onSwipeUp: () {
                    setState(() {
                      _counterA = _changeCounter(true, _counterA);
                    });
                    _calcStagger();
                    print('A - Up: $_counterA');
                  },
                  onSwipeDown: () {
                    setState(() {
                      _counterA = _changeCounter(false, _counterA);
                    });
                    _calcStagger();
                    print('A - Down: $_counterA');
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 80.0,
                    verticalSwipeMinDisplacement: 20.0,
                    verticalSwipeMaxWidthThreshold: 100.0,
                  ),
                ),
                SwipeDetector(
                  child: Container(
                    //color: Colors.green,
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
                      _fractionIndexA += 1;
                    });
                    print('A: $_fractionIndexA');
                    _calcStagger();
                  },
                  onSwipeDown: () {
                    if (_fractionIndexA == 0) {
                      _fractionIndexA = 8;
                    }
                    setState(() {
                      _fractionIndexA -= 1;
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
            // Size B
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeDetector(
                  child: Container(
                    //color: Colors.blue[300],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '$_counterB',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onSwipeUp: () {
                    setState(() {
                      _counterB = _changeCounter(true, _counterB);
                    });
                    _calcStagger();
                    print('B - Up: $_counterB');
                  },
                  onSwipeDown: () {
                    setState(() {
                      _counterB = _changeCounter(false, _counterB);
                    });
                    _calcStagger();
                    print('B - Down: $_counterB');
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 80.0,
                    verticalSwipeMinDisplacement: 20.0,
                    verticalSwipeMaxWidthThreshold: 100.0,
                  ),
                ),
                SwipeDetector(
                  child: Container(
                    //color: Colors.green[300],
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
                      _fractionIndexB += 1;
                    });
                    print('B: $_fractionIndexB');
                    _calcStagger();
                  },
                  onSwipeDown: () {
                    if (_fractionIndexB == 0) {
                      _fractionIndexB = 8;
                    }
                    setState(() {
                      _fractionIndexB -= 1;
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
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _calcStagger,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.adb),
      // ),
      bottomNavigationBar: Container(
        child: BottomAppBar(
          child: Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () {
                  _resetValues();
                },
                icon: Icon(Icons.refresh),
                color: Colors.grey,
              ),
              Spacer(),
              Spacer(),
              IconButton(
                onPressed: () {
                  _addToHistory();
                },
                icon: Icon(Icons.save),
                color: Colors.grey,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
