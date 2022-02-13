import 'dart:convert';

class SensorModel {
  final DateTime tiempoLectura;
  final dynamic ele;
  final String idSensor;
  final dynamic lat;
  final dynamic lon;
  final String nombreSensor;
  final String tipoLectura;
  final dynamic valorRuido;
  SensorModel({
    required this.tiempoLectura,
    required this.ele,
    required this.idSensor,
    required this.lat,
    required this.lon,
    required this.nombreSensor,
    required this.tipoLectura,
    required this.valorRuido,
  });

  Map<String, dynamic> toMap() {
    return {
      'tiempoLectura': tiempoLectura.millisecondsSinceEpoch,
      'ele': ele,
      'idSensor': idSensor,
      'lat': lat,
      'lon': lon,
      'nombreSensor': nombreSensor,
      'tipoLectura': tipoLectura,
      'valorRuido': valorRuido,
    };
  }

  factory SensorModel.fromMap(Map<String, dynamic> map) {
    return SensorModel(
      tiempoLectura: DateTime.fromMillisecondsSinceEpoch(map['tiempo_lectura']),
      ele: map['ele'] ?? null,
      idSensor: map['idsensor'] ?? '',
      lat: map['lat'] ?? null,
      lon: map['lon'] ?? null,
      nombreSensor: map['nombresensor'] ?? '',
      tipoLectura: map['tipolectura'] ?? '',
      valorRuido: map['valorruido'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorModel.fromJson(String source) =>
      SensorModel.fromMap(json.decode(source));
}
