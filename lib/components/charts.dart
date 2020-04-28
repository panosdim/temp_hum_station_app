import 'package:THS/model/sensor_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartsWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ChartsWidget(this.seriesList, {this.animate});

  factory ChartsWidget.withData(List<SensorData> data) {
    return new ChartsWidget(_createDailyData(data));
  }

  static List<charts.Series<TimeSeriesData, DateTime>> _createDailyData(
      List<SensorData> data) {
    List<TimeSeriesData> dailyData = [];
    data.forEach((f) => dailyData.add(new TimeSeriesData(f.date, f.temp)));

    return [
      new charts.Series<TimeSeriesData, DateTime>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesData temp, _) => temp.time,
        measureFn: (TimeSeriesData temp, _) => temp.value,
        data: dailyData,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

/// Sample time series data type.
class TimeSeriesData {
  final DateTime time;
  final double value;

  TimeSeriesData(this.time, this.value);
}