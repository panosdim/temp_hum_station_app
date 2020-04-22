import 'package:THS/model/sensor_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<SensorData>> fetchData() async {
  final _baseUrl = 'http://192.168.10.7:8080';
  final response = await http.get('$_baseUrl/api/v1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseData = json.decode(response.body)["data"] as List;
    return responseData
        .map((sensorDataJson) => SensorData.fromJson(sensorDataJson))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load sensor data');
  }
}
