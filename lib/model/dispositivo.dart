import 'dart:convert';

class Dispositivo {
  String idsensor;
  String nombresensor;
  Dispositivo({
    required this.idsensor,
    required this.nombresensor,
  });

  Map<String, dynamic> toMap() {
    return {
      'idsensor': idsensor,
      'nombresensor': nombresensor,
    };
  }

  factory Dispositivo.fromMap(Map<String, dynamic> map) {
    return Dispositivo(
      idsensor: map['idsensor'] ?? '',
      nombresensor: map['nombresensor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Dispositivo.fromJson(String source) =>
      Dispositivo.fromMap(json.decode(source));
}
