import 'package:THS/model/sensor_data.dart';
import 'package:THS/repositories/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableWidget extends StatefulWidget {
  DataTableWidget({Key key}) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  Future<List<SensorData>> sensorData;
  final f = new DateFormat('dd-MM-yyyy HH:00');

  @override
  void initState() {
    super.initState();
    sensorData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SensorData>>(
      future: sensorData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data.length,
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
                              f.format(snapshot.data.elementAt(index).date),
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
                                snapshot.data
                                        .elementAt(index)
                                        .temp
                                        .toStringAsFixed(2) +
                                    " \u2103",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                                snapshot.data
                                        .elementAt(index)
                                        .hum
                                        .toStringAsFixed(2) +
                                    " \u0025",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
