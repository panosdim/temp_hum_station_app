class SensorData {
  final DateTime date;
  final double temp;
  final double hum;

  const SensorData({this.date, this.temp, this.hum});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['Date'] as int, isUtc: true),
      temp: json['temperature'].toDouble(),
      hum: json['humidity'].toDouble(),
    );
  }
}