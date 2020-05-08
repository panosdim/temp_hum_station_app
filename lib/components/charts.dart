import 'package:THS/model/sensor_data.dart';
import 'package:THS/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartsWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ChartsWidget(this.seriesList, {this.animate});

  factory ChartsWidget.allTimeData(List<SensorData> data) {
    return new ChartsWidget(_createData(data));
  }

  factory ChartsWidget.monthlyData(List<SensorData> data) {
    final List<SensorData> _monthData =
        data.where((i) => isSameMonth(i.date, new DateTime.now())).toList();

    return new ChartsWidget(_createData(_monthData));
  }

  factory ChartsWidget.dailyData(List<SensorData> data) {
    final List<SensorData> _todayData =
        data.where((i) => isSameDate(i.date, new DateTime.now())).toList();

    return new ChartsWidget(_createData(_todayData));
  }

  static List<charts.Series<TimeSeriesData, DateTime>> _createData(
      List<SensorData> data) {
    List<TimeSeriesData> tempData = [];
    List<TimeSeriesData> humData = [];

    for (var item in data) {
      tempData.add(new TimeSeriesData(item.date, item.temp));
      humData.add(new TimeSeriesData(item.date, item.hum));
    }

    return [
      new charts.Series<TimeSeriesData, DateTime>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesData temp, _) => temp.time,
        measureFn: (TimeSeriesData temp, _) => temp.value,
        data: tempData,
      ),
      new charts.Series<TimeSeriesData, DateTime>(
        id: 'Humidity',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesData hum, _) => hum.time,
        measureFn: (TimeSeriesData hum, _) => hum.value,
        data: humData,
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
