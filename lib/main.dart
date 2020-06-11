import 'package:flutter/material.dart';

void main() {
  runApp(MeasureApp());
}

class MeasureApp extends StatefulWidget {
  @override
  _MeasureAppState createState() => _MeasureAppState();
}

class _MeasureAppState extends State<MeasureApp> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This Conversion cannot be performed';
    } else {
      _resultMessage =
          '${numberform.toString()} $_startmeasure are ${result.toString()} $_convertedmeasure';
    }

    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  String _resultMessage;
  double numberform;
  final title = 'Measure Converted';
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
  String _startmeasure;
  String _convertedmeasure;
  final TextStyle inputStyle = TextStyle(color: Colors.grey, fontSize: 20);
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );
  @override
  void initState() {
    numberform = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Spacer(),
              Text(
                'Value',
                style: labelStyle,
              ),
              Spacer(),
              TextField(
                style: inputStyle,
                decoration: InputDecoration(
                    hintText: 'Please insert the measure to be converted'),
                onChanged: (text) {
                  var r = double.tryParse(text);
                  if (r != numberform) {
                    setState(() {
                      r = numberform;
                    });
                  }
                },
              ),
              Spacer(),
              Text(
                'From',
                style: labelStyle,
              ),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                value: _startmeasure,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startmeasure = value;
                  });
                },
              ),
              Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              Spacer(),
              DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    _convertedmeasure = value;
                  },
                  value: _convertedmeasure),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                child: Text('Convert', style: inputStyle),
                onPressed: () {
                  if (_startmeasure.isEmpty ||
                      _convertedmeasure.isEmpty ||
                      numberform == 0) {
                    return;
                  } else {
                    convert(numberform, _startmeasure, _convertedmeasure);
                  }
                },
              ),
              Spacer(
                flex: 2,
              ),
              Text((_resultMessage == null) ? '' : _resultMessage,
                  style: labelStyle),
            ]),
          ),
        ),
      ),
    );
  }
}
