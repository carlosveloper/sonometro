import 'dart:convert';

class Usuario {
  final String email;
  final String nombres;
  Usuario({
    required this.email,
    required this.nombres,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nombres': nombres,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      email: map['email'] ?? '',
      nombres: map['nombres'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
