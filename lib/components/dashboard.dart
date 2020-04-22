import 'package:THS/custom_icons_icons.dart';
import 'package:THS/model/sensor_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardWidget extends StatefulWidget {
  DashboardWidget({
    Key key,
    this.sensorData,
  }) : super(key: key);

  final List<SensorData> sensorData;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final f = new DateFormat('dd-MM-yyyy HH:00');
  String _maxTempToday,
      _minTempToday,
      _maxTempMonth,
      _minTempMonth,
      _maxTempAllTime,
      _minTempAllTime;
  String _maxHumToday,
      _minHumToday,
      _maxHumMonth,
      _minHumMonth,
      _maxHumAllTime,
      _minHumAllTime;

  @override
  void initState() {
    super.initState();
    final List<SensorData> _todayData = widget.sensorData
        .where((i) => isSameDate(i.date, new DateTime.now()))
        .toList();

    final List<SensorData> _monthData = widget.sensorData
        .where((i) => isSameMonth(i.date, new DateTime.now()))
        .toList();

    if (_todayData.length == 0) {
      _maxTempToday = "-";
      _minTempToday = "-";
      _maxHumToday = "-";
      _minHumToday = "-";
    } else {
      _maxTempToday = _todayData
          .reduce((curr, next) => curr.temp > next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _minTempToday = _todayData
          .reduce((curr, next) => curr.temp < next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _maxHumToday = _todayData
          .reduce((curr, next) => curr.hum > next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);

      _minHumToday = _todayData
          .reduce((curr, next) => curr.hum < next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);
    }

    if (_monthData.length == 0) {
      _maxTempMonth = "-";
      _minTempMonth = "-";
      _maxHumMonth = "-";
      _minHumMonth = "-";
    } else {
      _maxTempMonth = _monthData
          .reduce((curr, next) => curr.temp > next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _minTempMonth = _monthData
          .reduce((curr, next) => curr.temp < next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _maxHumMonth = _monthData
          .reduce((curr, next) => curr.hum > next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);

      _minHumMonth = _monthData
          .reduce((curr, next) => curr.hum < next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);
    }

    if (widget.sensorData.length == 0) {
      _maxTempAllTime = "-";
      _minTempAllTime = "-";
      _maxHumAllTime = "-";
      _minHumAllTime = "-";
    } else {
      _maxTempAllTime = widget.sensorData
          .reduce((curr, next) => curr.temp > next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _minTempAllTime = widget.sensorData
          .reduce((curr, next) => curr.temp < next.temp ? curr : next)
          .temp
          .toStringAsFixed(2);

      _maxHumAllTime = widget.sensorData
          .reduce((curr, next) => curr.hum > next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);

      _minHumAllTime = widget.sensorData
          .reduce((curr, next) => curr.hum < next.hum ? curr : next)
          .hum
          .toStringAsFixed(2);
    }
  }

  bool isSameDate(DateTime that, DateTime other) {
    DateTime a = that.toLocal();
    DateTime b = other.toLocal();
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isSameMonth(DateTime that, DateTime other) {
    DateTime a = that.toLocal();
    DateTime b = other.toLocal();
    return a.year == b.year && a.month == b.month;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 32),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.temperatire,
                        size: 50,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxTempToday + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minTempToday + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Icon(
                        CustomIcons.humidity,
                        size: 50,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxHumToday + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minHumToday + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Month',
                    style: TextStyle(fontSize: 32),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.temperatire,
                        size: 50,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxTempMonth + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minTempMonth + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Icon(
                        CustomIcons.humidity,
                        size: 50,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxHumMonth + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minHumMonth + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'All Time',
                    style: TextStyle(fontSize: 32),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.temperatire,
                        size: 50,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxTempAllTime + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minTempAllTime + " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Icon(
                        CustomIcons.humidity,
                        size: 50,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Max " + _maxHumAllTime + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Min " + _minHumAllTime + " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
