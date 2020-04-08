import 'package:THS/model/sensor_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableWidget extends StatefulWidget {
  DataTableWidget({
    Key key,
    this.sensorData,
  }) : super(key: key);

  final List<SensorData> sensorData;

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final f = new DateFormat('dd-MM-yyyy HH:00');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: widget.sensorData.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        f.format(widget.sensorData.elementAt(index).date),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          widget.sensorData
                                  .elementAt(index)
                                  .temp
                                  .toStringAsFixed(2) +
                              " \u2103",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                      Text(
                          widget.sensorData
                                  .elementAt(index)
                                  .hum
                                  .toStringAsFixed(2) +
                              " \u0025",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
