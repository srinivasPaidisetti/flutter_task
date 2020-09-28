import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

import 'package:flutter/material.dart';

class TemperatureSlider extends StatefulWidget {
  final Function updatedValues;
  final double minValue;
  final double maxValue;

  const TemperatureSlider(
      {Key key, this.updatedValues, this.minValue, this.maxValue})
      : super(key: key);

  @override
  _TemperatureSliderState createState() => _TemperatureSliderState();
}

class _TemperatureSliderState extends State<TemperatureSlider> {
  double _lowerValue = -25.0;
  double _upperValue = 10.0;
  double minValue;
  double maxValue;

  @override
  void initState() {
    if (widget.minValue != null) _lowerValue = widget.minValue;
    if (widget.maxValue != null) _upperValue = widget.maxValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: Column(children: <Widget>[
            frs.RangeSlider(
              min: -25.0,
              max: 10.0,
              lowerValue: _lowerValue,
              upperValue: _upperValue,
              divisions: 10,
              showValueIndicator: true,
              valueIndicatorMaxDecimals: 1,
              onChanged: (double newLowerValue, double newUpperValue) {
                setState(() {
                  minValue = newLowerValue;
                  maxValue = newUpperValue;
                  _lowerValue = newLowerValue;
                  _upperValue = newUpperValue;
                });
              },
              onChangeStart: (double startLowerValue, double startUpperValue) {
                print(
                    'Started with values: $startLowerValue and $startUpperValue');
              },
              onChangeEnd: (double newLowerValue, double newUpperValue) {
                print('Ended with values: $newLowerValue and $newUpperValue');
              },
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    '${minValue != null ? minValue : '0'} °c \n\n Min',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    '${maxValue != null ? maxValue : '0'} °c \n\n Max',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                widget.updatedValues(minValue, maxValue);
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 60,
                  width: 200,
                  color: Colors.red,
                  child: Center(
                      child: Text(
                    'update Values'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
