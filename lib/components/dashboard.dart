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
  SensorData _maxTempToday, _minTempToday, _maxTempMonth, _minTempMonth;
  SensorData _maxHumToday, _minHumToday, _maxHumMonth, _minHumMonth;

  @override
  void initState() {
    super.initState();
    final List<SensorData> _todayData = widget.sensorData
        .where((i) => isSameDate(i.date, new DateTime.now()))
        .toList();

    final List<SensorData> _monthData = widget.sensorData
        .where((i) => isSameMonth(i.date, new DateTime.now()))
        .toList();

    _maxTempToday =
        _todayData.reduce((curr, next) => curr.temp > next.temp ? curr : next);

    _minTempToday =
        _todayData.reduce((curr, next) => curr.temp < next.temp ? curr : next);

    _maxTempMonth =
        _monthData.reduce((curr, next) => curr.temp > next.temp ? curr : next);

    _minTempMonth =
        _monthData.reduce((curr, next) => curr.temp < next.temp ? curr : next);

    _maxHumToday =
        _todayData.reduce((curr, next) => curr.hum > next.hum ? curr : next);

    _minHumToday =
        _todayData.reduce((curr, next) => curr.hum < next.hum ? curr : next);

    _maxHumMonth =
        _monthData.reduce((curr, next) => curr.hum > next.hum ? curr : next);

    _minHumMonth =
        _monthData.reduce((curr, next) => curr.hum < next.hum ? curr : next);
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
                            Text(
                              'Today',
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                                "Max " +
                                    _maxTempToday.temp.toStringAsFixed(2) +
                                    " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                "Min " +
                                    _minTempToday.temp.toStringAsFixed(2) +
                                    " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Month',
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                                "Max " +
                                    _maxTempMonth.temp.toStringAsFixed(2) +
                                    " \u2103",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                "Min " +
                                    _minTempMonth.temp.toStringAsFixed(2) +
                                    " \u2103",
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
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.humidity,
                        size: 50,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Today',
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                                "Max " +
                                    _maxHumToday.hum.toStringAsFixed(2) +
                                    " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                "Min " +
                                    _minHumToday.hum.toStringAsFixed(2) +
                                    " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Month',
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                                "Max " +
                                    _maxHumMonth.hum.toStringAsFixed(2) +
                                    " \u0025",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                "Min " +
                                    _minHumMonth.hum.toStringAsFixed(2) +
                                    " \u0025",
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
