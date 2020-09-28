import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/temperature_bottom_slider.dart';

import 'email_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RangeSlider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureSlider(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double minValue = -25.0;
  double maxValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Min value : ${minValue.toString()}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Max value : ${maxValue.toString()}",
                style: TextStyle(fontSize: 20))
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: showTemperatureBottomSheet,
        child: Container(
          height: 60,
          color: Colors.red,
          child: Center(
              child: Text(
            'update Values'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void showTemperatureBottomSheet() {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(46), topRight: Radius.circular(46)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bContext) {
          return TemperatureSlider(
            maxValue: maxValue,
            minValue: minValue,
            updatedValues: (min, max) {
              if (mounted) {
                setState(() {
                  minValue = min;
                  maxValue = max;
                });
              }
            },
          );
        });
  }
}
