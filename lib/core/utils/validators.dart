import 'dart:async';
import 'dart:io';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Correo inválido');
    }
  });

  final validarNombresApellido = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    var pattern = r'^([a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{8,25})$';
    var regExp = RegExp(pattern);

    if (regExp.hasMatch(nombre)) {
      sink.add(nombre);
    } else {
      sink.addError('Nombres y apellidos completos');
    }
  });

  final validarNombres = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    var pattern = r'^([a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{3,25})$';
    var regExp = RegExp(pattern);

    if (regExp.hasMatch(nombre)) {
      sink.add(nombre);
    } else {
      sink.addError('Nombres completos');
    }
  });

  final validarNumeroCuenta = StreamTransformer<String, String>.fromHandlers(
      handleData: (cuenta, sink) {
    if (cuenta.length >= 4) {
      sink.add(cuenta);
    } else {
      sink.addError('Asegurate de escribir bien el numero de cuenta');
    }
  });

  final validarApellidos = StreamTransformer<String, String>.fromHandlers(
      handleData: (apellidos, sink) {
    var pattern = r'^([a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{3,25})$';
    var regExp = RegExp(pattern);

    if (regExp.hasMatch(apellidos)) {
      sink.add(apellidos);
    } else {
      sink.addError('Apellidos completos');
    }
  });

  final validarTelefono = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefono, sink) {
    if (telefono.length < 11) {
      sink.add(telefono);
    } else {
      sink.addError('Asegurate que el teléfono sea valido');
    }
  });

  final validarCelular = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefono, sink) {
    if (telefono.length < 10) {
      sink.add(telefono);
    } else {
      sink.addError('Asegurate que el número sea valido');
    }
  });

  final validarPrecio = StreamTransformer<String, String>.fromHandlers(
      handleData: (precio, sink) {
    try {
      var _onlyDigits = precio.replaceAll(RegExp('[^0-9]'), '');

      var _doubleValue = double.parse(_onlyDigits) / 100;

      if (_doubleValue <= 0.0) {
        sink.addError('El valor debe ser mayor a 0');
      } else {
        sink.add(_doubleValue.toString());
      }
    } catch (e) {
      sink.addError('El valor debe ser mayor a 0');
    }
  });

  final validarDescripcion = StreamTransformer<String, String>.fromHandlers(
      handleData: (descripcion, sink) {
    if (descripcion.isNotEmpty) {
      sink.add(descripcion);
    } else {
      sink.addError('Agregue la descripcion por favor');
    }
  });

  final validarImagen =
      StreamTransformer<File, File>.fromHandlers(handleData: (file, sink) {
    // ignore: unnecessary_null_comparison
    if (file != null) {
      sink.add(file);
    } else {
      sink.addError('Agregue la imagen');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password);
    } else {
      sink.addError('Mínimo 8 caracteres');
    }
  });
}
