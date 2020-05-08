import 'dart:core';

import 'package:THS/components/bottom_bar.dart';
import 'package:THS/components/charts.dart';
import 'package:THS/components/dashboard.dart';
import 'package:THS/components/data_table.dart';
import 'package:THS/model/sensor_data.dart';
import 'package:THS/repositories/fetch_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Humidity Station',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Temperature Humidity Station'),
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
  Future<List<SensorData>> sensorData;
  int _active = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    sensorData = fetchData();
  }

  void _handleBottomBarChanged(int newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder<List<SensorData>>(
          future: this.sensorData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _children = [
                DashboardWidget(sensorData: snapshot.data),
                DataTableWidget(sensorData: snapshot.data),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "All Time",
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: ChartsWidget.allTimeData(snapshot.data)),
                  Text(
                    "Month",
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: ChartsWidget.monthlyData(snapshot.data)),
                  Text(
                    "Today",
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: ChartsWidget.dailyData(snapshot.data)),
                ]),
              ];
              return _children[_active];
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        onChanged: _handleBottomBarChanged,
      ),
    );
  }
}
